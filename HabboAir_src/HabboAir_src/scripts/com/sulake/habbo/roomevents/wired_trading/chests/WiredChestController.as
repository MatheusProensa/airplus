package com.sulake.habbo.roomevents.wired_trading.chests
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests.OpenChestMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.CloseChestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.OpenChestAndGetContentsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.OpenChestMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.CoinChestSubController;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.FurniChestSubController;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.ICoinChestSubController;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.object.IRoomObject;
   
   public class WiredChestController extends Component implements IWiredChestController_1, IWiredChestController_2
   {
      public static var STATUS_CLOSED:int = 0;
      
      public static var STATUS_OPENING:int = 1;
      
      public static var STATUS_OPEN:int = 2;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _catalog:IHabboCatalog;
      
      private var _disposed:Boolean;
      
      private var _status:int;
      
      private var _chestWrapperView:WiredChestWrapperView;
      
      private var _subControllers:Vector.<ICoinChestSubController>;
      
      private var _requestedChestId:int;
      
      private var _activeChestId:int;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function WiredChestController(param1:HabboUserDefinedRoomEvents, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _status = STATUS_CLOSED;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new OpenChestMessageEvent(onOpenChest));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
         _subControllers = new Vector.<ICoinChestSubController>();
         _subControllers.push(new FurniChestSubController(this));
         _subControllers.push(new CoinChestSubController(this));
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),setWindowManager),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         },{
            "type":"REOE_REMOVED",
            "callback":roomObjectRemovedHandler
         },{
            "type":"REOE_UPDATED",
            "callback":roomObjectUpdatedHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":roomSessionEventHandler
         }])]);
      }
      
      private function setWindowManager(param1:IHabboWindowManagerComponent) : void
      {
         _windowManager = param1;
         if(param1 != null)
         {
            _chestWrapperView = new WiredChestWrapperView(this,param1);
         }
      }
      
      private function onOpenChest(param1:OpenChestMessageEvent) : void
      {
         var _loc2_:OpenChestMessageParser = param1.getParser();
         open(_loc2_.chestId);
      }
      
      public function open(param1:int) : void
      {
         _requestedChestId = param1;
         _communicationManager.connection.send(new OpenChestAndGetContentsMessageComposer(param1));
      }
      
      public function close() : void
      {
         _chestWrapperView.hide();
         setClosedStatus();
      }
      
      public function setClosedStatus() : void
      {
         if(_activeChestId != 0)
         {
            _communicationManager.connection.send(new CloseChestMessageComposer(_activeChestId));
         }
         _activeChestId = 0;
         _status = STATUS_CLOSED;
      }
      
      public function setOpeningStatus(param1:int) : void
      {
         _requestedChestId = 0;
         _activeChestId = param1;
         _status = STATUS_OPENING;
      }
      
      public function setOpenStatus(param1:int, param2:ICoinChestSubController) : void
      {
         _requestedChestId = 0;
         _activeChestId = param1;
         _status = STATUS_OPEN;
         var _loc4_:IRoomObject = _roomEngine.getRoomObject(_roomEngine.activeRoomId,_activeChestId,10);
         if(_loc4_ == null || _loc4_.getModel() == null)
         {
            Logger.log("Tried to open chest, but it\'s not in the room");
            _chestWrapperView.hide();
            return;
         }
         var _loc6_:Number = _loc4_.getModel().getNumber("furniture_owner_id");
         var _loc5_:* = _loc6_ == _roomEvents.sessionDataManager.userId;
         var _loc3_:Boolean = _roomEvents.roomSession.isRoomOwner;
         _chestWrapperView.show(param2,_loc4_,_activeChestId,_loc5_,_loc3_);
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get chestWrapperView() : WiredChestWrapperView
      {
         return _chestWrapperView;
      }
      
      private function roomObjectRemovedHandler(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:int = param1.objectId;
         var _loc3_:int = param1.category;
         if(_loc2_ == _chestWrapperView.viewingChestId && _status == STATUS_OPEN && _loc3_ == 10)
         {
            _chestWrapperView.hide();
         }
      }
      
      private function roomObjectUpdatedHandler(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:int = param1.objectId;
         var _loc3_:int = param1.category;
         if(_loc2_ == _chestWrapperView.viewingChestId && _status == STATUS_OPEN && _loc3_ == 10)
         {
            _chestWrapperView.viewingChestUpdated();
         }
      }
      
      public function get activeChestId() : int
      {
         return _activeChestId;
      }
      
      public function get requestedChestId() : int
      {
         return _requestedChestId;
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
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:* = param1.type;
         if("REE_DISPOSED" === _loc2_)
         {
            if(_chestWrapperView != null)
            {
               _chestWrapperView.hide();
            }
         }
      }
      
      public function onPermissionsChanged() : void
      {
         if(_chestWrapperView.isShowing() && !_chestWrapperView.canRead && !_chestWrapperView.isVisibleForEveryone)
         {
            _chestWrapperView.hide();
         }
         if(_chestWrapperView != null && _chestWrapperView.isShowing())
         {
            _chestWrapperView.updateLayout();
            _chestWrapperView.updateUI();
         }
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
      }
      
      private function subControllerByType(param1:int) : ICoinChestSubController
      {
         for each(var _loc2_ in _subControllers)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
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
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         for each(var _loc1_ in _subControllers)
         {
            _loc1_.dispose();
         }
         _subControllers = null;
         for each(var _loc2_ in _messageEvents)
         {
            removeMessageEvent(_loc2_);
         }
         _messageEvents = null;
         _requestedChestId = 0;
         _activeChestId = 0;
         _status = STATUS_CLOSED;
         _chestWrapperView.dispose();
         _chestWrapperView = null;
         _communicationManager = null;
         _localizationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _roomEngine = null;
         _roomEvents = null;
         _catalog = null;
         super.dispose();
      }
   }
}

