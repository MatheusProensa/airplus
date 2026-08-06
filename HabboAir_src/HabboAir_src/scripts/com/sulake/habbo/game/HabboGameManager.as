package com.sulake.habbo.game
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2CheckGameDirectoryStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2QuickJoinGameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2StartSnowWarMessageComposer;
   import com.sulake.habbo.friendbar.IHabboLandingView;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLandingView;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class HabboGameManager extends Component implements IHabboGameManager
   {
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _avatarManager:IAvatarRenderManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var _habboHelp:IHabboHelp;
      
      private var _inventory:IHabboInventory;
      
      private var _navigator:IHabboNavigator_1;
      
      private var UnknownVarFromHabboGameManager_SnowWarEngine_1:SnowWarEngine;
      
      private var _incomingMessages:IncomingMessages;
      
      private var UnknownVarFromHabboGameManager_Boolean_1:Boolean = false;
      
      private var UnknownVarFromHabboGameManager_Boolean_2:Boolean = false;
      
      private var _isHotelClosed:Boolean = false;
      
      private var _landingView:IHabboLandingView;
      
      private var _activeGame:int = -1;
      
      public function HabboGameManager(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),onHabboCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
         queueInterface(new IIDAvatarRenderManager(),onAvatarRenderedReady);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboLandingView(),onLandingViewReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboInventory(),onHabboInventory);
         queueInterface(new IIDHabboNavigator(),onHabboNavigator);
         UnknownVarFromHabboGameManager_SnowWarEngine_1 = new SnowWarEngine(this,param1,0,param3);
         HabboGamesCom.log("HabboGameManager initialized: " + param3);
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get avatarManager() : IAvatarRenderManager
      {
         return _avatarManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get inventory() : IHabboInventory
      {
         return _inventory;
      }
      
      public function get navigator() : IHabboNavigator_1
      {
         return _navigator;
      }
      
      public function get gameCenterEnabled() : Boolean
      {
         return UnknownVarFromHabboGameManager_Boolean_1 || UnknownVarFromHabboGameManager_Boolean_2 && sessionDataManager.hasSecurity(4);
      }
      
      public function get isHotelClosed() : Boolean
      {
         return _isHotelClosed;
      }
      
      public function set hotelClosed(param1:Boolean) : void
      {
         _isHotelClosed = param1;
      }
      
      override public function dispose() : void
      {
         if(_communication)
         {
            _communication.release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         if(_windowManager)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         if(_localization)
         {
            _localization.release(new IIDHabboLocalizationManager());
            _localization = null;
         }
         if(_sessionDataManager != null)
         {
            _sessionDataManager.release(new IIDSessionDataManager());
            _sessionDataManager = null;
         }
         if(_habboHelp != null)
         {
            _habboHelp.release(new IIDHabboHelp());
            _habboHelp = null;
         }
         if(_toolbar)
         {
            if(_toolbar.events)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
            }
            _toolbar.release(new IIDHabboToolbar());
            _toolbar = null;
         }
         if(_avatarManager != null)
         {
            _avatarManager.release(new IIDAvatarRenderManager());
            _avatarManager = null;
         }
         if(_catalog != null)
         {
            _catalog.release(new IIDHabboCatalog());
            _catalog = null;
         }
         if(_incomingMessages)
         {
            _incomingMessages.dispose();
            _incomingMessages = null;
         }
         if(_landingView)
         {
            _landingView.release(new IIDHabboLandingView());
            _landingView = null;
         }
         if(_roomEngine)
         {
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(_inventory)
         {
            _inventory.release(new IIDHabboInventory());
            _inventory = null;
         }
         if(_navigator)
         {
            _navigator.release(new IIDHabboNavigator());
            _navigator = null;
         }
         _activeGame = -1;
         super.dispose();
      }
      
      private function onWindowManagerReady(param1:IID, param2:IUnknown) : void
      {
         _windowManager = param2 as IHabboWindowManagerComponent;
         WindowUtils.init(assets,_windowManager);
      }
      
      private function onHabboCommunicationReady(param1:IID, param2:IUnknown) : void
      {
         _communication = param2 as IHabboCommunicationManager;
         _incomingMessages = new IncomingMessages(this);
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         UnknownVarFromHabboGameManager_Boolean_1 = getBoolean("game.center.enabled");
         UnknownVarFromHabboGameManager_Boolean_2 = getBoolean("game.center.enabled.forStaff");
      }
      
      private function onLocalizationReady(param1:IID, param2:IUnknown) : void
      {
         _localization = param2 as IHabboLocalizationManager;
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _sessionDataManager = param2 as ISessionDataManager;
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomSessionManager = param2 as IRoomSessionManager;
      }
      
      private function onAvatarRenderedReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _avatarManager = param2 as IAvatarRenderManager;
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _toolbar = param2 as IHabboToolbar;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _catalog = param2 as IHabboCatalog;
      }
      
      private function onLandingViewReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _landingView = param2 as IHabboLandingView;
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomEngine = param2 as IRoomEngine;
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _habboHelp = param2 as IHabboHelp;
      }
      
      private function onHabboInventory(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _inventory = param2 as IHabboInventory;
      }
      
      private function onHabboNavigator(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _navigator = param2 as IHabboNavigator_1;
      }
      
      public function initGameDirectoryConnection() : void
      {
         send(new Game2CheckGameDirectoryStatusMessageComposer());
      }
      
      public function startSnowWarGame(param1:String) : void
      {
         initGameDirectoryConnection();
         send(new Game2StartSnowWarMessageComposer(param1));
      }
      
      public function startQuickSnowWarGame() : void
      {
         send(new Game2QuickJoinGameMessageComposer());
      }
      
      public function onSnowWarArenaSessionEnded() : void
      {
         if(!UnknownVarFromHabboGameManager_SnowWarEngine_1.isGameStarting)
         {
            UnknownVarFromHabboGameManager_SnowWarEngine_1.resetSession();
            if(_landingView != null)
            {
               _landingView.activate();
            }
         }
      }
      
      public function generateChecksumMismatch() : void
      {
         if(UnknownVarFromHabboGameManager_SnowWarEngine_1)
         {
            UnknownVarFromHabboGameManager_SnowWarEngine_1.generateChecksumMismatch();
         }
      }
      
      public function handleClickOnTile(param1:RoomObjectTileMouseEvent) : void
      {
         if(UnknownVarFromHabboGameManager_SnowWarEngine_1)
         {
            UnknownVarFromHabboGameManager_SnowWarEngine_1.handleClickOnTile(param1);
         }
      }
      
      public function handleClickOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         if(UnknownVarFromHabboGameManager_SnowWarEngine_1)
         {
            UnknownVarFromHabboGameManager_SnowWarEngine_1.handleClickOnHuman(param1,param2,param3);
         }
      }
      
      public function handleMouseOverOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         if(UnknownVarFromHabboGameManager_SnowWarEngine_1)
         {
            UnknownVarFromHabboGameManager_SnowWarEngine_1.handleMouseOverOnHuman(param1,param2,param3);
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communication)
         {
            _communication.connection.send(param1);
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         switch(param1.iconId)
         {
            case "HTIE_ICON_GAMES":
               initGameDirectoryConnection();
               send(new GetSnowWarGameTokensOfferComposer());
               break;
            case "HTIE_ICON_RECEPTION":
         }
      }
   }
}

