package com.sulake.habbo.roomevents.wired_trading.reward_notification
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.transactions.WiredTransactionSuccessMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionSuccessContents;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_trading.UbuntuPresetManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   
   public class RewardNotificationController extends Component implements ILinkEventTracker, IRewardNotification, IComponentInterfaceQueue
   {
      private static const MAX_OPEN_REWARD_NOTIFICATIONS:int = 10;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromRewardNotificationController_Map_1:Map;
      
      private var UnknownVarFromRewardNotificationController_Vector_1:Vector.<RewardNotificationView>;
      
      private var UnknownVarFromRewardNotificationController_PresetManager_1:PresetManager;
      
      private var _disposed:Boolean = false;
      
      public function RewardNotificationController(param1:HabboUserDefinedRoomEvents, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new WiredTransactionSuccessMessageEvent(onTransactionSuccess));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
         UnknownVarFromRewardNotificationController_Map_1 = new Map();
         UnknownVarFromRewardNotificationController_Vector_1 = new Vector.<RewardNotificationView>();
         UnknownVarFromRewardNotificationController_PresetManager_1 = new UbuntuPresetManager(param1);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         }])]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "wiredrewards/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = param1.split("/");
         if(_loc3_.length < 2)
         {
            return;
         }
         if(_loc3_[1] == "open")
         {
            if(_loc3_.length < 3)
            {
               return;
            }
            _loc2_ = int(_loc3_[2]);
            openRewardView(_loc2_);
         }
      }
      
      private function onTransactionSuccess(param1:WiredTransactionSuccessMessageEvent) : void
      {
         var _loc2_:WiredTransactionSuccessContents = param1.getParser().contents;
         if(_loc2_.rewardContents == null)
         {
            return;
         }
         UnknownVarFromRewardNotificationController_Map_1.add(_loc2_.internalId,_loc2_);
         if(_loc2_.openByDefault)
         {
            openRewardView(_loc2_.internalId);
         }
      }
      
      public function openRewardView(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         if(_disposed)
         {
            return;
         }
         for each(var _loc4_ in UnknownVarFromRewardNotificationController_Vector_1)
         {
            if(_loc4_.contents != null && _loc4_.contents.internalId == param1)
            {
               _loc4_.window.activate();
               return;
            }
         }
         while(UnknownVarFromRewardNotificationController_Vector_1.length >= 10)
         {
            closeRewardView(UnknownVarFromRewardNotificationController_Vector_1[0]);
         }
         var _loc7_:WiredTransactionSuccessContents = UnknownVarFromRewardNotificationController_Map_1[param1];
         var _loc2_:RewardNotificationView = new RewardNotificationView(this,UnknownVarFromRewardNotificationController_PresetManager_1);
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         if(UnknownVarFromRewardNotificationController_Vector_1.length > 0)
         {
            _loc9_ = (UnknownVarFromRewardNotificationController_Vector_1[UnknownVarFromRewardNotificationController_Vector_1.length - 1].viewIndex + 1) % 10;
         }
         if(_loc9_ > 0)
         {
            _loc6_ = 25;
            _loc8_ = (_loc9_ + 1) / 2;
            if((_loc9_ + 1) % 2 == 0)
            {
               _loc5_ = _loc6_ * _loc8_;
               _loc3_ = _loc6_ * _loc8_;
            }
            else
            {
               _loc5_ = -_loc6_ * _loc8_;
               _loc3_ = -_loc6_ * _loc8_;
            }
         }
         _loc2_.show(_loc7_,_loc5_,_loc3_,_loc9_);
         UnknownVarFromRewardNotificationController_Vector_1.push(_loc2_);
      }
      
      public function closeRewardView(param1:RewardNotificationView) : void
      {
         var _loc2_:int = int(UnknownVarFromRewardNotificationController_Vector_1.indexOf(param1));
         if(_loc2_ != -1)
         {
            UnknownVarFromRewardNotificationController_Vector_1.splice(_loc2_,1);
         }
         param1.dispose();
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:* = undefined;
         if(_roomEngine == null)
         {
            return;
         }
         var _loc5_:* = param1.type;
         if("REE_DISPOSED" === _loc5_)
         {
            _loc2_ = UnknownVarFromRewardNotificationController_Vector_1;
            UnknownVarFromRewardNotificationController_Vector_1 = new Vector.<RewardNotificationView>();
            for each(var _loc3_ in _loc2_)
            {
               _loc3_.dispose();
            }
         }
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
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         for each(var _loc2_ in _messageEvents)
         {
            removeMessageEvent(_loc2_);
         }
         _messageEvents = null;
         for each(var _loc1_ in UnknownVarFromRewardNotificationController_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromRewardNotificationController_Vector_1 = null;
         UnknownVarFromRewardNotificationController_Map_1 = null;
         _communicationManager = null;
         _windowManager = null;
         _localizationManager = null;
         _roomEngine = null;
         UnknownVarFromRewardNotificationController_PresetManager_1 = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
   }
}

