package com.sulake.habbo.freeflowchat.viewer
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.ChatHistoryEntryBitmapBubble;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.ChatHistoryRoomChangeEntry;
   import com.sulake.habbo.freeflowchat.history.visualization.entry.IChatHistoryEntryBitmapBubble;
   import com.sulake.habbo.freeflowchat.viewer.simulation.BlankStyle;
   import com.sulake.habbo.freeflowchat.viewer.visualization.ChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyleLibrary;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.IChatStyle;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.utils.HabboFaceFocuser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.utils.getTimer;
   
   public class ChatBubbleFactory implements UnknownIHabboRoom1, UnknownIHabboAvatar1
   {
      private static const MAX_DISPOSABLE_BITMAPS:int = 30;
      
      private static const SPECIAL_SYSTEM_TYPE_EXPRESSION_67:int = 67;
      
      private var UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var _chatStyleLibrary:ChatStyleLibrary;
      
      private var _avatarImageCache:Map = new Map();
      
      private var _petImageCache:Map = new Map();
      
      private var _avatarColorCache:Map = new Map();
      
      private var _petImageIdToFigureString:Map = new Map();
      
      private var UnknownVarFromChatBubbleFactory_Array_1:Array = [];
      
      private var UnknownVarFromChatBubbleFactory_Vector_1:Vector.<PooledChatBubble> = new Vector.<PooledChatBubble>(0);
      
      public function ChatBubbleFactory(param1:HabboFreeFlowChat)
      {
         super();
         UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1 = param1;
         _chatStyleLibrary = new ChatStyleLibrary(UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.assets);
      }
      
      public function dispose() : void
      {
         discardOldBitmaps();
         UnknownVarFromChatBubbleFactory_Array_1 = [];
         _chatStyleLibrary.dispose();
         _chatStyleLibrary = null;
         UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1 == null;
      }
      
      public function getNewChatBubble(param1:ChatItem, param2:Boolean = false) : PooledChatBubble
      {
         var _loc7_:String = null;
         var _loc10_:IRoomObject = null;
         var _loc5_:String = null;
         var _loc14_:Boolean = false;
         var _loc6_:int = 0;
         var _loc15_:int = 0;
         var _loc11_:PooledChatBubble = null;
         var _loc3_:IUserData = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomSessionManager.getSession(param1.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc8_:String = "";
         if(param1.forcedFigure || param1.forcedUserName)
         {
            _loc8_ = param1.forcedUserName;
         }
         else if(_loc3_ != null)
         {
            _loc8_ = _loc3_.name;
         }
         applySpecialChatContent(param1,_loc8_);
         var _loc13_:ChatStyle = ChatStyle(_chatStyleLibrary.getStyle(param1.style));
         var _loc12_:uint = 0;
         var _loc4_:BitmapData = _loc13_.iconImage;
         if(param1.forcedFigure || param1.forcedUserName)
         {
            if(!_loc4_)
            {
               _loc4_ = getUserImage(param1.forcedFigure);
            }
         }
         else if(_loc3_ != null)
         {
            _loc7_ = _loc3_.figure;
            _loc12_ = _avatarColorCache.getValue(_loc7_);
            if(!_loc4_)
            {
               switch(_loc3_.type - 1)
               {
                  case 0:
                     _loc4_ = getUserImage(_loc7_);
                     break;
                  case 1:
                     _loc10_ = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomEngine.getRoomObject(param1.roomId,_loc3_.roomObjectId,100);
                     _loc5_ = null;
                     if(_loc10_ != null)
                     {
                        _loc5_ = _loc10_.getModel().getString("figure_posture");
                     }
                     _loc14_ = true;
                     _loc6_ = 32;
                     _loc15_ = 2;
                     _loc4_ = getPetImage(_loc7_,_loc15_,_loc14_,_loc6_,_loc5_);
               }
            }
         }
         if(UnknownVarFromChatBubbleFactory_Vector_1.length > 0)
         {
            _loc11_ = UnknownVarFromChatBubbleFactory_Vector_1.pop();
         }
         else
         {
            _loc11_ = new PooledChatBubble(UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1);
         }
         var _loc9_:Object = _loc13_.textFormat.color;
         _loc11_.chatItem = param1;
         _loc11_.style = _loc13_;
         _loc11_.face = _loc4_;
         _loc11_.recreate(_loc8_,!!param1.forcedColor ? param1.forcedColor : _loc12_,UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomChatBorderLimited);
         _loc13_.textFormat.color = _loc9_;
         return _loc11_;
      }
      
      public function getNewEmptySpace(param1:int) : PooledChatBubble
      {
         var _loc4_:PooledChatBubble = null;
         var _loc5_:IChatStyle = new BlankStyle();
         var _loc2_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,-1,"",1);
         var _loc3_:ChatItem = new ChatItem(_loc2_,getTimer());
         if(UnknownVarFromChatBubbleFactory_Vector_1.length > 0)
         {
            _loc4_ = UnknownVarFromChatBubbleFactory_Vector_1.pop();
         }
         else
         {
            _loc4_ = new PooledChatBubble(UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1);
         }
         _loc4_.chatItem = _loc3_;
         _loc4_.style = _loc5_;
         _loc4_.face = null;
         _loc4_.recreate("",0,false,19);
         return _loc4_;
      }
      
      public function getHistoryLineEntry(param1:ChatItem) : IChatHistoryEntryBitmapBubble
      {
         var _loc7_:String = null;
         var _loc9_:IRoomObject = null;
         var _loc5_:String = null;
         var _loc14_:Boolean = false;
         var _loc6_:int = 0;
         var _loc16_:int = 0;
         var _loc2_:IUserData = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomSessionManager.getSession(param1.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc8_:String = "";
         var _loc15_:int = -1;
         var _loc4_:Boolean = false;
         if(param1.forcedFigure || param1.forcedUserName)
         {
            _loc8_ = param1.forcedUserName;
         }
         else if(_loc2_ != null)
         {
            _loc8_ = _loc2_.name;
         }
         applySpecialChatContent(param1,_loc8_);
         var _loc13_:ChatStyle = ChatStyle(_chatStyleLibrary.getStyle(param1.style));
         if(_loc2_ != null && !_loc13_.isNotification && _loc2_.type == 1 && _loc2_.webID > 0 && _loc2_.webID != UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.sessionDataManager.userId)
         {
            _loc15_ = _loc2_.webID;
            _loc4_ = true;
         }
         if(isSystemNotificationChat(param1.chatType))
         {
            _loc4_ = false;
         }
         var _loc12_:uint = 0;
         var _loc3_:BitmapData = _loc13_.iconImage;
         if(param1.forcedFigure || param1.forcedUserName)
         {
            if(!_loc3_)
            {
               _loc3_ = getUserImage(param1.forcedFigure);
            }
         }
         else if(_loc2_ != null)
         {
            _loc7_ = _loc2_.figure;
            _loc12_ = _avatarColorCache.getValue(_loc7_);
            if(!_loc3_)
            {
               switch(_loc2_.type - 1)
               {
                  case 0:
                  case 2:
                  case 3:
                     _loc3_ = getUserImage(_loc7_);
                     break;
                  case 1:
                     _loc9_ = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomEngine.getRoomObject(param1.roomId,_loc2_.roomObjectId,100);
                     _loc5_ = null;
                     if(_loc9_ != null)
                     {
                        _loc5_ = _loc9_.getModel().getString("figure_posture");
                     }
                     _loc14_ = false;
                     _loc6_ = 32;
                     _loc16_ = 2;
                     _loc3_ = getPetImage(_loc7_,_loc16_,_loc14_,_loc6_,_loc5_);
               }
            }
         }
         var _loc10_:ChatBubble = new ChatBubble(param1,_loc13_,_loc3_,_loc8_,!!param1.forcedColor ? param1.forcedColor : _loc12_,UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1,1);
         var _loc11_:BitmapData = new BitmapData(_loc10_.width,_loc10_.height,true,0);
         _loc10_.drawToBitmap(_loc11_);
         return new ChatHistoryEntryBitmapBubble(param1,_loc4_,_loc15_,_loc8_,_loc11_,_loc13_.overlap);
      }
      
      public function getHistoryRoomChangeEntry(param1:GuestRoomData) : IChatHistoryEntryBitmapBubble
      {
         return new ChatHistoryRoomChangeEntry(param1,UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1);
      }
      
      public function recycle(param1:PooledChatBubble) : void
      {
         UnknownVarFromChatBubbleFactory_Vector_1.push(param1);
      }
      
      public function getUserImage(param1:String) : BitmapData
      {
         var _loc5_:IAvatarImage_2 = null;
         var _loc4_:IPartColor = null;
         var _loc3_:Boolean = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.getBoolean("zoom.enabled");
         var _loc2_:BitmapData = _avatarImageCache.getValue(param1) as BitmapData;
         if(_loc2_ == null)
         {
            _loc5_ = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.avatarRenderManager.createAvatarImage(param1,_loc3_ ? "h" : "sh",null,this);
            if(_loc5_ != null)
            {
               _loc2_ = HabboFaceFocuser.focusUserFace(_loc5_,"head",2,_loc3_ ? 0.5 : 1);
               _loc4_ = _loc5_.getPartColor("ch");
               _loc5_.dispose();
               if(_loc4_ != null)
               {
                  _avatarColorCache.add(param1,_loc4_.rgb);
               }
            }
         }
         if(_loc2_ != null)
         {
            _avatarImageCache.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function getPetImage(param1:String, param2:int, param3:Boolean, param4:int = 64, param5:String = null) : BitmapData
      {
         var _loc6_:PetFigureData = null;
         var _loc8_:int = 0;
         var _loc7_:* = 0;
         var _loc11_:Boolean = false;
         var _loc9_:UnknownHabboRoom1 = null;
         var _loc10_:BitmapData = _petImageCache.getValue(param1 + param5) as BitmapData;
         if(_loc10_ == null)
         {
            _loc6_ = new PetFigureData(param1);
            _loc8_ = _loc6_.typeId;
            _loc7_ = 0;
            _loc11_ = false;
            if(35 == _loc8_)
            {
               _loc11_ = true;
            }
            _loc9_ = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomEngine.getPetImage(_loc8_,_loc6_.paletteId,_loc6_.color,new Vector3d(param2 * 45),param4,this,_loc11_,_loc7_,_loc6_.customParts,param5);
            if(_loc9_ != null)
            {
               _loc10_ = _loc9_.data;
               if(_loc9_.id > 0)
               {
                  _petImageIdToFigureString.add(_loc9_.id,_loc6_.figureString);
               }
            }
            _avatarColorCache.add(param1,_loc6_.color);
         }
         if(_loc10_ != null)
         {
            _petImageCache.add(param1 + param5,_loc10_);
         }
         return _loc10_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = _petImageIdToFigureString.remove(param1);
         if(_loc3_ != null)
         {
            petImageReady(_loc3_);
            if(_petImageCache)
            {
               _petImageCache.add(_loc3_,param2);
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function petImageReady(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         if(_petImageCache)
         {
            _loc2_ = _petImageCache.remove(param1) as BitmapData;
            if(_loc2_ != null)
            {
               UnknownVarFromChatBubbleFactory_Array_1.push(_loc2_);
            }
         }
         if(UnknownVarFromChatBubbleFactory_Array_1.length > 30)
         {
            discardOldBitmaps();
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         if(_avatarImageCache)
         {
            _loc2_ = _avatarImageCache.remove(param1) as BitmapData;
            if(_loc2_ != null)
            {
               UnknownVarFromChatBubbleFactory_Array_1.push(_loc2_);
            }
         }
         if(UnknownVarFromChatBubbleFactory_Array_1.length > 30)
         {
            discardOldBitmaps();
         }
      }
      
      private function discardOldBitmaps() : void
      {
         for each(var _loc1_ in UnknownVarFromChatBubbleFactory_Array_1)
         {
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
         }
      }
      
      public function get chatStyleLibrary() : ChatStyleLibrary
      {
         return _chatStyleLibrary;
      }
      
      private function applySpecialChatContent(param1:ChatItem, param2:String) : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param1.chatType == 12)
         {
            switch(param1.extraParam - 67)
            {
               case 0:
                  param1.text = "<b>6666666...  77777777777777...</b>";
                  param1.style = 1;
                  return;
            }
         }
         if(!UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations)
         {
            return;
         }
         if(param1.chatType == 3)
         {
            param1.text = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.getLocalizationWithParams("widgets.chatbubble.respect","","username",param2);
            return;
         }
         if(param1.chatType == 4)
         {
            param1.text = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.getLocalizationWithParams("widget.chatbubble.petrespect","","petname",param2);
            return;
         }
         if(param1.chatType == 6)
         {
            param1.text = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.getLocalizationWithParams("widget.chatbubble.pettreat","","petname",param2);
            return;
         }
         if(param1.chatType == 11)
         {
            if(param1.extraParam >= 0)
            {
               param1.text = "Ping: " + param1.extraParam + " ms";
            }
            else
            {
               param1.text = "Ping: measuring...";
            }
            return;
         }
         if(param1.chatType == 5)
         {
            _loc8_ = "widget.chatbubble.handitem";
            _loc9_ = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.getLocalization("handitem" + param1.extraParam,"handitem" + param1.extraParam);
            UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.registerParameter(_loc8_,"username",param2);
            UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.registerParameter(_loc8_,"handitem",_loc9_);
            param1.text = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.getLocalizationRaw(_loc8_).value;
            param1.style = 1;
            return;
         }
         if(param1.chatType == 10)
         {
            _loc7_ = "widget.chatbubble.mutetime";
            _loc3_ = String(param1.extraParam % 60);
            _loc6_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam % 3600 / 60) : 0);
            _loc4_ = String(param1.extraParam > 0 ? Math.floor(param1.extraParam / 3600) : 0);
            UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.registerParameter(_loc7_,"hours",_loc4_);
            UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.registerParameter(_loc7_,"minutes",_loc6_);
            UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.registerParameter(_loc7_,"seconds",_loc3_);
            param1.text = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.getLocalizationRaw(_loc7_).value;
            param1.style = 1;
            return;
         }
         if(param1.chatType == 7 || param1.chatType == 8 || param1.chatType == 9)
         {
            _loc5_ = "widget.chatbubble.petrevived";
            if(param1.chatType == 8)
            {
               _loc5_ = "widget.chatbubble.petrefertilized";
            }
            else if(param1.chatType == 9)
            {
               _loc5_ = "widget.chatbubble.petspeedfertilized";
            }
            UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.registerParameter(_loc5_,"petName",param2);
            UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.registerParameter(_loc5_,"userName",resolveRoomUserName(param1.roomId,param1.extraParam));
            param1.text = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.localizations.getLocalizationRaw(_loc5_).value;
            param1.style = 1;
         }
      }
      
      private function isSystemNotificationChat(param1:int) : Boolean
      {
         switch(param1 - 3)
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 9:
               return true;
            default:
               return false;
         }
      }
      
      private function resolveRoomUserName(param1:int, param2:int) : String
      {
         var _loc4_:IRoomObject = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomEngine.getRoomObject(param1,param2,100);
         if(_loc4_ == null)
         {
            return "";
         }
         var _loc3_:IUserData = UnknownVarFromChatBubbleFactory_HabboFreeFlowChat_1.roomSessionManager.getSession(param1).userDataManager.getUserDataByIndex(_loc4_.getId());
         return _loc3_ != null ? _loc3_.name : "";
      }
   }
}

