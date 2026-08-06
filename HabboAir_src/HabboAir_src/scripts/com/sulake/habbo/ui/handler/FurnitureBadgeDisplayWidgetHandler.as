package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.communication.enum.BadgeRarity;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgeInfoComposer;
   import com.sulake.habbo.groups.UnknownHabboGroups1;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAchievementResolutionTrophyDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.trophy.TrophyTheme;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureBadgeDisplayWidgetHandler implements IRoomWidgetHandler
   {
      private static const TROPHY_VIEW_TYPE:int = 0;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromFurnitureBadgeDisplayWidgetHandler_BadgeInfoEvent_1:BadgeInfoEvent;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var _pendingBadgeCode:String;
      
      private var UnknownVarFromFurnitureBadgeDisplayWidgetHandler_String_1:String;
      
      private var _pendingFrameTitle:String;
      
      private var _pendingMessage:String;
      
      private var _pendingUserName:String;
      
      public function FurnitureBadgeDisplayWidgetHandler()
      {
         super();
         UnknownVarFromFurnitureBadgeDisplayWidgetHandler_BadgeInfoEvent_1 = new BadgeInfoEvent(onBadgeInfo);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container != null && _container.connection != null)
         {
            _container.connection.removeMessageEvent(UnknownVarFromFurnitureBadgeDisplayWidgetHandler_BadgeInfoEvent_1);
         }
         _container = param1;
         if(_container != null && _container.connection != null)
         {
            _container.connection.addMessageEvent(UnknownVarFromFurnitureBadgeDisplayWidgetHandler_BadgeInfoEvent_1);
         }
      }
      
      public function dispose() : void
      {
         if(_container != null && _container.connection != null)
         {
            _container.connection.removeMessageEvent(UnknownVarFromFurnitureBadgeDisplayWidgetHandler_BadgeInfoEvent_1);
         }
         _disposed = true;
         clearPendingBadgeDisplayRequest();
         UnknownVarFromFurnitureBadgeDisplayWidgetHandler_BadgeInfoEvent_1 = null;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING","RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED","RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         if(disposed || param1 == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING":
               handleEngravingRequest(param1 as RoomWidgetFurniToWidgetMessage,true);
               break;
            case "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING":
               clearPendingBadgeDisplayRequest();
               handleEngravingRequest(param1 as RoomWidgetFurniToWidgetMessage,false);
               break;
            case "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED":
               clearPendingBadgeDisplayRequest();
               _container.windowManager.simpleAlert("${resolution.failed.title}","${resolution.failed.subtitle}","${resolution.failed.text}",null,null,null,"help_error_state");
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      private function handleEngravingRequest(param1:RoomWidgetFurniToWidgetMessage, param2:Boolean) : void
      {
         var _loc5_:StringArrayStuffData = getStuffData(param1);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc7_:String = _loc5_.getValue(1);
         var _loc6_:String = _container.localization.getBadgeName(_loc7_);
         var _loc4_:String = "\r\n" + _container.localization.getBadgeDesc(_loc7_);
         var _loc10_:String = _loc5_.getValue(2);
         var _loc3_:String = _loc5_.getValue(3);
         var _loc8_:String = param2 ? "badge.display.engraving.text" : "resolution.engraving.text";
         var _loc9_:* = _container.localization.getLocalizationWithParams(_loc8_,"%badgename%","badgename",_loc6_,"badgedesc",_loc4_);
         if(_loc9_ == null)
         {
            _loc9_ = _loc6_;
         }
         if(!param2)
         {
            dispatchTrophyDataUpdate(_loc10_,_loc3_,_loc9_,_container.localization.getLocalization("widget.furni.trophy.title","Trophy"),TrophyTheme.getHeaderColor(0),0,16777215);
            return;
         }
         _pendingBadgeCode = _loc7_;
         _pendingUserName = _loc10_;
         UnknownVarFromFurnitureBadgeDisplayWidgetHandler_String_1 = _loc3_;
         _pendingMessage = _loc9_;
         _pendingFrameTitle = _container.localization.getLocalization("widget.furni.badge_display.title","Badge Display");
         if(_container != null && _container.connection != null)
         {
            _container.connection.send(new GetBadgeInfoComposer(_loc7_));
            return;
         }
         dispatchTrophyDataUpdate(_loc10_,_loc3_,_loc9_,_pendingFrameTitle,getBadgeDisplayHeaderColor(0),getBadgeDisplayBackgroundTheme(0),getBadgeDisplayBackgroundColor(0));
         clearPendingBadgeDisplayRequest();
      }
      
      private function getStuffData(param1:RoomWidgetFurniToWidgetMessage) : StringArrayStuffData
      {
         if(_container == null || param1 == null)
         {
            return null;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(param1.roomId,param1.id,param1.category);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc4_:IRoomObjectModel = _loc2_.getModel();
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc3_:StringArrayStuffData = new StringArrayStuffData();
         _loc3_.initializeFromRoomObjectModel(_loc4_);
         return _loc3_;
      }
      
      private function onBadgeInfo(param1:BadgeInfoEvent) : void
      {
         if(disposed || _pendingBadgeCode == null || param1 == null)
         {
            return;
         }
         var _loc2_:* = param1.getParser();
         if(_loc2_ == null || _loc2_.badgeCode != _pendingBadgeCode)
         {
            return;
         }
         dispatchTrophyDataUpdate(_pendingUserName,UnknownVarFromFurnitureBadgeDisplayWidgetHandler_String_1,getBadgeDisplayMessage(_pendingMessage,_loc2_.badgeRarityId,_loc2_.ownerCount),_pendingFrameTitle,getBadgeDisplayHeaderColor(_loc2_.badgeRarityId),getBadgeDisplayBackgroundTheme(_loc2_.badgeRarityId),getBadgeDisplayBackgroundColor(_loc2_.badgeRarityId));
         clearPendingBadgeDisplayRequest();
      }
      
      private function getBadgeDisplayMessage(param1:String, param2:int, param3:int) : String
      {
         var _loc4_:Array = [];
         if(param1 != null && param1 != "")
         {
            _loc4_.push(param1 + "\n\n\n");
         }
         _loc4_.push(getBadgeRarityLine(param2));
         if(UnknownHabboGroups1.shouldShowOwnerCount(param3))
         {
            _loc4_.push(" - " + getBadgeOwnerCountLine(param3));
         }
         return _loc4_.join("");
      }
      
      private function getBadgeRarityLine(param1:int) : String
      {
         return _container.localization.getLocalizationWithParams("badge.rarity.badge","%rarity% badge","rarity",getBadgeRarityText(param1));
      }
      
      private function getBadgeOwnerCountLine(param1:int) : String
      {
         return _container.localization.getLocalizationWithParams("badge.owner_count","Owned by %count% users","count",UnknownHabboGroups1.formatOwnerCount(param1));
      }
      
      private function getBadgeRarityText(param1:int) : String
      {
         var _loc2_:String = BadgeRarity.getLabelLocalizationKey(param1,isUncommonBadgeRarityEnabled());
         return _container.localization.getLocalization(_loc2_,_loc2_);
      }
      
      private function dispatchTrophyDataUpdate(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:int, param7:uint) : void
      {
         var _loc8_:RoomWidgetAchievementResolutionTrophyDataUpdateEvent = new RoomWidgetAchievementResolutionTrophyDataUpdateEvent("RWARTDUE_TROPHY_DATA",param6 + 1,param1,param2,param3,0,param4,param5,param6,param7);
         _container.events.dispatchEvent(_loc8_);
      }
      
      private function clearPendingBadgeDisplayRequest() : void
      {
         _pendingBadgeCode = null;
         _pendingUserName = null;
         UnknownVarFromFurnitureBadgeDisplayWidgetHandler_String_1 = null;
         _pendingMessage = null;
         _pendingFrameTitle = null;
      }
      
      private function getBadgeDisplayBackgroundTheme(param1:int) : int
      {
         return param1 == 6 ? 0 : 1;
      }
      
      private function getBadgeDisplayBackgroundColor(param1:int) : uint
      {
         if(!BadgeRarity.isStandaloneTier(param1,isUncommonBadgeRarityEnabled()) || param1 == 6)
         {
            return 16777215;
         }
         return getBadgeDisplayTintColor(param1);
      }
      
      private function getBadgeDisplayHeaderColor(param1:int) : uint
      {
         if(!BadgeRarity.isStandaloneTier(param1,isUncommonBadgeRarityEnabled()))
         {
            return TrophyTheme.getHeaderColor(1);
         }
         if(param1 == 6)
         {
            return TrophyTheme.getHeaderColor(0);
         }
         return multiplyColor(TrophyTheme.getHeaderColor(1),getBadgeDisplayTintColor(param1));
      }
      
      private function getBadgeDisplayTintColor(param1:int) : uint
      {
         return lightenColor(BadgeRarity.getDisplayColor(param1,isUncommonBadgeRarityEnabled()),getBackgroundLighteningFactor(param1));
      }
      
      private function getBackgroundLighteningFactor(param1:int) : Number
      {
         switch(param1 - 1)
         {
            case 0:
               return 0.25;
            case 1:
               return 0.3;
            case 2:
               return 0.35;
            case 3:
               return 0.4;
            case 4:
               return 0.45;
            default:
               return 0;
         }
      }
      
      private function isUncommonBadgeRarityEnabled() : Boolean
      {
         return _container != null && _container.config != null && _container.config.getBoolean("badge_rarity.uncommon");
      }
      
      private function lightenColor(param1:uint, param2:Number) : uint
      {
         var _loc3_:uint = uint(param1 >> 16 & 0xFF);
         var _loc4_:uint = uint(param1 >> 8 & 0xFF);
         var _loc5_:uint = uint(param1 & 0xFF);
         _loc3_ += uint((255 - _loc3_) * param2);
         _loc4_ += uint((255 - _loc4_) * param2);
         _loc5_ += uint((255 - _loc5_) * param2);
         return uint(4278190080 | _loc3_ << 16 | _loc4_ << 8 | _loc5_);
      }
      
      private function multiplyColor(param1:uint, param2:uint) : uint
      {
         var _loc3_:uint = (param1 >> 16 & 0xFF) * (param2 >> 16 & 0xFF) / 255;
         var _loc4_:uint = (param1 >> 8 & 0xFF) * (param2 >> 8 & 0xFF) / 255;
         var _loc5_:uint = (param1 & 0xFF) * (param2 & 0xFF) / 255;
         return uint(4278190080 | _loc3_ << 16 | _loc4_ << 8 | _loc5_);
      }
   }
}

