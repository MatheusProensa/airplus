package com.sulake.habbo.game.snowwar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.*;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.*;
   import com.sulake.habbo.communication.messages.outgoing.game.ingame.*;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.*;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.HabboGameManager;
   import com.sulake.habbo.game.events.GameChatEvent;
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.events.NewMoveTargetEvent;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.leaderboard.LeaderboardViewController;
   import com.sulake.habbo.game.snowwar.ui.GameArenaView;
   import com.sulake.habbo.game.snowwar.ui.GameEndingViewController;
   import com.sulake.habbo.game.snowwar.ui.GameLoadingViewController;
   import com.sulake.habbo.game.snowwar.ui.GameLobbyWindowCtrl;
   import com.sulake.habbo.game.snowwar.ui.GamesMainViewController;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.groups.IHabboGroupsManager;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboGroupsManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.Event;
   
   public class SnowWarEngine extends Component implements IProfiler_1
   {
      private static const GHOST_CHECKSUM_TURNS_TO_CHECK:int = 3;
      
      public static const GET_SNOWWAR_TOKENS:String = "GET_SNOWWAR_TOKENS";
      
      public static const GET_SNOWWAR_TOKENS2:String = "GET_SNOWWAR_TOKENS2";
      
      public static const GET_SNOWWAR_TOKENS3:String = "GET_SNOWWAR_TOKENS3";
      
      public static const STATE_INACTIVE:int = 0;
      
      public static const STATE_GAME_STARTING:int = 1;
      
      public static const STATE_STAGE_LOADING:int = 2;
      
      public static const STATE_STAGE_STARTING:int = 3;
      
      public static const STATE_STAGE_RUNNING:int = 4;
      
      public static const STATE_STAGE_ENDING:int = 5;
      
      public static const STATE_GAME_OVER:int = 6;
      
      public static const STATE_REJOIN_GAME:int = 7;
      
      private static var _soundManager:IHabboSoundManagerFlash10;
      
      private var _gameManager:HabboGameManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _config:IComponent_1;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _avatarManager:IAvatarRenderManager;
      
      private var _groupsManager:IHabboGroupsManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomUI:IRoomUI;
      
      private var _catalog:IHabboCatalog;
      
      private var _incomingMessages:IncomingMessages;
      
      private var _habboHelp:IHabboHelp;
      
      private var _friendList:IHabboFriendList;
      
      private var _gameArena:SynchronizedGameArena;
      
      private var UnknownVarFromSnowWarEngine_GameArenaView_1:GameArenaView;
      
      private var _timeSinceLastUpdate:int;
      
      private var UnknownVarFromSnowWarEngine_Int_1:int = 0;
      
      private var UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1:UnknownICoreWindowUtils1;
      
      private var _ownId:int;
      
      private var _players:Map;
      
      private var _currentSubTurn:int = 0;
      
      private var UnknownVarFromSnowWarEngine_Int_2:int = 0;
      
      private var UnknownVarFromSnowWarEngine_Int_3:int = 0;
      
      private var _serverChecksums:Map;
      
      private var UnknownVarFromSnowWarEngine_Boolean_1:Boolean = false;
      
      private var UnknownVarFromSnowWarEngine_GameLoadingViewController_1:GameLoadingViewController;
      
      private var UnknownVarFromSnowWarEngine_GameEndingViewController_1:GameEndingViewController;
      
      private var _mainView:GamesMainViewController;
      
      private var UnknownVarFromSnowWarEngine_LeaderboardViewController_1:LeaderboardViewController;
      
      private var _isGhostEnabled:Boolean = false;
      
      private var _isGhostVisualizationEnabled:Boolean = false;
      
      private var UnknownVarFromSnowWarEngine_Boolean_2:Boolean = false;
      
      private var UnknownVarFromSnowWarEngine_Boolean_3:Boolean = false;
      
      private var _stageLength:int;
      
      private var UnknownVarFromSnowWarEngine_Boolean_4:Boolean = false;
      
      private var _hasUnlimitedGames:Boolean = false;
      
      private var _freeGamesLeft:int = 0;
      
      private var _roomBeforeGame:int = -1;
      
      private var UnknownVarFromSnowWarEngine_Int_4:int = -1;
      
      private var UnknownVarFromSnowWarEngine_Boolean_5:Boolean = false;
      
      public function SnowWarEngine(param1:HabboGameManager, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _gameManager = param1;
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),onHabboCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDAvatarRenderManager(),onAvatarRenderedReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboSoundManager(),onSoundManagerReady);
         queueInterface(new IIDHabboRoomUI(),onRoomUIReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboFriendList(),onFriendListReady);
         queueInterface(new IIDHabboGroupsManager(),onGroupsManagerReady);
         HabboGamesCom.log("SnowWarEngine initialized: " + param4);
         _mainView = new GamesMainViewController(this);
      }
      
      public static function playSound(param1:String, param2:int = 0) : void
      {
         if(_soundManager != null)
         {
            _soundManager.playSound(param1,param2);
         }
      }
      
      public static function stopSound(param1:String) : void
      {
         if(_soundManager != null)
         {
            _soundManager.stopSound(param1);
         }
      }
      
      public function get gameCenterEnabled() : Boolean
      {
         return _gameManager.gameCenterEnabled;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
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
      
      public function get config() : IComponent_1
      {
         return _config;
      }
      
      public function get avatarManager() : IAvatarRenderManager
      {
         return _avatarManager;
      }
      
      public function get groupsManager() : IHabboGroupsManager
      {
         return _groupsManager;
      }
      
      public function get roomUI() : IRoomUI
      {
         return _roomUI;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get friendList() : IHabboFriendList
      {
         return _friendList;
      }
      
      public function get gameArena() : SynchronizedGameArena
      {
         return _gameArena;
      }
      
      public function get currentSubTurn() : int
      {
         return _currentSubTurn;
      }
      
      public function get stageLength() : int
      {
         return _stageLength;
      }
      
      public function get roomBeforeGame() : int
      {
         return _roomBeforeGame;
      }
      
      public function get isGhostEnabled() : Boolean
      {
         return _isGhostEnabled;
      }
      
      public function get isGhostVisualizationEnabled() : Boolean
      {
         return _isGhostVisualizationEnabled;
      }
      
      public function getArenaName(param1:GameLobbyData) : String
      {
         var _loc2_:String = "snowwar.field.name." + param1.fieldType;
         return localization.getLocalization(_loc2_,_loc2_);
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
         if(_config)
         {
            _config.release(new IIDHabboConfigurationManager());
            _config = null;
         }
         if(_localization)
         {
            _localization.release(new IIDHabboLocalizationManager());
            _localization = null;
         }
         if(_roomSessionManager)
         {
            _roomSessionManager.release(new IIDHabboRoomSessionManager());
            _roomSessionManager = null;
         }
         if(_sessionDataManager != null)
         {
            _sessionDataManager.release(new IIDSessionDataManager());
            _sessionDataManager = null;
         }
         if(_roomEngine != null)
         {
            _roomEngine.events.removeEventListener("REE_OBJECTS_INITIALIZED",onRoomObjectsInitialized);
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(_soundManager != null)
         {
            _soundManager.release(new IIDHabboSoundManager());
            _soundManager = null;
         }
         if(_habboHelp != null)
         {
            _habboHelp.release(new IIDHabboHelp());
            _habboHelp = null;
         }
         if(_avatarManager != null)
         {
            _avatarManager.release(new IIDAvatarRenderManager());
            _avatarManager = null;
         }
         if(_groupsManager != null)
         {
            _groupsManager.release(new IIDHabboGroupsManager());
            _groupsManager = null;
         }
         if(_roomUI != null)
         {
            _roomUI.release(new IIDHabboRoomUI());
            _roomUI = null;
         }
         if(_catalog != null)
         {
            _catalog.release(new IIDHabboCatalog());
            _catalog = null;
         }
         if(_friendList != null)
         {
            _friendList.release(new IIDHabboFriendList());
            _friendList = null;
         }
         if(UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1 != null)
         {
            UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1.dispose();
            UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1 = null;
         }
         if(UnknownVarFromSnowWarEngine_GameEndingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.dispose();
            UnknownVarFromSnowWarEngine_GameEndingViewController_1 = null;
         }
         disposeLoadingView();
         if(_gameArena != null)
         {
            _gameArena.dispose();
            _gameArena = null;
         }
         if(UnknownVarFromSnowWarEngine_GameArenaView_1 != null)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.dispose();
            UnknownVarFromSnowWarEngine_GameArenaView_1 = null;
         }
         if(_mainView)
         {
            _mainView.dispose();
            _mainView = null;
         }
         if(_incomingMessages)
         {
            _incomingMessages.dispose();
            _incomingMessages = null;
         }
         if(UnknownVarFromSnowWarEngine_LeaderboardViewController_1)
         {
            UnknownVarFromSnowWarEngine_LeaderboardViewController_1.dispose();
            UnknownVarFromSnowWarEngine_LeaderboardViewController_1 = null;
         }
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
         _config = param2 as IComponent_1;
         _isGhostEnabled = _config.getBoolean("snowwar.ghost.enabled");
         if(_isGhostEnabled)
         {
            _isGhostVisualizationEnabled = _config.getBoolean("snowwar.ghost.visualization.enabled");
            UnknownVarFromSnowWarEngine_Boolean_2 = _config.getBoolean("snowwar.ghost.immediate.enabled");
         }
         HabboGamesCom.logEnabled = _config.getBoolean("snowwar.log.enabled");
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
         _avatarManager.events.addEventListener("AVATAR_RENDER_READY",onAvatarReady);
      }
      
      private function onGroupsManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _groupsManager = param2 as IHabboGroupsManager;
      }
      
      private function onAvatarReady(param1:Event) : void
      {
         var _loc3_:XmlAsset = null;
         var _loc2_:Boolean = (context.assets as AssetLibraryCollection).hasAssetLibrary(assets.name);
         if(!_loc2_)
         {
            HabboGamesCom.log(assets.manifest);
            (context.assets as AssetLibraryCollection).addAssetLibrary(assets);
            _loc3_ = assets.getAssetByName("figure") as XmlAsset;
            _avatarManager.injectFigureData(_loc3_.content as XML);
            _avatarManager.resetAssetManager();
         }
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _roomEngine = param2 as IRoomEngine;
         _roomEngine.events.addEventListener("REE_OBJECTS_INITIALIZED",onRoomObjectsInitialized);
      }
      
      private function onRoomObjectsInitialized(param1:RoomEngineEvent) : void
      {
         if(_gameArena)
         {
            send(new Game2LoadStageReadyMessageComposer(100));
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communication)
         {
            _communication.connection.send(param1);
         }
      }
      
      private function onSoundManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _soundManager = IHabboSoundManagerFlash10(param2);
      }
      
      private function onRoomUIReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomUI = param2 as IRoomUI;
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _catalog = param2 as IHabboCatalog;
      }
      
      public function showGamesMainView() : void
      {
         _mainView.toggleVisibility();
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _habboHelp = param2 as IHabboHelp;
      }
      
      private function onFriendListReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _friendList = param2 as IHabboFriendList;
      }
      
      public function onGameDirectoryAvailable(param1:Boolean) : void
      {
         if(param1)
         {
            showGamesMainView();
         }
      }
      
      public function initArena(param1:int, param2:int, param3:int, param4:Array) : void
      {
         if(!_gameArena)
         {
            _gameArena = new SynchronizedGameArena();
            _gameArena.setExtension(new SnowWarGameArena());
            _gameArena.initialize(this,param3);
            UnknownVarFromSnowWarEngine_GameArenaView_1 = new GameArenaView(this);
            _roomSessionManager.disposeSession(-1,false);
            _roomSessionManager.startGameSession();
            registerUpdateReceiver(this,1);
            _timeSinceLastUpdate = 0;
            _currentSubTurn = 0;
            UnknownVarFromSnowWarEngine_Int_2 = 0;
         }
      }
      
      public function startServerGame(param1:String) : void
      {
         initGameDirectoryConnection();
         send(new Game2StartSnowWarMessageComposer(param1));
      }
      
      public function initGameDirectoryConnection() : void
      {
         send(new Game2CheckGameDirectoryStatusMessageComposer());
      }
      
      public function startQuickServerGame() : void
      {
         send(new Game2QuickJoinGameMessageComposer());
      }
      
      private function getCurrentStage() : SnowWarGameStage
      {
         if(!_gameArena)
         {
            return null;
         }
         return _gameArena.getCurrentStage() as SnowWarGameStage;
      }
      
      public function getCurrentPlayer() : HumanGameObject
      {
         return getPlayer(_ownId);
      }
      
      public function getPlayer(param1:int) : HumanGameObject
      {
         var _loc2_:SynchronizedGameStage = getCurrentStage();
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.getGameObject(param1) as HumanGameObject;
      }
      
      public function handleClickOnTile(param1:RoomObjectTileMouseEvent) : void
      {
         if(UnknownVarFromSnowWarEngine_Int_1 != 4)
         {
            return;
         }
         var _loc2_:int = UnknownHabboGameSnowwar1.getClickTypeOnTile(param1.altKey,param1.shiftKey);
         if(_loc2_ == 0)
         {
            moveOwnAvatarTo(param1.tileXAsInt,param1.tileYAsInt);
         }
         else
         {
            throwSnowballAt(param1.tileXAsInt,param1.tileYAsInt,getTrajectoryFromClickType(_loc2_));
         }
      }
      
      public function handleClickOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc7_:HumanGameObject = null;
         var _loc4_:HumanGameObject = null;
         var _loc6_:int = 0;
         if(UnknownVarFromSnowWarEngine_Int_1 != 4)
         {
            return;
         }
         var _loc5_:HumanGameObject = getGhostPlayer();
         if(param1 == _ownId || _isGhostEnabled && _loc5_ && param1 == _loc5_.gameObjectId)
         {
            if(makeSnowball() && UnknownVarFromSnowWarEngine_GameArenaView_1)
            {
               UnknownVarFromSnowWarEngine_GameArenaView_1.startWaitingForSnowball();
            }
         }
         else
         {
            _loc7_ = getCurrentPlayer();
            _loc4_ = getPlayer(param1);
            if(_loc7_ && _loc4_ && _loc7_.team != _loc4_.team)
            {
               _loc6_ = UnknownHabboGameSnowwar1.getClickTypeOnOpponent(param2,param3);
               throwSnowballAtHuman(param1,getTrajectoryFromClickType(_loc6_));
            }
         }
      }
      
      public function handleMouseOverOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:HumanGameObject = getPlayer(param1);
         if(!_loc6_)
         {
            return;
         }
         if(_config.getBoolean("snowstorm.settings.show_user_names"))
         {
            _loc4_ = _loc6_.team == 1 ? 4281310921 : 4290988872;
            _loc5_ = 500;
            _roomUI.showGamePlayerName(_loc6_.gameObjectId,_loc6_.name,_loc4_,_loc5_);
         }
         if(UnknownVarFromSnowWarEngine_Int_1 == 4)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.updateTileCursor(_loc6_.team);
         }
      }
      
      public function moveOwnAvatarTo(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:SnowWarGameStage = null;
         if(UnknownVarFromSnowWarEngine_Int_1 != 4)
         {
            return;
         }
         var _loc4_:HumanGameObject = getCurrentPlayer();
         if(_loc4_)
         {
            _loc6_ = param1 * 3200;
            _loc5_ = param2 * 3200;
            _loc3_ = getCurrentStage();
            if(_loc3_)
            {
               send(new Game2SetUserMoveTargetMessageComposer(_loc6_,_loc5_,_gameArena.getTurnNumber(),_gameArena.subturn));
               walkGhost(_loc4_,_loc6_,_loc5_);
            }
         }
      }
      
      public function getGhostPlayer() : HumanGameObject
      {
         var _loc1_:HumanGameObject = getCurrentPlayer();
         if(_loc1_)
         {
            return getPlayer(_loc1_.ghostObjectId);
         }
         return null;
      }
      
      private function throwSnowballAtHuman(param1:int, param2:int) : void
      {
         var _loc3_:HumanGameObject = getCurrentPlayer();
         if(_loc3_ && _loc3_.canThrowSnowballs())
         {
            send(new Game2ThrowSnowballAtHumanMessageComposer(param1,param2,_gameArena.getTurnNumber(),_gameArena.subturn));
            stopGhost();
         }
      }
      
      private function throwSnowballAt(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:HumanGameObject = getCurrentPlayer();
         if(_loc4_ && _loc4_.canThrowSnowballs())
         {
            _loc6_ = param1 * 3200;
            _loc5_ = param2 * 3200;
            send(new Game2ThrowSnowballAtPositionMessageComposer(_loc6_,_loc5_,param3,_gameArena.getTurnNumber(),_gameArena.subturn));
            stopGhost();
         }
      }
      
      private function getTrajectoryFromClickType(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 0;
               break;
            case 1:
               _loc2_ = 2;
               break;
            case 2:
               _loc2_ = 1;
               break;
            default:
               _loc2_ = 3;
         }
         return _loc2_;
      }
      
      public function makeSnowball() : Boolean
      {
         if(UnknownVarFromSnowWarEngine_Int_1 != 4)
         {
            return false;
         }
         var _loc1_:HumanGameObject = getCurrentPlayer();
         if(_loc1_ && _loc1_.canMakeSnowballs())
         {
            send(new Game2MakeSnowballMessageComposer(_gameArena.getTurnNumber(),_gameArena.subturn));
            stopGhost();
            return true;
         }
         return false;
      }
      
      private function walkGhost(param1:HumanGameObject, param2:int, param3:int) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:HumanGameObject = null;
         var _loc5_:ISynchronizedGameEvent = null;
         if(_isGhostEnabled)
         {
            _loc6_ = param1 && param1.posture != "swdieback" && param1.posture != "swdiefront";
            _loc4_ = getGhostPlayer();
            if(_loc4_ && _loc6_)
            {
               _loc5_ = new NewMoveTargetEvent(_loc4_,param2,param3);
               if(UnknownVarFromSnowWarEngine_Boolean_2)
               {
                  _loc5_.apply(gameArena.getCurrentStage());
               }
               else
               {
                  gameArena.addGameEvent(gameArena.getTurnNumber(),gameArena.subturn,_loc5_);
               }
            }
         }
      }
      
      private function stopGhost() : void
      {
         var _loc1_:HumanGameObject = null;
         if(_isGhostEnabled)
         {
            _loc1_ = getGhostPlayer();
            if(_loc1_)
            {
               _loc1_.stopMovement();
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = false;
         var _loc10_:* = false;
         var _loc2_:int = 0;
         var _loc4_:* = 0;
         if(!_gameArena || !UnknownVarFromSnowWarEngine_Int_1 == 4 || !UnknownVarFromSnowWarEngine_Int_1 == 3)
         {
            return;
         }
         if(UnknownVarFromSnowWarEngine_GameArenaView_1 && UnknownVarFromSnowWarEngine_Int_1 == 3)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.update(param1,_gameArena.subturn == 0);
         }
         _timeSinceLastUpdate += param1;
         var _loc8_:int = (_gameArena.getExtension() as SnowWarGameArena).getPulseInterval();
         if(!UnknownVarFromSnowWarEngine_Boolean_1 && _timeSinceLastUpdate > _loc8_ && _currentSubTurn < UnknownVarFromSnowWarEngine_Int_2)
         {
            _gameArena.pulse();
            _timeSinceLastUpdate -= _loc8_;
            _currentSubTurn++;
            if(_timeSinceLastUpdate > _loc8_)
            {
               _timeSinceLastUpdate = 0;
            }
            _loc9_ = UnknownVarFromSnowWarEngine_Int_2 - currentSubTurn;
            while(_loc9_-- > 3)
            {
               _gameArena.pulse();
               _currentSubTurn++;
            }
            if(UnknownVarFromSnowWarEngine_GameArenaView_1 && UnknownVarFromSnowWarEngine_Int_1 == 4)
            {
               UnknownVarFromSnowWarEngine_GameArenaView_1.update(param1,_gameArena.subturn == 0);
            }
            if(_currentSubTurn % _gameArena.getNumberOfSubTurns() == 0)
            {
               _loc5_ = gameArena.getTurnNumber() - 1;
               _loc6_ = gameArena.getCheckSum(_loc5_);
               _loc7_ = int(_serverChecksums[_loc5_]);
               checkGhostLocation(_loc5_);
               _loc3_ = _loc5_ < UnknownVarFromSnowWarEngine_Int_3 - 3;
               _loc10_ = _loc7_ != _loc6_;
               if(_loc3_ || _loc10_ || UnknownVarFromSnowWarEngine_Boolean_3)
               {
                  HabboGamesCom.log("Turn: " + [_loc5_,UnknownVarFromSnowWarEngine_Int_3] + " currentSubTurn:" + _currentSubTurn + " maxSubTurn:" + UnknownVarFromSnowWarEngine_Int_2 + " serverChecksum:" + _loc7_ + " clientChecksum:" + _loc6_);
                  if(_loc3_)
                  {
                     _loc2_ = 0;
                     _loc4_ = 16711935;
                     HabboGamesCom.log("CLIENT TOO MUCH BEHIND, requesting full status!");
                  }
                  else if(_loc10_)
                  {
                     _loc2_ = 1;
                     _loc4_ = 16711680;
                     HabboGamesCom.log("CHECKSUM MISMATCH, requesting full status!");
                  }
                  else
                  {
                     _loc2_ = -1;
                     _loc4_ = 255;
                     HabboGamesCom.log("ERROR WAS GENERATED! Requesting full status!");
                  }
                  UnknownVarFromSnowWarEngine_GameArenaView_1.showChecksumError(_loc4_);
                  requestFullStatus(_loc2_);
                  UnknownVarFromSnowWarEngine_Boolean_3 = false;
                  UnknownVarFromSnowWarEngine_Boolean_1 = true;
               }
            }
         }
      }
      
      private function checkGhostLocation(param1:int) : void
      {
         var _loc3_:HumanGameObject = null;
         var _loc6_:Location3D = null;
         var _loc2_:HumanGameObject = null;
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         if(_isGhostEnabled)
         {
            _loc3_ = getCurrentPlayer();
            _loc6_ = _loc3_.currentLocation;
            _loc2_ = getGhostPlayer();
            _loc5_ = false;
            _loc4_ = -3;
            while(_loc4_ < 3)
            {
               _loc5_ = _loc2_.isInGhostDistance(param1 + _loc4_,_loc6_);
               if(_loc5_)
               {
                  break;
               }
               _loc4_++;
            }
            _loc2_.removeGhostLocation(param1 - 3);
            if(!_loc5_ && param1 > 3)
            {
               HabboGamesCom.log("GHOST CHECKSUM MISMATCH, checksumTurn:" + param1 + " currentLocation:" + _loc6_);
               _loc2_.reinitGhost(_loc3_);
               _loc2_.addGhostLocation(param1);
               UnknownVarFromSnowWarEngine_GameArenaView_1.showChecksumError(65280);
            }
         }
      }
      
      public function nextTurn(param1:int, param2:int, param3:Boolean = false) : void
      {
         UnknownVarFromSnowWarEngine_Int_3 = param1;
         _serverChecksums[UnknownVarFromSnowWarEngine_Int_3] = param2;
         UnknownVarFromSnowWarEngine_Int_2 = (param1 + 1) * gameArena.getNumberOfSubTurns();
         if(param3)
         {
            _currentSubTurn = UnknownVarFromSnowWarEngine_Int_2 - gameArena.getNumberOfSubTurns();
            _timeSinceLastUpdate = (gameArena.getExtension() as SnowWarGameArena).getPulseInterval();
            UnknownVarFromSnowWarEngine_Boolean_1 = false;
            if(_isGhostEnabled)
            {
               getGhostPlayer().addGhostLocation(UnknownVarFromSnowWarEngine_Int_3);
            }
         }
      }
      
      public function requestFullStatus(param1:int) : void
      {
         send(new Game2RequestFullStatusUpdateMessageComposer(param1));
      }
      
      public function alert(param1:String) : void
      {
         removeOldAlert();
         if(!UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1)
         {
            UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1 = _windowManager.alert("SnowWar Alert",param1,0,onAlertClose);
         }
         else
         {
            UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1.summary = param1;
         }
         HabboGamesCom.log("[HabboGameManager.alert] " + param1);
      }
      
      public function disposeLoadingView() : void
      {
         if(UnknownVarFromSnowWarEngine_GameLoadingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameLoadingViewController_1.dispose();
            UnknownVarFromSnowWarEngine_GameLoadingViewController_1 = null;
         }
      }
      
      public function removeOldAlert() : void
      {
         if(UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1)
         {
            UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1.dispose();
            UnknownVarFromSnowWarEngine_UnknownICoreWindowUtils1_1 = null;
         }
      }
      
      public function generateChecksumMismatch() : void
      {
         if(UnknownVarFromSnowWarEngine_Int_1 != 4)
         {
            return;
         }
         UnknownVarFromSnowWarEngine_Boolean_3 = true;
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         removeOldAlert();
      }
      
      public function set ownId(param1:int) : void
      {
         _ownId = param1;
      }
      
      public function get ownId() : int
      {
         return _ownId;
      }
      
      public function initView() : void
      {
         if(UnknownVarFromSnowWarEngine_GameArenaView_1)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.init();
         }
      }
      
      public function get mainView() : GamesMainViewController
      {
         return _mainView;
      }
      
      public function get lobbyView() : GameLobbyWindowCtrl
      {
         if(_mainView)
         {
            return _mainView.lobbyView;
         }
         return null;
      }
      
      public function stageLoading(param1:int, param2:Array) : void
      {
         if(UnknownVarFromSnowWarEngine_GameLoadingViewController_1 != null)
         {
            UnknownVarFromSnowWarEngine_Int_1 = 2;
            UnknownVarFromSnowWarEngine_GameLoadingViewController_1.showReadyPlayers(param2);
         }
      }
      
      public function startStage(param1:int) : void
      {
         if(UnknownVarFromSnowWarEngine_GameArenaView_1)
         {
            _roomUI.visible = true;
            disposeLoadingView();
            playSound("HBSTG_ig_countdown");
            UnknownVarFromSnowWarEngine_GameArenaView_1.initGameUI(param1);
            UnknownVarFromSnowWarEngine_Int_1 = 3;
         }
      }
      
      public function stageRunning(param1:int) : void
      {
         if(param1 > 0)
         {
            _stageLength = param1;
            UnknownVarFromSnowWarEngine_Int_1 = 4;
         }
         else
         {
            UnknownVarFromSnowWarEngine_Int_1 = 5;
         }
         _currentSubTurn = 0;
         UnknownVarFromSnowWarEngine_Int_2 = 0;
      }
      
      public function resetGameSession() : void
      {
         _roomEngine.isGameMode = false;
         UnknownVarFromSnowWarEngine_Int_1 = 5;
         removeUpdateReceiver(this);
         if(_gameArena)
         {
            _gameArena.dispose();
            _gameArena = null;
         }
         stopSound("HBSTG_snowwar_walk");
         send(new Game2GetAccountGameStatusMessageComposer(0));
      }
      
      public function resetRoomSession() : void
      {
         _roomSessionManager.disposeGameSession();
         if(UnknownVarFromSnowWarEngine_GameArenaView_1)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.dispose();
            UnknownVarFromSnowWarEngine_GameArenaView_1 = null;
         }
      }
      
      public function gameOver(param1:int, param2:Array, param3:Game2SnowWarGameStats, param4:Game2GameResult) : void
      {
         UnknownVarFromSnowWarEngine_Int_1 = 6;
         _mainView.close(false);
         if(UnknownVarFromSnowWarEngine_GameEndingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.dispose();
            UnknownVarFromSnowWarEngine_GameEndingViewController_1 = null;
         }
         if(UnknownVarFromSnowWarEngine_GameArenaView_1)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.removeGameUI();
         }
         UnknownVarFromSnowWarEngine_GameEndingViewController_1 = new GameEndingViewController(this,param2,param3,param4,param1);
      }
      
      public function gameStarted(param1:GameLobbyData) : void
      {
         UnknownVarFromSnowWarEngine_Int_1 = 1;
         UnknownVarFromSnowWarEngine_Boolean_4 = false;
         _players = new Map();
         _serverChecksums = new Map();
         for each(var _loc2_ in param1.players)
         {
            _players.add(_loc2_.userId,_loc2_);
         }
         if(UnknownVarFromSnowWarEngine_GameEndingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.dispose();
            UnknownVarFromSnowWarEngine_GameEndingViewController_1 = null;
         }
         if(!UnknownVarFromSnowWarEngine_GameLoadingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameLoadingViewController_1 = new GameLoadingViewController(this);
         }
         UnknownVarFromSnowWarEngine_GameLoadingViewController_1.show(param1);
      }
      
      public function rejoinGame(param1:int) : void
      {
         UnknownVarFromSnowWarEngine_Int_1 = UnknownVarFromSnowWarEngine_Boolean_4 ? 7 : 6;
         _roomBeforeGame = param1;
         if(UnknownVarFromSnowWarEngine_GameEndingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.changeToWaitState(UnknownVarFromSnowWarEngine_Boolean_4);
            UnknownVarFromSnowWarEngine_Boolean_4 = false;
         }
      }
      
      public function playerRematches(param1:int) : void
      {
         if(UnknownVarFromSnowWarEngine_GameEndingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.playerRematches(param1);
         }
      }
      
      public function startLobbyCounter(param1:int) : void
      {
         if(UnknownVarFromSnowWarEngine_Int_1 == 7 && UnknownVarFromSnowWarEngine_GameEndingViewController_1 != null)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.startLobbyCountDown(param1);
         }
         else if(lobbyView)
         {
            lobbyView.startCountdown(param1);
         }
      }
      
      public function sendRejoinGame() : void
      {
         UnknownVarFromSnowWarEngine_Boolean_4 = true;
         send(new Game2PlayAgainMessageComposer());
      }
      
      public function addChatMessage(param1:int, param2:String, param3:Boolean = false) : void
      {
         if(_players == null)
         {
            return;
         }
         var _loc6_:GameLobbyPlayerData = _players.getValue(param1);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc5_:int = _loc6_.teamId == 1 ? -300 : 300;
         var _loc4_:uint = _loc6_.teamId == 1 ? 255 : 16711680;
         _gameManager.events.dispatchEvent(new GameChatEvent("gce_game_chat",param1,param2,_loc5_,_loc4_,_loc6_.figure,_loc6_.gender,_loc6_.name,_loc6_.teamId,param3));
      }
      
      public function stopLobbyCounter() : void
      {
         if(UnknownVarFromSnowWarEngine_Int_1 == 7 && UnknownVarFromSnowWarEngine_GameEndingViewController_1 != null)
         {
            UnknownVarFromSnowWarEngine_Boolean_4 = true;
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.changeToWaitState(UnknownVarFromSnowWarEngine_Boolean_4);
         }
         else if(lobbyView)
         {
            lobbyView.stopCountdown();
         }
      }
      
      public function createLobby(param1:GameLobbyData) : void
      {
         var _loc2_:* = null;
         if(UnknownVarFromSnowWarEngine_Int_1 == 6)
         {
            UnknownVarFromSnowWarEngine_Boolean_4 = true;
         }
         if(UnknownVarFromSnowWarEngine_GameEndingViewController_1 != null && UnknownVarFromSnowWarEngine_Int_1 != 7)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.changeToWaitState(UnknownVarFromSnowWarEngine_Boolean_4);
            UnknownVarFromSnowWarEngine_Int_1 = 7;
            UnknownVarFromSnowWarEngine_Boolean_4 = false;
         }
         if(UnknownVarFromSnowWarEngine_Int_1 == 7 && UnknownVarFromSnowWarEngine_GameEndingViewController_1 != null)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.changeToLobbyState(param1);
            for each(_loc2_ in param1.players)
            {
               UnknownVarFromSnowWarEngine_GameEndingViewController_1.playerJoined(_loc2_);
            }
         }
         else
         {
            UnknownVarFromSnowWarEngine_Int_1 = 0;
            mainView.openGameLobbyWindow(getArenaName(param1),param1.numberOfTeams,param1.maximumPlayers);
            for each(_loc2_ in param1.players)
            {
               lobbyView.playerJoined(_loc2_);
            }
         }
      }
      
      public function userJoined(param1:GameLobbyPlayerData) : void
      {
         if(UnknownVarFromSnowWarEngine_Int_1 == 7 && UnknownVarFromSnowWarEngine_GameEndingViewController_1 != null)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.playerJoined(param1);
         }
         else
         {
            UnknownVarFromSnowWarEngine_Int_1 = 0;
            if(lobbyView)
            {
               lobbyView.playerJoined(param1);
            }
         }
      }
      
      public function userLeft(param1:int) : void
      {
         if(UnknownVarFromSnowWarEngine_Int_1 == 7 && UnknownVarFromSnowWarEngine_GameEndingViewController_1 != null)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.playerLeft(param1);
         }
         else
         {
            UnknownVarFromSnowWarEngine_Int_1 = 0;
            if(lobbyView)
            {
               lobbyView.playerLeft(param1);
            }
         }
      }
      
      public function gamesLeft(param1:int, param2:Boolean, param3:int) : void
      {
         if(param1 == 0)
         {
            _hasUnlimitedGames = param2;
            _freeGamesLeft = param3;
            if(UnknownVarFromSnowWarEngine_GameEndingViewController_1)
            {
               UnknownVarFromSnowWarEngine_GameEndingViewController_1.updateGamesLeft();
            }
            if(_mainView)
            {
               _mainView.updateGameStartingStatus();
            }
         }
      }
      
      public function get isGameStarting() : Boolean
      {
         return UnknownVarFromSnowWarEngine_Int_1 == 1 || UnknownVarFromSnowWarEngine_Int_1 == 7;
      }
      
      public function resetSession() : void
      {
         resetGameSession();
         resetRoomSession();
         if(UnknownVarFromSnowWarEngine_GameEndingViewController_1)
         {
            UnknownVarFromSnowWarEngine_GameEndingViewController_1.dispose();
            UnknownVarFromSnowWarEngine_GameEndingViewController_1 = null;
         }
         if(_mainView)
         {
            _mainView.openMainWindow(false);
         }
      }
      
      public function gameCancelled(param1:Boolean) : void
      {
         resetSession();
         if(param1)
         {
            _gameManager.onSnowWarArenaSessionEnded();
         }
      }
      
      public function get hasUnlimitedGames() : Boolean
      {
         return _hasUnlimitedGames;
      }
      
      public function get freeGamesLeft() : int
      {
         return _freeGamesLeft;
      }
      
      public function stopWaitingForSnowball(param1:int) : void
      {
         if(UnknownVarFromSnowWarEngine_GameArenaView_1 != null && param1 == _ownId)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.stopWaitingForSnowball();
         }
      }
      
      public function openGetMoreGames(param1:String) : void
      {
         _catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS");
         logGameEvent(param1);
      }
      
      public function openClubCenter(param1:String) : void
      {
         _catalog.openClubCenter();
         logGameEvent(param1);
      }
      
      public function logGameEvent(param1:String) : void
      {
         send(new EventLogMessageComposer("GameFramework","SnowStorm",param1,"",freeGamesLeft));
      }
      
      public function registerHit(param1:HumanGameObject, param2:HumanGameObject) : void
      {
         if(_ownId == param1.gameObjectId)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.flashOwnScore(false);
         }
         else if(_ownId == param2.gameObjectId)
         {
            UnknownVarFromSnowWarEngine_GameArenaView_1.flashOwnScore(true);
         }
      }
      
      public function set gamesPlayed(param1:int) : void
      {
         UnknownVarFromSnowWarEngine_Int_4 = param1;
      }
      
      public function promoteGame() : void
      {
         if(UnknownVarFromSnowWarEngine_Boolean_5 || UnknownVarFromSnowWarEngine_Int_4 != 0)
         {
            return;
         }
         UnknownVarFromSnowWarEngine_Boolean_5 = true;
         var _loc2_:* = _config.getInteger("new.identity",0) > 0;
         var _loc1_:String = _config.getProperty("new.user.wing");
         if(_loc2_ && _loc1_ != "game")
         {
            return;
         }
         _habboHelp.showWelcomeScreen("HTIE_ICON_GAMES","snowwar.promotion",0,"GAMES");
      }
      
      public function showLeaderboard() : void
      {
         leaderboard.selectedGame = 0;
         leaderboard.showFriendsAllTime();
      }
      
      public function get leaderboard() : LeaderboardViewController
      {
         if(!UnknownVarFromSnowWarEngine_LeaderboardViewController_1 && !gameCenterEnabled)
         {
            UnknownVarFromSnowWarEngine_LeaderboardViewController_1 = new LeaderboardViewController(this);
         }
         return UnknownVarFromSnowWarEngine_LeaderboardViewController_1;
      }
   }
}

