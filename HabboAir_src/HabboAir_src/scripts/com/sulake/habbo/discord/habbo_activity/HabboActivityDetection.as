package com.sulake.habbo.discord.habbo_activity
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredSaveSuccessEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredValidationErrorEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
   import com.sulake.habbo.discord.HabboDiscordManager;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.session.events.RoomSessionDanceEvent;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
   import com.sulake.iid.IIDRoomEngine;
   import flash.utils.getTimer;
   
   public class HabboActivityDetection extends Component implements IHabboActivityDetection
   {
      private static const ACTIVITY_VOLUME_WINDOW_MS:int = 300000;
      
      private static const ACTIVITY_MIN_WINDOW_MS:int = 30000;
      
      private static const ACTIVITY_MAX_WINDOW_MS:int = 300000;
      
      private static const ACTIVITY_MAX_COUNT:int = 30;
      
      private var UnknownVarFromHabboActivityDetection_HabboDiscordManager_1:HabboDiscordManager;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _inventory:IHabboInventory;
      
      private var UnknownVarFromHabboActivityDetection_IRoomSession_1:IRoomSession;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _wired:IHabboUserDefinedRoomEvents;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _toolbar:IHabboToolbar;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromHabboActivityDetection_Int_1:int = 0;
      
      private var UnknownVarFromHabboActivityDetection_Boolean_1:Boolean = false;
      
      private var UnknownVarFromHabboActivityDetection_Int_2:int = 0;
      
      private var UnknownVarFromHabboActivityDetection_Int_3:int = 0;
      
      private var _roomNameFast:String = null;
      
      private var _inHiddenRoomFast:Boolean = false;
      
      private var _categoryFast:int = 0;
      
      private var _roomId:int = -1;
      
      private var UnknownVarFromHabboActivityDetection_Array_1:Array = [];
      
      private var UnknownVarFromHabboActivityDetection_Array_2:Array = [];
      
      private var UnknownVarFromHabboActivityDetection_Array_3:Array = [];
      
      public function HabboActivityDetection(param1:HabboDiscordManager, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         UnknownVarFromHabboActivityDetection_HabboDiscordManager_1 = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         addMessageEvent(new WiredValidationErrorEvent(onModifyingWired));
         addMessageEvent(new WiredSaveSuccessEvent(onModifyingWired));
         addMessageEvent(new GetGuestRoomResultEvent(onGetGuestRoomResult));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REOE_PLACED",
            "callback":onRoomEngineObjectPlaced
         },{
            "type":"REOE_REQUEST_MOVE",
            "callback":onRoomEngineObjectActivity
         },{
            "type":"REOE_REQUEST_ROTATE",
            "callback":onRoomEngineObjectActivity
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSCE_CHAT_EVENT",
            "callback":onRoomSessionChat
         },{
            "type":"RSDE_DANCE",
            "callback":onRoomSessionDance
         }]),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _wired = param1;
         })]);
      }
      
      public function isInRoom() : Boolean
      {
         return _roomNameFast != null && _toolbar.getToolbarState() == "HTE_STATE_ROOM_VIEW";
      }
      
      public function isInHiddenRoom() : Boolean
      {
         return _inHiddenRoomFast;
      }
      
      public function getCurrentRoomActivity() : HabboActivityState
      {
         if(!isInRoom())
         {
            return null;
         }
         var _loc3_:* = HabboActivityState.CHILLING;
         var _loc1_:Vector.<HabboActivityState> = getAllCurrentRoomActivities();
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.rank > _loc3_.rank)
            {
               _loc3_ = _loc2_;
            }
         }
         return _loc3_;
      }
      
      public function getCurrentRoomName() : String
      {
         if(!isInRoom())
         {
            return null;
         }
         return _roomNameFast;
      }
      
      private function onGetGuestRoomResult(param1:GetGuestRoomResultEvent) : void
      {
         var _loc2_:GetGuestRoomResultMessageParser = param1.getParser();
         if(_loc2_.openingConnection || _loc2_.enterRoom)
         {
            _roomNameFast = _loc2_.data.roomName;
            _inHiddenRoomFast = _loc2_.data.doorMode == 3;
            _roomId = _loc2_.data.flatId;
            _categoryFast = _loc2_.data.categoryId;
            UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence(_loc2_.enterRoom);
         }
      }
      
      private function getAllCurrentRoomActivities() : Vector.<HabboActivityState>
      {
         var _loc5_:HabboActivityState = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Vector.<HabboActivityState> = new Vector.<HabboActivityState>(0);
         if(UnknownVarFromHabboActivityDetection_IRoomSession_1 == null || !isInRoom())
         {
            return _loc1_;
         }
         if(UnknownVarFromHabboActivityDetection_IRoomSession_1.isGameSession)
         {
            _loc1_.push(HabboActivityState.GAMING);
         }
         else
         {
            _loc5_ = activityStateByRoomCategory(_categoryFast);
            if(_loc5_ != null)
            {
               _loc1_.push(_loc5_);
            }
         }
         if(_inventory != null && _inventory.tradingActive)
         {
            _loc1_.push(HabboActivityState.TRADING);
         }
         if(UnknownVarFromHabboActivityDetection_IRoomSession_1.isUserDecorating)
         {
            _loc1_.push(HabboActivityState.BUILDING);
         }
         else
         {
            _loc6_ = getTimer();
            _loc4_ = getDynamicWindowMs(UnknownVarFromHabboActivityDetection_Array_2,_loc6_);
            if(UnknownVarFromHabboActivityDetection_Int_3 > 0 && _loc6_ - UnknownVarFromHabboActivityDetection_Int_3 <= _loc4_)
            {
               _loc1_.push(HabboActivityState.BUILDING);
            }
         }
         var _loc7_:int = getTimer();
         if(UnknownVarFromHabboActivityDetection_Boolean_1)
         {
            _loc1_.push(HabboActivityState.DANCING);
         }
         var _loc2_:int = getDynamicWindowMs(UnknownVarFromHabboActivityDetection_Array_1,_loc7_);
         if(UnknownVarFromHabboActivityDetection_Int_1 > 0 && _loc7_ - UnknownVarFromHabboActivityDetection_Int_1 <= _loc2_)
         {
            _loc1_.push(HabboActivityState.CHATTING);
         }
         var _loc3_:int = getDynamicWindowMs(UnknownVarFromHabboActivityDetection_Array_3,_loc7_);
         if(_wired != null && _wired.hasWiredUIOpen() || UnknownVarFromHabboActivityDetection_Int_2 > 0 && _loc7_ - UnknownVarFromHabboActivityDetection_Int_2 <= _loc3_)
         {
            _loc1_.push(HabboActivityState.CREATING_WIRED);
         }
         return _loc1_;
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_STARTED":
               UnknownVarFromHabboActivityDetection_IRoomSession_1 = param1.session;
               resetRecents();
               UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence(false,true);
               break;
            case "RSE_ENDED":
               resetRecents();
               UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence(false,true);
         }
      }
      
      private function onRoomSessionChat(param1:RoomSessionChatEvent) : void
      {
         if(UnknownVarFromHabboActivityDetection_IRoomSession_1 == null || param1 == null)
         {
            return;
         }
         if(param1.userId == UnknownVarFromHabboActivityDetection_IRoomSession_1.ownUserRoomId && !_freeFlowChat.isNotificationStyle(param1.style))
         {
            UnknownVarFromHabboActivityDetection_Int_1 = getTimer();
            recordActivity(UnknownVarFromHabboActivityDetection_Array_1,UnknownVarFromHabboActivityDetection_Int_1);
            UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence();
         }
      }
      
      private function onRoomSessionDance(param1:RoomSessionDanceEvent) : void
      {
         if(UnknownVarFromHabboActivityDetection_IRoomSession_1 == null || param1 == null)
         {
            return;
         }
         if(param1.userId == UnknownVarFromHabboActivityDetection_IRoomSession_1.ownUserRoomId)
         {
            UnknownVarFromHabboActivityDetection_Boolean_1 = param1.danceStyle > 0;
            UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence();
         }
      }
      
      private function onModifyingWired(param1:IMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromHabboActivityDetection_Int_2 = getTimer();
         recordActivity(UnknownVarFromHabboActivityDetection_Array_3,UnknownVarFromHabboActivityDetection_Int_2);
         UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence();
      }
      
      private function onRoomEngineObjectPlaced(param1:RoomEngineObjectPlacedEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "REOE_PLACED" && param1.placementSource == "inventory" && param1.placedInRoom)
         {
            UnknownVarFromHabboActivityDetection_Int_3 = getTimer();
            recordActivity(UnknownVarFromHabboActivityDetection_Array_2,UnknownVarFromHabboActivityDetection_Int_3);
            UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence();
         }
      }
      
      private function onRoomEngineObjectActivity(param1:RoomEngineObjectEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "REOE_REQUEST_MOVE" || param1.type == "REOE_REQUEST_ROTATE")
         {
            UnknownVarFromHabboActivityDetection_Int_3 = getTimer();
            recordActivity(UnknownVarFromHabboActivityDetection_Array_2,UnknownVarFromHabboActivityDetection_Int_3);
            UnknownVarFromHabboActivityDetection_HabboDiscordManager_1.tryUpdatePresence();
         }
      }
      
      private function recordActivity(param1:Array, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         param1.push(param2);
         pruneOld(param1,param2);
      }
      
      private function pruneOld(param1:Array, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         while(param1.length > 0 && param2 - int(param1[0]) > 300000)
         {
            param1.shift();
         }
      }
      
      private function getDynamicWindowMs(param1:Array, param2:int) : int
      {
         if(!param1)
         {
            return 0;
         }
         pruneOld(param1,param2);
         var _loc3_:int = int(param1.length);
         if(_loc3_ <= 0)
         {
            return 0;
         }
         if(_loc3_ > 30)
         {
            _loc3_ = 30;
         }
         var _loc4_:Number = (_loc3_ - 1) / (30 - 1);
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > 1)
         {
            _loc4_ = 1;
         }
         return int(30000 + _loc4_ * (300000 - 30000));
      }
      
      private function activityStateByRoomCategory(param1:int) : HabboActivityState
      {
         if(isCategoryMatch(param1,"rpg"))
         {
            return HabboActivityState.RPG;
         }
         if(isCategoryMatch(param1,"agency"))
         {
            return HabboActivityState.WORKING;
         }
         if(isCategoryMatch(param1,"games"))
         {
            return HabboActivityState.GAMING;
         }
         return null;
      }
      
      private function isCategoryMatch(param1:int, param2:String) : Boolean
      {
         var _loc4_:String = getProperty("discord.room_category." + param2);
         if(_loc4_ == null || _loc4_.length == 0)
         {
            return false;
         }
         var _loc3_:Array = _loc4_.split(",");
         return _loc3_.indexOf(String(param1)) != -1;
      }
      
      private function resetRecents() : void
      {
         UnknownVarFromHabboActivityDetection_Int_1 = 0;
         UnknownVarFromHabboActivityDetection_Boolean_1 = false;
         UnknownVarFromHabboActivityDetection_Int_2 = 0;
         UnknownVarFromHabboActivityDetection_Int_3 = 0;
         UnknownVarFromHabboActivityDetection_Array_1 = [];
         UnknownVarFromHabboActivityDetection_Array_2 = [];
         UnknownVarFromHabboActivityDetection_Array_3 = [];
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _navigator = null;
         _inventory = null;
         UnknownVarFromHabboActivityDetection_IRoomSession_1 = null;
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}

