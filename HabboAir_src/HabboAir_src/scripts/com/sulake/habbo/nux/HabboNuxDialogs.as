package com.sulake.habbo.nux
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOfferEvent;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOptions;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceNotCompleteEvent;
   import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsSelection;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.nux.NewUserExperienceGiftOfferParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HabboNuxDialogs extends Component implements ILinkEventTracker
   {
      protected var _communicationManager:IHabboCommunicationManager;
      
      protected var _navigator:IHabboNavigator_1;
      
      protected var _windowManager:IHabboWindowManagerComponent;
      
      protected var _localizationManager:IHabboLocalizationManager;
      
      protected var _catalog:IHabboCatalog;
      
      protected var _sessionDataManager:ISessionDataManager;
      
      protected var _roomSessionManager:IRoomSessionManager;
      
      private var UnknownVarFromHabboNuxDialogs_IConnection_1:IConnection;
      
      private var UnknownVarFromHabboNuxDialogs_NuxOfferOldUserView_1:NuxOfferOldUserView;
      
      private var UnknownVarFromHabboNuxDialogs_NuxGiftSelectionView_1:NuxGiftSelectionView;
      
      private var UnknownVarFromHabboNuxDialogs_NuxNoobRoomOfferView_1:NuxNoobRoomOfferView;
      
      private var UnknownVarFromHabboNuxDialogs_Timer_1:Timer;
      
      public function HabboNuxDialogs(param1:IComponent_2, param2:uint, param3:IAssetLibraryCollection)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         }])]);
      }
      
      override public function dispose() : void
      {
         context.removeLinkEventTracker(this);
         if(_windowManager)
         {
            _windowManager = null;
         }
         destroyGiftSelectionView();
         destroyNoobRoomOfferView();
         destroyNuxOfferView();
         super.dispose();
      }
      
      override protected function initComponent() : void
      {
         UnknownVarFromHabboNuxDialogs_IConnection_1 = _communicationManager.connection;
         if(UnknownVarFromHabboNuxDialogs_IConnection_1)
         {
            UnknownVarFromHabboNuxDialogs_IConnection_1.addMessageEvent(new NewUserExperienceNotCompleteEvent(onNewUserExperienceNotCompleteMessage));
            UnknownVarFromHabboNuxDialogs_IConnection_1.addMessageEvent(new NewUserExperienceGiftOfferEvent(onNewUserExperienceGiftOfferMessage));
         }
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "nux/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("lobbyoffer" !== _loc3_)
         {
            Logger.log("HabboNuxDialogs unknown link-type received: " + _loc2_[1]);
         }
         else if(_loc2_.length > 2 && _loc2_[2] == "show")
         {
            createNoobRoomOfferView();
         }
         else
         {
            destroyNoobRoomOfferView();
         }
      }
      
      public function onVerify() : void
      {
         UnknownVarFromHabboNuxDialogs_IConnection_1.send(new SetPhoneNumberVerificationStatusMessageComposer(0));
      }
      
      public function onReject() : void
      {
         _windowManager.confirm("${phone.number.never.again.confirm.title}","${phone.number.never.again.confirm.text}",0,onNeverAgainConfirmClose);
      }
      
      private function onNeverAgainConfirmClose(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK" && UnknownVarFromHabboNuxDialogs_IConnection_1)
         {
            destroyNuxOfferView();
            UnknownVarFromHabboNuxDialogs_IConnection_1.send(new SetPhoneNumberVerificationStatusMessageComposer(2));
         }
      }
      
      public function onSendGetGifts(param1:Vector.<NewUserExperienceGetGiftsSelection>) : void
      {
         destroyGiftSelectionView();
         UnknownVarFromHabboNuxDialogs_IConnection_1.send(new NewUserExperienceGetGiftsMessageComposer(param1));
      }
      
      private function onNewUserExperienceNotCompleteMessage(param1:NewUserExperienceNotCompleteEvent) : void
      {
         createNuxOfferView();
      }
      
      private function onNewUserExperienceGiftOfferMessage(param1:NewUserExperienceGiftOfferEvent) : void
      {
         var _loc2_:NewUserExperienceGiftOfferParser = param1.getParser();
         createGiftSelectionView(_loc2_.giftOptions);
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         var _loc2_:* = 0;
         if(!getBoolean("nux.lobbies.enabled") || !_sessionDataManager.isRealNoob)
         {
            return;
         }
         if(param1.type == "RSE_STARTED" && param1.session && param1.session.roomId == _navigator.homeRoomId)
         {
            _loc2_ = uint(getInteger("nux.noob.lobby.popup.delay",70) * 1000);
            UnknownVarFromHabboNuxDialogs_Timer_1 = new Timer(_loc2_,1);
            UnknownVarFromHabboNuxDialogs_Timer_1.addEventListener("timer",createNoobRoomOfferView);
            UnknownVarFromHabboNuxDialogs_Timer_1.start();
         }
         else
         {
            destroyNoobRoomOfferView();
         }
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get configuration() : IComponent_1
      {
         return this;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function createNuxOfferView() : void
      {
         destroyNuxOfferView();
         UnknownVarFromHabboNuxDialogs_NuxOfferOldUserView_1 = new NuxOfferOldUserView(this);
      }
      
      public function destroyNuxOfferView() : void
      {
         if(UnknownVarFromHabboNuxDialogs_NuxOfferOldUserView_1)
         {
            UnknownVarFromHabboNuxDialogs_NuxOfferOldUserView_1.dispose();
            UnknownVarFromHabboNuxDialogs_NuxOfferOldUserView_1 = null;
         }
      }
      
      private function createGiftSelectionView(param1:Vector.<NewUserExperienceGiftOptions>) : void
      {
         destroyGiftSelectionView();
         UnknownVarFromHabboNuxDialogs_NuxGiftSelectionView_1 = new NuxGiftSelectionView(this,param1);
      }
      
      private function destroyGiftSelectionView() : void
      {
         if(UnknownVarFromHabboNuxDialogs_NuxGiftSelectionView_1)
         {
            UnknownVarFromHabboNuxDialogs_NuxGiftSelectionView_1.dispose();
            UnknownVarFromHabboNuxDialogs_NuxGiftSelectionView_1 = null;
         }
      }
      
      private function startNoobRoomOfferTimer() : void
      {
      }
      
      private function createNoobRoomOfferView(param1:TimerEvent = null) : void
      {
         if(!getBoolean("nux.lobbies.enabled") || !_sessionDataManager.isRealNoob)
         {
            return;
         }
         destroyNoobRoomOfferView();
         UnknownVarFromHabboNuxDialogs_NuxNoobRoomOfferView_1 = new NuxNoobRoomOfferView(this);
         UnknownVarFromHabboNuxDialogs_IConnection_1.send(new EventLogMessageComposer("NewNavigator","nux.offer.lobby","nux.offer.lobby"));
      }
      
      public function destroyNoobRoomOfferView() : void
      {
         if(UnknownVarFromHabboNuxDialogs_Timer_1)
         {
            UnknownVarFromHabboNuxDialogs_Timer_1.reset();
            UnknownVarFromHabboNuxDialogs_Timer_1 = null;
         }
         if(UnknownVarFromHabboNuxDialogs_NuxNoobRoomOfferView_1)
         {
            UnknownVarFromHabboNuxDialogs_NuxNoobRoomOfferView_1.dispose();
            UnknownVarFromHabboNuxDialogs_NuxNoobRoomOfferView_1 = null;
         }
      }
   }
}

