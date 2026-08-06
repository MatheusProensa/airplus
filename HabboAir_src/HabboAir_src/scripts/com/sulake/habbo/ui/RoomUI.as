package com.sulake.habbo.ui
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.advertisement.IAdManager;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.advertisement.events.InterstitialEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IHabboAvatarEditorManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.habbicons.HabbiconControllerEvent;
   import com.sulake.habbo.catalog.habbicons.IHabbiconController;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.advertisement.InterstitialShownMessageComposer;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.style.UnknownIHabboFreeflowchatStyle2;
   import com.sulake.habbo.friendbar.IHabboFriendBar;
   import com.sulake.habbo.friendbar.IHabboLandingView;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.IHabboGameManager;
   import com.sulake.habbo.groups.IHabboGroupsManager;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.quest.IHabboQuestEngine;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
   import com.sulake.habbo.room.events.RoomEngineZoomEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.events.SessionDataEvent;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   import com.sulake.habbo.ui.widget.RoomWidgetFactory;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.events.HideRoomWidgetEvent;
   import com.sulake.habbo.ui.widget.events.RoomDesktopMouseZoomEnableEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.*;
   import com.sulake.room.utils.RoomId;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class RoomUI extends Component implements IRoomUI, IProfiler_1
   {
      private static var _reuseRoomDesktopWidgetTypes:Array = ["RWE_INFOSTAND","RWE_CHAT_INPUT_WIDGET","RWE_ME_MENU","RWE_EXTERNAL_IMAGE","RWE_CAMERA","RWE_ROOM_TOOLS","RWE_FURNITURE_CONTEXT_MENU"];
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var UnknownVarFromRoomUI_IRoomWidgetFactory_1:IRoomWidgetFactory;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _friendList:IHabboFriendList;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _inventory:IHabboInventory;
      
      private var _toolbar:IHabboToolbar;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _habboGroupsManager:IHabboGroupsManager;
      
      private var _avatarEditor:IHabboAvatarEditorManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _adManager:IAdManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _messenger:IHabboMessenger;
      
      private var _moderation:IHabboModeration;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _gameManager:IHabboGameManager;
      
      private var _friendBar:IHabboFriendBar;
      
      private var _friendBarView:IHabboFriendBarView;
      
      private var _landingView:IHabboLandingView;
      
      private var _questEngine:IHabboQuestEngine;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _habbiconController:IHabbiconController;
      
      private var _desktop:RoomDesktop;
      
      private var UnknownVarFromRoomUI_Dictionary_1:Dictionary;
      
      private var UnknownVarFromRoomUI_Int_1:int = -1;
      
      private var UnknownVarFromRoomUI_Boolean_1:Boolean;
      
      private var UnknownVarFromRoomUI_Int_2:int;
      
      private var _habboTracking:IHabboTracking;
      
      private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
      
      private var UnknownVarFromRoomUI_Boolean_2:Boolean = false;
      
      private var _isInRoom:Boolean = false;
      
      private var _perkAllowancesMessageEvent:IMessageEvent;
      
      public function RoomUI(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         UnknownVarFromRoomUI_IRoomWidgetFactory_1 = new RoomWidgetFactory(this);
         UnknownVarFromRoomUI_Dictionary_1 = new Dictionary();
         registerUpdateReceiver(this,0);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },true,[{
            "type":"REE_ENGINE_INITIALIZED",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_INITIALIZED",
            "callback":roomEventHandler
         },{
            "type":"REE_OBJECTS_INITIALIZED",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         },{
            "type":"REE_NORMAL_MODE",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_GAME_MODE",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_ENTRANCE_AFTER_SPECTATE",
            "callback":roomEventHandler
         },{
            "type":"REDSE_ROOM_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REE_ROOM_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REE_ROOM_ZOOM",
            "callback":roomEventHandler
         },{
            "type":"ROHSLCEE_ROOM_BACKGROUND_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REOE_SELECTED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_DESELECTED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_ADDED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REMOVED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_PLACED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_MOVE",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_ROTATE",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_PICKUP",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_MOUSE_ENTER",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_MOUSE_LEAVE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_OPEN_WIDGET",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_CLOSE_WIDGET",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_OPEN_FURNI_CONTEXT_MENU",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_CLOSE_FURNI_CONTEXT_MENU",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_CREDITFURNI",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_STICKIE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PRESENT",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_TROPHY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_TEASER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ECOTRONBOX",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PLACEHOLDER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_DIMMER",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_FURNI_CLICK",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_FURNI_DOUBLE_CLICK",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_TOOLTIP_SHOW",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_TOOLTIP_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REMOVE_DIMMER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_CLOTHING_CHANGE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PLAYLIST_EDITOR",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_MANNEQUIN",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_BACKGROUND_COLOR",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_AREA_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_UPDATE_STATE_AREA_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_USE_PRODUCT_FROM_INVENTORY",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_USE_PRODUCT_FROM_ROOM",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_JUKEBOX_DISPOSE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_HIGH_SCORE_DISPLAY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_INTERNAL_LINK",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ROOM_LINK",
            "callback":roomObjectEventHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },true,[{
            "type":"RSE_CREATED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_STARTED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ENDED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ROOM_DATA",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSCE_CHAT_EVENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSCE_FLOOD_EVENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSUBE_BADGES",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_DOORBELL",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_REJECTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_ACCEPTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_PRESENT_OPENED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSOPPE_OPEN_PET_PACKAGE_REQUESTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSOPPE_OPEN_PET_PACKAGE_RESULT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSEME_KICKED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_PETS_FORBIDDEN_IN_HOTEL",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_PETS_FORBIDDEN_IN_FLAT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_MAX_PETS",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_MAX_NUMBER_OF_OWN_PETS",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_NO_FREE_TILES_FOR_PET",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_PET",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOTS_FORBIDDEN_IN_HOTEL",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOTS_FORBIDDEN_IN_FLAT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOT_LIMIT_REACHED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOT_NAME_NOT_ACCEPTED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSQE_QUEUE_STATUS",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_CONTENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_ERROR",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_OFFER",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_QUESTION_ANSWERED",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_QUESION_FINSIHED",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_NEW_QUESTION",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDPE_PRESETS",
            "callback":roomSessionEventHandler
         },{
            "type":"RSFRE_FRIEND_REQUEST",
            "callback":roomSessionEventHandler
         },{
            "type":"rsudue_user_data_updated",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_DANCE",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },true,[{
            "type":"SDTWE_PURCHASABLE_STYLES_UPDATED",
            "callback":sessionDataEventHandler
         }]),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         }),new ComponentDependency(new IIDHabboGroupsManager(),function(param1:IHabboGroupsManager):void
         {
            _habboGroupsManager = param1;
         }),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:IHabboAvatarEditorManager):void
         {
            _avatarEditor = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabbiconController(),function(param1:IHabbiconController):void
         {
            if(_habbiconController != null)
            {
               _habbiconController.removeEventListener("hce_room_use_habbicon",onRoomUseHabbicon);
            }
            _habbiconController = param1;
            if(_habbiconController != null && getBoolean("habbicons.enabled"))
            {
               _habbiconController.addEventListener("hce_room_use_habbicon",onRoomUseHabbicon);
            }
         }),new ComponentDependency(new IIDHabboAdManager(),function(param1:IAdManager):void
         {
            _adManager = param1;
         },true,[{
            "type":"AE_INTERSTITIAL_NOT_SHOWN",
            "callback":interstitialNotAvailableEventHandler
         },{
            "type":"AE_INTERSTITIAL_COMPLETE",
            "callback":interstitialCompleteEventHandler
         },{
            "type":"AE_INTERSTITIAL_SHOW",
            "callback":interstitialShowEventHandler
         },{
            "type":"AE_ROOM_AD_SHOW",
            "callback":adEventHandler
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboModeration(),function(param1:IHabboModeration):void
         {
            _moderation = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _userDefinedRoomEvents = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _habboTracking = param1;
         }),new ComponentDependency(new IIDHabboGameManager(),function(param1:IHabboGameManager):void
         {
            _gameManager = param1;
         },true,[{
            "type":"gce_game_chat",
            "callback":gameEventHandler
         }]),new ComponentDependency(new IIDHabboFriendBar(),function(param1:IHabboFriendBar):void
         {
            _friendBar = param1;
         }),new ComponentDependency(new IIDHabboFriendBarView(),function(param1:IHabboFriendBarView):void
         {
            _friendBarView = param1;
         },true,[{
            "type":"FBE_BAR_RESIZE_EVENT",
            "callback":bottomBarResizeHandler
         }]),new ComponentDependency(new IIDHabboLandingView(),function(param1:IHabboLandingView):void
         {
            _landingView = param1;
         }),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:IHabboQuestEngine):void
         {
            _questEngine = param1;
         }),new ComponentDependency(new IIDHabboMessenger(),function(param1:IHabboMessenger):void
         {
            _messenger = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _perkAllowancesMessageEvent = _communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
      }
      
      override public function dispose() : void
      {
         var _loc1_:IRoomWidget = null;
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromRoomUI_IRoomWidgetFactory_1 != null)
         {
            UnknownVarFromRoomUI_IRoomWidgetFactory_1.dispose();
            UnknownVarFromRoomUI_IRoomWidgetFactory_1 = null;
         }
         if(_communication != null)
         {
            _communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
            _perkAllowancesMessageEvent = null;
         }
         if(_habbiconController != null)
         {
            _habbiconController.removeEventListener("hce_room_use_habbicon",onRoomUseHabbicon);
            _habbiconController = null;
         }
         disposeDesktop();
         if(UnknownVarFromRoomUI_Dictionary_1 != null)
         {
            for(var _loc2_ in UnknownVarFromRoomUI_Dictionary_1)
            {
               _loc1_ = UnknownVarFromRoomUI_Dictionary_1[_loc2_];
               _loc1_.dispose();
            }
            UnknownVarFromRoomUI_Dictionary_1 = null;
         }
         removeUpdateReceiver(this);
         super.dispose();
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSE_CREATED":
               createDesktop(param1.session);
               if(param1.session.isGameSession)
               {
                  if(_toolbar)
                  {
                     _toolbar.setToolbarState("HTE_STATE_HIDDEN");
                  }
                  if(_friendBar)
                  {
                     _friendBar.visible = false;
                  }
                  if(_landingView)
                  {
                     _landingView.disable();
                  }
               }
               break;
            case "RSE_STARTED":
               if(_toolbar)
               {
                  defineToolbarState(param1.session);
               }
               if(_landingView)
               {
                  _landingView.disable();
               }
               break;
            case "RSE_ROOM_DATA":
               defineToolbarState(param1.session);
               break;
            case "RSE_ENDED":
               if(param1.session != null)
               {
                  disposeDesktop();
                  if(param1.session.isGameSession)
                  {
                     _friendBar.visible = true;
                     if(_gameManager)
                     {
                        _gameManager.onSnowWarArenaSessionEnded();
                     }
                  }
                  else if(param1.openLandingPage)
                  {
                     if(getBoolean("nux.lobbies.enabled") && _sessionDataManager.isRealNoob)
                     {
                        if(_navigator.enteredGuestRoomData && _navigator.enteredGuestRoomData.doorMode == 4)
                        {
                           _navigator.goToHomeRoom();
                        }
                        else
                        {
                           context.createLinkEvent("navigator/goto/predefined_noob_lobby");
                        }
                     }
                     else if(_landingView)
                     {
                        _landingView.activate();
                     }
                  }
               }
         }
      }
      
      private function defineToolbarState(param1:IRoomSession) : void
      {
         if(getBoolean("nux.lobbies.enabled") && _sessionDataManager.isRealNoob)
         {
            if(param1 && param1.isNoobRoom)
            {
               _toolbar.setToolbarState("HTE_STATE_NOOB_NOT_HOME");
            }
            else
            {
               _toolbar.setToolbarState("HETE_STATE_NOOB_HOME");
            }
         }
         else
         {
            _toolbar.setToolbarState("HTE_STATE_ROOM_VIEW");
         }
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(param1.session != null)
         {
            if(_desktop != null)
            {
               _desktop.processEvent(param1);
            }
         }
      }
      
      private function sessionDataEventHandler(param1:SessionDataEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(desktop != null)
         {
            desktop.processEvent(param1);
         }
      }
      
      private function roomSessionDialogEventHandler(param1:RoomSessionEvent) : void
      {
         var errorMessage:String;
         var event:RoomSessionEvent = param1;
         var errorTitle:String = "${error.title}";
         switch(event.type)
         {
            case "RSEME_MAX_PETS":
               errorMessage = "${room.error.max_pets}";
               break;
            case "RSEME_MAX_NUMBER_OF_OWN_PETS":
               errorMessage = "${room.error.max_own_pets}";
               break;
            case "RSEME_KICKED":
               errorMessage = "${room.error.kicked}";
               errorTitle = "${generic.alert.title}";
               break;
            case "RSEME_PETS_FORBIDDEN_IN_HOTEL":
               errorMessage = "${room.error.pets.forbidden_in_hotel}";
               break;
            case "RSEME_PETS_FORBIDDEN_IN_FLAT":
               errorMessage = "${room.error.pets.forbidden_in_flat}";
               break;
            case "RSEME_NO_FREE_TILES_FOR_PET":
               errorMessage = "${room.error.pets.no_free_tiles}";
               break;
            case "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET":
               errorMessage = "${room.error.pets.selected_tile_not_free}";
               break;
            case "RSEME_BOTS_FORBIDDEN_IN_HOTEL":
               errorMessage = "${room.error.bots.forbidden_in_hotel}";
               break;
            case "RSEME_BOTS_FORBIDDEN_IN_FLAT":
               errorMessage = "${room.error.bots.forbidden_in_flat}";
               break;
            case "RSEME_BOT_LIMIT_REACHED":
               errorMessage = "${room.error.max_bots}";
               break;
            case "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT":
               errorMessage = "${room.error.bots.selected_tile_not_free}";
               break;
            case "RSEME_BOT_NAME_NOT_ACCEPTED":
               errorMessage = "${room.error.bots.name.not.accepted}";
               break;
            default:
               return;
         }
         _windowManager.alert(errorTitle,errorMessage,0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      private function interstitialShowEventHandler(param1:InterstitialEvent) : void
      {
         if(_desktop != null)
         {
            _desktop.processEvent(param1);
         }
         UnknownVarFromRoomUI_Boolean_1 = true;
      }
      
      public function triggerbottomBarResize() : void
      {
         bottomBarResizeHandler(new FriendBarResizeEvent());
      }
      
      private function bottomBarResizeHandler(param1:FriendBarResizeEvent) : void
      {
         if(_desktop != null)
         {
            _desktop.processEvent(param1);
         }
      }
      
      private function interstitialNotAvailableEventHandler(param1:InterstitialEvent) : void
      {
         UnknownVarFromRoomUI_Boolean_1 = false;
      }
      
      private function interstitialCompleteEventHandler(param1:InterstitialEvent) : void
      {
         var _loc2_:IRoomSession = null;
         UnknownVarFromRoomUI_Boolean_1 = false;
         if(param1.status == "complete")
         {
            _communication.connection.send(new InterstitialShownMessageComposer());
         }
         if(_desktop != null)
         {
            _desktop.processEvent(param1);
            _loc2_ = _roomSessionManager.getSession(_roomEngine.activeRoomId);
            if(_loc2_ != null)
            {
               _loc2_.sendChangePostureMessage(0);
            }
         }
      }
      
      private function adEventHandler(param1:AdEvent) : void
      {
         if(_desktop != null)
         {
            _desktop.processEvent(param1);
         }
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         var _loc2_:Timer = null;
         if(_freeFlowChat && _isInRoom && !UnknownVarFromRoomUI_Boolean_2)
         {
            _loc2_ = new Timer(250,1);
            _loc2_.addEventListener("timerComplete",delayedAddToStageFreeFlowChat);
            _loc2_.start();
         }
         if(_isInRoom)
         {
            if(_desktop != null)
            {
               _desktop.processEvent(new RoomDesktopMouseZoomEnableEvent(param1.getParser().isPerkAllowed("MOUSE_ZOOM")));
            }
         }
      }
      
      private function delayedAddToStageFreeFlowChat(param1:TimerEvent) : void
      {
         if(_desktop && _freeFlowChat.displayObject)
         {
            _desktop.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
            UnknownVarFromRoomUI_Boolean_2 = true;
         }
      }
      
      private function roomEngineEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:IRoomSession = null;
         if(param1.type == "REE_GAME_MODE" || param1.type == "REE_NORMAL_MODE")
         {
            if(_desktop != null)
            {
               _desktop.roomEngineEventHandler(param1);
            }
         }
         if(param1.roomId == UnknownVarFromRoomUI_Int_2)
         {
            if(param1.type == "REE_OBJECTS_INITIALIZED")
            {
               if(UnknownVarFromRoomUI_Boolean_1)
               {
                  _loc2_ = _roomSessionManager.getSession(UnknownVarFromRoomUI_Int_2);
                  if(_loc2_ != null)
                  {
                     _loc2_.sendAvatarExpressionMessage(AvatarExpressionEnum.UnknownConstFromAvatarExpressionEnum_AvatarExpressionEnum_1.ordinal);
                  }
               }
               UnknownVarFromRoomUI_Boolean_1 = false;
            }
            else if(param1.type == "REE_DISPOSED")
            {
               UnknownVarFromRoomUI_Boolean_1 = false;
            }
         }
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc4_:IRoomSession = null;
         var _loc2_:int = 0;
         var _loc5_:RoomEngineRoomColorEvent = null;
         var _loc3_:RoomEngineZoomEvent = null;
         var _loc6_:Number = NaN;
         var _loc7_:RoomEngineHSLColorEnableEvent = null;
         if(_roomEngine == null)
         {
            return;
         }
         if(_desktop == null)
         {
            if(_roomSessionManager == null)
            {
               return;
            }
            _loc4_ = _roomSessionManager.getSession(param1.roomId);
            if(_loc4_ != null)
            {
               createDesktop(_loc4_);
            }
         }
         if(_desktop == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "REE_INITIALIZED":
               _loc2_ = getActiveCanvasId(param1.roomId);
               _desktop.createRoomView(_loc2_);
               if(_roomEngine != null && !RoomId.isRoomPreviewerId(param1.roomId))
               {
                  _roomEngine.setActiveRoom(param1.roomId);
                  _desktop.initCameraLocation(_loc2_);
               }
               if(_freeFlowChat)
               {
                  UnknownVarFromRoomUI_Boolean_2 = true;
                  if(_freeFlowChat.displayObject != null)
                  {
                     _desktop.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
                  }
               }
               createDesktopWidget("RWE_INFOSTAND");
               createDesktopWidget("RWE_LOCATION_WIDGET");
               createDesktopWidget("RWE_ROOM_TOOLS");
               if(!_desktop.session.isSpectatorMode)
               {
                  createDesktopWidget("RWE_ME_MENU");
                  createDesktopWidget("RWE_CHAT_INPUT_WIDGET");
                  createDesktopWidget("RWE_FRIEND_REQUEST");
                  if(getBoolean("avatar.widget.enabled"))
                  {
                     createDesktopWidget("RWE_AVATAR_INFO");
                  }
               }
               createDesktopWidget("RWE_FURNI_PLACEHOLDER");
               createDesktopWidget("RWE_FURNI_CREDIT_WIDGET");
               createDesktopWidget("RWE_FURNI_STICKIE_WIDGET");
               createDesktopWidget("RWE_FURNI_PRESENT_WIDGET");
               createDesktopWidget("RWE_FURNI_TROPHY_WIDGET");
               createDesktopWidget("RWE_FURNI_ECOTRONBOX_WIDGET");
               createDesktopWidget("RWE_FURNI_PET_PACKAGE_WIDGET");
               createDesktopWidget("RWE_DOORBELL");
               createDesktopWidget("RWE_ROOM_POLL");
               createDesktopWidget("RWE_ROOM_DIMMER");
               createDesktopWidget("RWE_CLOTHING_CHANGE");
               createDesktopWidget("RWE_CONVERSION_TRACKING");
               if(!getBoolean("memenu.effects.widget.disabled"))
               {
                  createDesktopWidget("RWE_EFFECTS");
               }
               createDesktopWidget("RWE_MANNEQUIN");
               createDesktopWidget("RWE_ROOM_BACKGROUND_COLOR");
               createDesktopWidget("RWE_AREA_HIDE");
               createDesktopWidget("RWE_CUSTOM_USER_NOTIFICATION");
               createDesktopWidget("RWE_FURNI_CHOOSER");
               createDesktopWidget("RWE_USER_CHOOSER",UnknownVarFromRoomUI_Int_1);
               createDesktopWidget("RWE_PLAYLIST_EDITOR_WIDGET");
               createDesktopWidget("RWE_SPAMWALL_POSTIT_WIDGET");
               createDesktopWidget("RWE_FURNITURE_CONTEXT_MENU");
               createDesktopWidget("RWE_CAMERA");
               createDesktopWidget("RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING");
               createDesktopWidget("RWE_FRIEND_FURNI_CONFIRM");
               createDesktopWidget("RWE_FRIEND_FURNI_ENGRAVING");
               createDesktopWidget("RWE_HIGH_SCORE_DISPLAY");
               createDesktopWidget("RWE_INTERNAL_LINK");
               createDesktopWidget("RWE_CUSTOM_STACK_HEIGHT");
               createDesktopWidget("RWE_YOUTUBE");
               createDesktopWidget("RWE_RENTABLESPACE");
               createDesktopWidget("RWE_VIMEO");
               createDesktopWidget("RWE_EXTERNAL_IMAGE");
               createDesktopWidget("RWE_UI_HELP_BUBBLE");
               createDesktopWidget("RWE_WORD_QUIZZ");
               createDesktopWidget("RWE_ROOM_THUMBNAIL_CAMERA");
               createDesktopWidget("RWE_ROOM_LINK");
               createDesktopWidget("RWE_CRAFTING");
               _isInRoom = true;
               break;
            case "REE_ENTRANCE_AFTER_SPECTATE":
               desktop.enterAfterSpectate();
               desktop.disposeWidget("RWE_ROOM_QUEUE");
               desktop.createWidget("RWE_ME_MENU");
               desktop.createWidget("RWE_CHAT_INPUT_WIDGET");
               desktop.createWidget("RWE_FRIEND_REQUEST");
               if(getBoolean("avatar.widget.enabled"))
               {
                  desktop.createWidget("RWE_AVATAR_INFO");
               }
               break;
            case "REE_DISPOSED":
               disposeDesktop();
               _isInRoom = false;
               break;
            case "REE_ROOM_COLOR":
               _loc5_ = param1 as RoomEngineRoomColorEvent;
               if(_loc5_ != null)
               {
                  if(_loc5_.bgOnly)
                  {
                     _desktop.setRoomViewColor(16777215,255);
                  }
                  else
                  {
                     _desktop.setRoomViewColor(_loc5_.color,_loc5_.brightness);
                  }
               }
               break;
            case "REE_ROOM_ZOOM":
               _loc3_ = param1 as RoomEngineZoomEvent;
               if(_loc3_ != null)
               {
                  _loc6_ = Number(_loc3_.level < 1 ? 0.5 : 1 << Math.min(5,Math.floor(_loc3_.level)) - 1);
                  if(_desktop != null && !_loc3_.isFlipForced)
                  {
                     _desktop.animateRoomCanvasScale(_loc6_);
                  }
                  else
                  {
                     _roomEngine.setRoomCanvasScale(_roomEngine.activeRoomId,getActiveCanvasId(_roomEngine.activeRoomId),_loc6_,null,null,_loc3_.isFlipForced);
                  }
               }
               break;
            case "REDSE_ROOM_COLOR":
               _desktop.processEvent(param1);
               break;
            case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
               _loc7_ = RoomEngineHSLColorEnableEvent(param1);
               if(!_loc7_.enable)
               {
                  _desktop.setRoomBackgroundColor(0,0,0);
               }
               else
               {
                  _desktop.setRoomBackgroundColor(_loc7_.hue,_loc7_.saturation,_loc7_.lightness);
               }
         }
      }
      
      private function createDesktopWidget(param1:String, param2:int = 0) : void
      {
         if(_desktop == null)
         {
            return;
         }
         var _loc5_:Boolean = false;
         var _loc4_:IRoomWidget = null;
         if(_reuseRoomDesktopWidgetTypes.indexOf(param1) != -1)
         {
            _loc5_ = true;
            _loc4_ = UnknownVarFromRoomUI_Dictionary_1[param1];
         }
         var _loc3_:IRoomWidget = _desktop.createWidget(param1,_loc5_,_loc4_);
         if(_loc5_ && _loc4_ == null && _loc3_ != null)
         {
            UnknownVarFromRoomUI_Dictionary_1[param1] = _loc3_;
         }
         if(_loc3_ != null)
         {
            _loc3_.initialize(param2);
         }
      }
      
      private function roomObjectEventHandler(param1:RoomEngineObjectEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(_desktop != null)
         {
            _desktop.roomObjectEventHandler(param1);
         }
      }
      
      private function gameEventHandler(param1:Event) : void
      {
         if(_desktop)
         {
            _desktop.processEvent(param1);
         }
      }
      
      public function createDesktop(param1:IRoomSession) : IRoomDesktop
      {
         if(disposed || param1 == null)
         {
            return null;
         }
         if(_roomEngine == null)
         {
            return null;
         }
         if(_desktop != null)
         {
            return _desktop;
         }
         _desktop = new RoomDesktop(param1,assets,_communication.connection);
         _desktop.roomEngine = _roomEngine;
         _desktop.windowManager = _windowManager;
         _desktop.roomWidgetFactory = UnknownVarFromRoomUI_IRoomWidgetFactory_1;
         _desktop.sessionDataManager = _sessionDataManager;
         _desktop.roomSessionManager = _roomSessionManager;
         _desktop.communicationManager = _communication;
         _desktop.friendList = _friendList;
         _desktop.avatarRenderManager = _avatarRenderManager;
         _desktop.inventory = _inventory;
         _desktop.messenger = _messenger;
         _desktop.toolbar = _toolbar;
         _desktop.navigator = _newNavigator.legacyNavigator;
         _desktop.habboGroupsManager = _habboGroupsManager;
         _desktop.avatarEditor = _avatarEditor;
         _desktop.catalog = _catalog;
         _desktop.adManager = _adManager;
         _desktop.localization = _localization;
         _desktop.habboHelp = _habboHelp;
         _desktop.moderation = _moderation;
         _desktop.config = this;
         _desktop.soundManager = _soundManager;
         _desktop.habboTracking = _habboTracking;
         _desktop.userDefinedRoomEvents = _userDefinedRoomEvents;
         _desktop.gameManager = _gameManager;
         _desktop.questEngine = _questEngine;
         _desktop.freeFlowChat = _freeFlowChat;
         var _loc2_:XmlAsset = assets.getAssetByName("room_desktop_layout_xml") as XmlAsset;
         if(_loc2_ != null)
         {
            _desktop.layout = _loc2_.content as XML;
         }
         createDesktopWidget("RWE_LOADINGBAR");
         createDesktopWidget("RWE_ROOM_QUEUE");
         _desktop.init();
         _desktop.requestInterstitial();
         UnknownVarFromRoomUI_Boolean_1 = false;
         UnknownVarFromRoomUI_Int_2 = param1.roomId;
         return _desktop;
      }
      
      public function get chatContainer() : IDisplayObjectWrapperController
      {
         if(!_desktop || !_desktop.layoutManager)
         {
            return null;
         }
         return _desktop.layoutManager.getChatContainer();
      }
      
      public function disposeDesktop() : void
      {
         var _loc1_:int = 0;
         if(_desktop != null)
         {
            _loc1_ = _desktop.getWidgetState("RWE_USER_CHOOSER");
            if(_loc1_ != -1)
            {
               UnknownVarFromRoomUI_Int_1 = _loc1_;
            }
            _desktop.dispose();
            _desktop = null;
            UnknownVarFromRoomUI_Boolean_1 = false;
         }
      }
      
      public function getActiveCanvasId(param1:int) : int
      {
         return 1;
      }
      
      public function update(param1:uint) : void
      {
         if(_desktop != null)
         {
            _desktop.update(param1);
         }
      }
      
      private function onRoomUseHabbicon(param1:HabbiconControllerEvent) : void
      {
         var _loc2_:int = 0;
         if(!getBoolean("habbicons.enabled") || param1 == null || param1.roomIndex < 0 || param1.habbiconId <= 0 || _desktop == null || _desktop.roomSession == null || _roomEngine == null)
         {
            return;
         }
         _loc2_ = _desktop.roomSession.roomId;
         _roomEngine.updateObjectUserAction(_loc2_,param1.roomIndex,"figure_habbicon",param1.habbiconId);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(_desktop != null)
         {
            _desktop.visible = param1;
         }
      }
      
      public function hideWidget(param1:String) : void
      {
         if(_desktop != null)
         {
            _desktop.processEvent(new HideRoomWidgetEvent(param1));
         }
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         if(_desktop != null)
         {
            _desktop.showGamePlayerName(param1,param2,param3,param4);
         }
      }
      
      public function mouseEventPositionHasContextMenu(param1:MouseEvent) : Boolean
      {
         if(_desktop != null)
         {
            return _desktop.mouseEventPositionHasInputEventWindow(param1,0);
         }
         return false;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get habbiconController() : IHabbiconController
      {
         return _habbiconController;
      }
      
      public function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents
      {
         return _userDefinedRoomEvents;
      }
      
      public function get inventory() : IHabboInventory
      {
         return _inventory;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get soundManager() : IHabboSoundManagerFlash10
      {
         return _soundManager;
      }
      
      public function get habboTracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function get habboGroupsManager() : IHabboGroupsManager
      {
         return _habboGroupsManager;
      }
      
      public function get friendBarView() : IHabboFriendBarView
      {
         return _friendBarView;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get chatStyleLibrary() : UnknownIHabboFreeflowchatStyle2
      {
         if(_freeFlowChat)
         {
            return _freeFlowChat.chatStyleLibrary;
         }
         return null;
      }
      
      public function get freeFlowChat() : IHabboFreeFlowChat
      {
         return _freeFlowChat;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get desktop() : IRoomDesktop
      {
         return _desktop;
      }
   }
}

