package com.sulake.habbo.roomevents.wired_trading.transactions.details
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.transactions.WiredTransactionLogDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionDetails;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionLogDetailsMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class WiredTransactionDetailsController extends Component implements UnknownIHabboRoomeventsWired_TradingTransactionsDetails1
   {
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _view:WiredTransactionDetailsView;
      
      private var _details:WiredTransactionDetails;
      
      public function WiredTransactionDetailsController(param1:HabboUserDefinedRoomEvents, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new WiredTransactionLogDetailsMessageEvent(onTransactionDetails));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      private function onTransactionDetails(param1:WiredTransactionLogDetailsMessageEvent) : void
      {
         var _loc2_:WiredTransactionLogDetailsMessageParser = param1.getParser();
         _details = _loc2_.details;
         if(_view == null)
         {
            _view = new WiredTransactionDetailsView(this,_windowManager);
         }
         _view.updateUI();
         if(!_view.isShowing())
         {
            _view.show();
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
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
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":roomSessionEventHandler
         }])]);
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
      }
      
      private function setWindowManager(param1:IHabboWindowManagerComponent) : void
      {
         _windowManager = param1;
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
            if(_view != null)
            {
               _view.hide();
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
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get details() : WiredTransactionDetails
      {
         return _details;
      }
      
      public function get view() : WiredTransactionDetailsView
      {
         return _view;
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
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         _details = null;
         _communicationManager = null;
         _localizationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _roomEngine = null;
         _roomEvents = null;
         _disposed = true;
         super.dispose();
      }
   }
}

