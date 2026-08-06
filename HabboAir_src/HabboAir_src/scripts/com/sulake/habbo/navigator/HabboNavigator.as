package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsData;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.ConvertGlobalRoomIdMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToSomeRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RemoveOwnRoomRightsRoomMessageComposer;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.inroom.*;
   import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
   import com.sulake.habbo.navigator.roomsettings.EnforceCategoryCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomFilterCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.navigator.toolbar.ToolbarHoverCtrl;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HabboNavigator extends Component implements IHabboNavigator_1, IHabboNavigator_2, ILinkEventTracker
   {
      private var _communication:IHabboCommunicationManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _sessionData:ISessionDataManager;
      
      private var _tracking:IHabboTracking;
      
      private var _catalog:IHabboCatalog;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarManager:IAvatarRenderManager;
      
      private var _mainViewCtrl:MainViewCtrl;
      
      private var _roomInfoViewCtrl:RoomInfoViewCtrl;
      
      private var _roomCreateViewCtrl:RoomCreateViewCtrl;
      
      private var _data:NavigatorData;
      
      private var _tabs:Tabs;
      
      private var _assetLibrary:IAssetLibraryCollection;
      
      private var _incomingMessages:IncomingMessages;
      
      private var _toolbar:IHabboToolbar;
      
      private var _roomSettingsCtrl:RoomSettingsCtrl;
      
      private var _passwordInput:GuestRoomPasswordInput;
      
      private var _doorbell:GuestRoomDoorbell;
      
      private var _officialRoomEntryManager:OfficialRoomEntryManager;
      
      private var _roomEventViewCtrl:RoomEventViewCtrl;
      
      private var _roomEventInfoCtrl:RoomEventInfoCtrl;
      
      private var _roomFilterCtrl:RoomFilterCtrl;
      
      private var UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1:ToolbarHoverCtrl;
      
      private var _enforceCategoryCtrl:EnforceCategoryCtrl;
      
      private var _webRoomReport:Boolean = true;
      
      private var _webRoomReportedName:String = null;
      
      public function HabboNavigator(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _assetLibrary = new AssetLibraryCollection("NavigatorComponent");
         _data = new NavigatorData(this);
         _mainViewCtrl = new MainViewCtrl(this);
         _roomInfoViewCtrl = new RoomInfoViewCtrl(this);
         _roomCreateViewCtrl = new RoomCreateViewCtrl(this);
         _passwordInput = new GuestRoomPasswordInput(this);
         _doorbell = new GuestRoomDoorbell(this);
         _tabs = new Tabs(this);
         _officialRoomEntryManager = new OfficialRoomEntryManager(this);
         _roomEventViewCtrl = new RoomEventViewCtrl(this);
         _roomEventInfoCtrl = new RoomEventInfoCtrl(this);
         _roomFilterCtrl = new RoomFilterCtrl(this);
         _enforceCategoryCtrl = new EnforceCategoryCtrl(this);
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get data() : NavigatorData
      {
         return _data;
      }
      
      public function get mainViewCtrl() : ITransitionalMainViewCtrl
      {
         return _mainViewCtrl;
      }
      
      public function get tabs() : Tabs
      {
         return _tabs;
      }
      
      public function get roomInfoViewCtrl() : RoomInfoViewCtrl
      {
         return _roomInfoViewCtrl;
      }
      
      public function get roomCreateViewCtrl() : RoomCreateViewCtrl
      {
         return _roomCreateViewCtrl;
      }
      
      public function get assetLibrary() : IAssetLibraryCollection
      {
         return _assetLibrary;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get roomSettingsCtrl() : RoomSettingsCtrl
      {
         return _roomSettingsCtrl;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionData;
      }
      
      public function get passwordInput() : GuestRoomPasswordInput
      {
         return _passwordInput;
      }
      
      public function get doorbell() : GuestRoomDoorbell
      {
         return _doorbell;
      }
      
      public function get roomEventViewCtrl() : RoomEventViewCtrl
      {
         return _roomEventViewCtrl;
      }
      
      public function get officialRoomEntryManager() : OfficialRoomEntryManager
      {
         return _officialRoomEntryManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get roomEventInfoCtrl() : RoomEventInfoCtrl
      {
         return _roomEventInfoCtrl;
      }
      
      public function get roomFilterCtrl() : RoomFilterCtrl
      {
         return _roomFilterCtrl;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get enforceCategoryCtrl() : EnforceCategoryCtrl
      {
         return _enforceCategoryCtrl;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionData = param1;
         },true,[{
            "type":"PUE_perks_updated",
            "callback":onPerksUpdated
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarManager = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _incomingMessages = new IncomingMessages(this);
         _roomSessionManager.events.addEventListener("RSE_CREATED",onRoomSessionCreatedEvent);
         if(!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            context.addLinkEventTracker(this);
         }
         var _loc1_:String = getProperty("navigator.default_tab");
         if(getInteger("new.identity",0) > 0)
         {
            _loc1_ = getProperty("new.identity.navigator.default_tab");
         }
         tabs.setSelectedTab(Tabs.tabIdFromName(_loc1_,2));
         _roomSettingsCtrl = new RoomSettingsCtrl(this);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("openroom",enterRoomWebRequest);
         }
      }
      
      public function enterRoomWebRequest(param1:String, param2:Boolean = false, param3:String = null) : void
      {
         _webRoomReport = param2;
         _webRoomReportedName = param3;
         send(new ConvertGlobalRoomIdMessageComposer(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_mainViewCtrl)
         {
            _mainViewCtrl.dispose();
            _mainViewCtrl = null;
         }
         if(_roomSessionManager != null)
         {
            _roomSessionManager.events.removeEventListener("RSE_CREATED",onRoomSessionCreatedEvent);
         }
         context.removeLinkEventTracker(this);
         if(_toolbar != null && _toolbar.events != null)
         {
            _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onHabboToolbarEvent);
         }
         if(_roomInfoViewCtrl)
         {
            _roomInfoViewCtrl.dispose();
            _roomInfoViewCtrl = null;
         }
         if(_roomFilterCtrl)
         {
            _roomFilterCtrl.dispose();
            _roomFilterCtrl = null;
         }
         if(_roomCreateViewCtrl)
         {
            _roomCreateViewCtrl.dispose();
            _roomCreateViewCtrl = null;
         }
         if(_officialRoomEntryManager)
         {
            _officialRoomEntryManager.dispose();
            _officialRoomEntryManager = null;
         }
         if(_roomEventViewCtrl)
         {
            _roomEventViewCtrl.dispose();
            _roomEventViewCtrl = null;
         }
         if(_roomSettingsCtrl)
         {
            _roomSettingsCtrl.dispose();
            _roomSettingsCtrl = null;
         }
         if(UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1)
         {
            UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1.dispose();
            UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1 = null;
         }
         super.dispose();
      }
      
      public function startRoomCreation() : void
      {
         _roomCreateViewCtrl.show();
      }
      
      public function goToPrivateRoom(param1:int) : void
      {
         send(new GetGuestRoomMessageComposer(param1,false,true));
      }
      
      public function removeRoomRights(param1:int) : void
      {
         send(new RemoveOwnRoomRightsRoomMessageComposer(param1));
      }
      
      public function hasRoomRightsButIsNotOwner(param1:int) : Boolean
      {
         var _loc2_:IRoomSession = null;
         if(_roomSessionManager)
         {
            _loc2_ = _roomSessionManager.getSession(param1);
            return _loc2_.roomControllerLevel == 1 && !_loc2_.isRoomOwner;
         }
         return false;
      }
      
      public function goToRoomNetwork(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(_roomSessionManager)
         {
            _roomInfoViewCtrl.close();
            _loc3_ = 0;
            if(param2 && _data.homeRoomId > 0)
            {
               _loc3_ = _data.homeRoomId;
            }
            _roomSessionManager.gotoRoomNetwork(param1,_loc3_);
         }
      }
      
      public function goToRoom(param1:int, param2:Boolean, param3:String = "", param4:int = -1, param5:Boolean = false) : void
      {
         var _loc6_:int = 0;
         if(_roomSessionManager)
         {
            Logger.log("[HabboNavigator] Go to room: " + param1);
            if(param2)
            {
               _mainViewCtrl.close();
            }
            _roomSessionManager.gotoRoom(param1,param3,"",param5);
            if(tabs.getSelected())
            {
               _loc6_ = param4 > -1 ? param4 + 1 : 0;
               switch(tabs.getSelected().id - 1)
               {
                  case 0:
                     trackNavigationDataPoint("Events","go.events",String(param1),_loc6_);
                     break;
                  case 1:
                     trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory,"go.rooms",String(param1),_loc6_);
                     break;
                  case 2:
                     trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory,"go.me",String(param1),_loc6_);
                     break;
                  case 3:
                     trackNavigationDataPoint(tabs.getSelected().tabPageDecorator.filterCategory,"go.official",String(param1),_loc6_);
                     break;
                  case 4:
                     trackNavigationDataPoint("Search","go.search",String(param1),_loc6_);
               }
            }
         }
         else
         {
            Logger.log("[HabboNavigator] Room Session Manager is not initialized. Can not enter: " + param1);
         }
      }
      
      public function goToHomeRoom() : Boolean
      {
         if(this._data.homeRoomId < 1)
         {
            Logger.log("No home room set while attempting to go to home room");
            return false;
         }
         this.goToRoom(this._data.homeRoomId,true);
         return true;
      }
      
      public function send(param1:IMessageComposer, param2:Boolean = false) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : IWindowModel
      {
         var _loc5_:ISoundAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:IWindowModel = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      public function getText(param1:String) : String
      {
         var _loc2_:* = _localization.getLocalization(param1);
         if(_loc2_ == null || _loc2_ == "")
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public function registerParameter(param1:String, param2:String, param3:String) : String
      {
         return _localization.registerParameter(param1,param2,param3);
      }
      
      public function getButton(param1:String, param2:String, param3:Function, param4:int = 0, param5:int = 0, param6:int = 0) : IBitmapWrapperController
      {
         var _loc8_:BitmapData = getButtonImage(param2);
         var _loc7_:IBitmapWrapperController = IBitmapWrapperController(_windowManager.createWindow(param1,"",21,0,1 | 0x10,new Rectangle(param4,param5,_loc8_.width,_loc8_.height),param3,param6));
         _loc7_.bitmap = _loc8_;
         _loc7_.disposesBitmap = false;
         return _loc7_;
      }
      
      public function refreshButton(param1:IWindowController_1, param2:String, param3:Boolean, param4:Function, param5:int, param6:String = null) : void
      {
         if(!param6)
         {
            param6 = param2;
         }
         var _loc7_:IBitmapWrapperController = param1.findChildByName(param2) as IBitmapWrapperController;
         if(!_loc7_)
         {
            Logger.log("Could not locate button in navigator: " + param2);
         }
         if(!param3)
         {
            _loc7_.visible = false;
         }
         else
         {
            prepareButton(_loc7_,param6,param4,param5);
            _loc7_.visible = true;
         }
      }
      
      private function prepareButton(param1:IBitmapWrapperController, param2:String, param3:Function, param4:int) : void
      {
         param1.id = param4;
         param1.procedure = param3;
         if(param1.bitmap != null)
         {
            return;
         }
         param1.bitmap = getButtonImage(param2);
         param1.disposesBitmap = false;
         param1.width = param1.bitmap.width;
         param1.height = param1.bitmap.height;
      }
      
      public function getButtonImage(param1:String, param2:String = "_png") : BitmapData
      {
         var _loc6_:* = null;
         var _loc4_:String = param1 + param2;
         var _loc7_:ISoundAsset = assets.getAssetByName(_loc4_);
         var _loc5_:BitmapDataAsset = BitmapDataAsset(_loc7_);
         return BitmapData(_loc5_.content);
      }
      
      private function onRoomSessionCreatedEvent(param1:RoomSessionEvent) : void
      {
         if(_roomSessionManager && _roomInfoViewCtrl)
         {
            _roomInfoViewCtrl.close();
         }
      }
      
      public function openCatalogClubPage(param1:String) : void
      {
         if(_catalog == null)
         {
            return;
         }
         _catalog.openClubCenter();
      }
      
      public function openCatalogRoomAdsPage() : void
      {
         if(_catalog == null)
         {
            return;
         }
         _catalog.openCatalogPage("room_ad");
      }
      
      public function openCatalogRoomAdsExtendPage(param1:String, param2:String, param3:Date, param4:int) : void
      {
         if(_catalog == null)
         {
            return;
         }
         var _loc5_:String = _data.enteredGuestRoom.roomName;
         _catalog.openRoomAdCatalogPageInExtendedMode("room_ad",param1,param2,_loc5_,param3,param4);
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            switch(param1.iconId)
            {
               case "HTIE_ICON_ROOMINFO":
                  toggleRoomInfoVisibility();
                  break;
               case "HTIE_ICON_NAVIGATOR_ME_TAB":
                  showOwnRooms();
                  break;
               case "HTIE_ICON_GAMES":
                  if(getBoolean("game.center.enabled"))
                  {
                     closeNavigator();
                  }
                  break;
               case "HTIE_ICON_HOME":
                  goToHomeRoom();
            }
         }
      }
      
      public function toggleRoomInfoVisibility() : void
      {
         if(_roomCreateViewCtrl)
         {
            _roomInfoViewCtrl.toggle();
         }
      }
      
      public function performTagSearch(param1:String) : void
      {
         if(_mainViewCtrl == null)
         {
            return;
         }
         if(param1.indexOf(" ") != -1)
         {
            param1 = "\"" + param1 + "\"";
         }
         _mainViewCtrl.startSearch(5,9,param1);
         trackNavigationDataPoint("Search","search.tag",param1);
         _mainViewCtrl.mainWindow.activate();
      }
      
      public function performTextSearch(param1:String) : void
      {
         if(_mainViewCtrl == null)
         {
            return;
         }
         _mainViewCtrl.startSearch(5,8,param1);
         trackNavigationDataPoint("Search","search",param1);
         _mainViewCtrl.mainWindow.activate();
         _mainViewCtrl.searchInput.searchStr.setText(param1);
      }
      
      public function performCompetitionRoomsSearch(param1:int, param2:int) : void
      {
         if(_mainViewCtrl == null || _data != null && _data.isLoading())
         {
            return;
         }
         _data.competitionRoomsData = new CompetitionRoomsData(null,param1,param2);
         _mainViewCtrl.startSearch(5,15,"");
         _mainViewCtrl.mainWindow.activate();
         _mainViewCtrl.searchInput.searchStr.setText("");
      }
      
      public function performGuildBaseSearch() : void
      {
         if(_mainViewCtrl == null)
         {
            return;
         }
         _mainViewCtrl.startSearch(5,14,"");
         _mainViewCtrl.mainWindow.activate();
         _mainViewCtrl.searchInput.searchStr.setText("");
      }
      
      public function showOwnRooms() : void
      {
         if(_mainViewCtrl == null)
         {
            return;
         }
         _mainViewCtrl.startSearch(3,5);
         _tabs.getTab(3).tabPageDecorator.tabSelected();
      }
      
      public function showFavouriteRooms() : void
      {
         showMeTab(6);
      }
      
      public function showHistoryRooms() : void
      {
         showMeTab(7);
      }
      
      public function showFrequentRooms() : void
      {
         showMeTab(23);
      }
      
      private function showMeTab(param1:int) : void
      {
         if(_mainViewCtrl == null)
         {
            return;
         }
         _mainViewCtrl.startSearch(3,param1);
         _tabs.getTab(3).tabPageDecorator.setSubSelection(param1);
      }
      
      public function trackNavigationDataPoint(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         if(_tracking)
         {
            _tracking.trackEventLog("Navigation",param1,param2,param3,param4);
         }
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function get tracking() : IHabboTracking
      {
         return _tracking;
      }
      
      public function openNavigator(param1:Point = null) : void
      {
      }
      
      public function closeNavigator() : void
      {
         _mainViewCtrl.close();
      }
      
      public function goToMainView() : void
      {
         _roomCreateViewCtrl.hide();
         _roomInfoViewCtrl.close();
      }
      
      public function get homeRoomId() : int
      {
         return !!_data ? _data.homeRoomId : -1;
      }
      
      public function get webRoomReport() : Boolean
      {
         return _webRoomReport;
      }
      
      public function get webRoomReportedName() : String
      {
         return _webRoomReportedName;
      }
      
      public function get enteredGuestRoomData() : GuestRoomData
      {
         if(_data)
         {
            return _data.enteredGuestRoom;
         }
         return null;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get linkPattern() : String
      {
         return "navigator/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "goto":
               if(_loc2_.length > 2)
               {
                  var _loc4_:* = _loc2_[2];
                  if("home" !== _loc4_)
                  {
                     _loc3_ = int(_loc2_[2]);
                     if(_loc3_ > 0)
                     {
                        goToPrivateRoom(_loc3_);
                     }
                     else
                     {
                        send(new ForwardToSomeRoomMessageComposer(_loc2_[2]));
                     }
                  }
                  else
                  {
                     goToHomeRoom();
                  }
               }
               break;
            case "search":
               if(_loc2_.length > 2)
               {
                  performTextSearch(_loc2_[2]);
               }
               break;
            case "tag":
               if(_loc2_.length > 2)
               {
                  performTagSearch(_loc2_[2]);
               }
               break;
            case "tab":
               if(_loc2_.length > 2)
               {
                  tabs.setSelectedTab(Tabs.tabIdFromName(_loc2_[2],2));
                  openNavigator(null);
               }
               break;
            case "report":
               if(_loc2_.length > 3)
               {
                  enterRoomWebRequest(_loc2_[2],true,_loc2_[3]);
               }
               break;
            default:
               Logger.log("Navigator unknown link-type received: " + _loc2_[1]);
         }
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            if(_mainViewCtrl && _mainViewCtrl.isPhaseOneNavigator != isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
            {
               _mainViewCtrl.close();
            }
            context.addLinkEventTracker(this);
         }
         else
         {
            context.removeLinkEventTracker(this);
         }
      }
      
      public function showToolbarHover(param1:Point) : void
      {
         if(!UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1)
         {
            UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1 = new ToolbarHoverCtrl(this);
         }
         UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1.show(param1);
      }
      
      public function hideToolbarHover(param1:Boolean) : void
      {
         if(!UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1)
         {
            return;
         }
         if(param1)
         {
            UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1.hideDelayed();
         }
         else
         {
            UnknownVarFromHabboNavigator_ToolbarHoverCtrl_1.hide();
         }
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         if(_sessionData)
         {
            return _sessionData.isPerkAllowed(param1);
         }
         return false;
      }
      
      public function canRateRoom() : Boolean
      {
         if(!data)
         {
            return false;
         }
         return data.canRate;
      }
      
      public function isRoomFavorite(param1:int) : Boolean
      {
         if(!data)
         {
            return false;
         }
         return data.isRoomFavourite(param1);
      }
      
      public function isRoomHome(param1:int) : Boolean
      {
         if(!data)
         {
            return false;
         }
         return data.isRoomHome(param1);
      }
      
      public function get visibleEventCategories() : Array
      {
         if(!data)
         {
            return [];
         }
         return data.visibleEventCategories;
      }
   }
}

