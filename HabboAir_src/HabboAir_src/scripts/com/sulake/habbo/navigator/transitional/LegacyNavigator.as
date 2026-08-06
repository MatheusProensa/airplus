package com.sulake.habbo.navigator.transitional
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.GuestRoomDoorbell;
   import com.sulake.habbo.navigator.GuestRoomPasswordInput;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.IHabboNavigator_2;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.domain.Tabs;
   import com.sulake.habbo.navigator.inroom.RoomEventInfoCtrl;
   import com.sulake.habbo.navigator.inroom.RoomEventViewCtrl;
   import com.sulake.habbo.navigator.inroom.RoomInfoViewCtrl;
   import com.sulake.habbo.navigator.mainview.ITransitionalMainViewCtrl;
   import com.sulake.habbo.navigator.mainview.OfficialRoomEntryManager;
   import com.sulake.habbo.navigator.roomsettings.EnforceCategoryCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomCreateViewCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomFilterCtrl;
   import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class LegacyNavigator implements IHabboNavigator_2
   {
      private var _newNavigator:HabboNewNavigator;
      
      private var UnknownVarFromLegacyNavigator_HabboNavigator_1:HabboNavigator;
      
      private var _mainViewCtrl:FakeMainViewCtrl;
      
      private var _roomSettingsCtrl:RoomSettingsCtrl;
      
      private var _roomInfoViewCtrl:RoomInfoViewCtrl;
      
      private var _roomCreateViewCtrl:RoomCreateViewCtrl;
      
      private var _passwordInput:GuestRoomPasswordInput;
      
      private var _doorbell:GuestRoomDoorbell;
      
      private var _officialRoomEntryManager:OfficialRoomEntryManager;
      
      private var _roomEventViewCtrl:RoomEventViewCtrl;
      
      private var _roomEventInfoCtrl:RoomEventInfoCtrl;
      
      private var _roomFilterCtrl:RoomFilterCtrl;
      
      private var _enforceCategoryCtrl:EnforceCategoryCtrl;
      
      public function LegacyNavigator(param1:HabboNewNavigator, param2:HabboNavigator)
      {
         super();
         _newNavigator = param1;
         UnknownVarFromLegacyNavigator_HabboNavigator_1 = param2;
         _mainViewCtrl = new FakeMainViewCtrl(_newNavigator,UnknownVarFromLegacyNavigator_HabboNavigator_1);
         _roomSettingsCtrl = new RoomSettingsCtrl(this);
         _roomInfoViewCtrl = new RoomInfoViewCtrl(this);
         _roomCreateViewCtrl = new RoomCreateViewCtrl(this);
         _passwordInput = new GuestRoomPasswordInput(this);
         _doorbell = new GuestRoomDoorbell(this);
         _officialRoomEntryManager = new OfficialRoomEntryManager(this);
         _roomEventViewCtrl = new RoomEventViewCtrl(this);
         _roomEventInfoCtrl = new RoomEventInfoCtrl(this);
         _roomFilterCtrl = new RoomFilterCtrl(this);
         _enforceCategoryCtrl = new EnforceCategoryCtrl(this);
      }
      
      public function set oldNavigator(param1:HabboNavigator) : void
      {
         UnknownVarFromLegacyNavigator_HabboNavigator_1 = param1;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.assets;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _newNavigator.windowManager;
      }
      
      public function get data() : NavigatorData
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.data;
      }
      
      public function get mainViewCtrl() : ITransitionalMainViewCtrl
      {
         return _mainViewCtrl;
      }
      
      public function get tabs() : Tabs
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.tabs;
      }
      
      public function get roomInfoViewCtrl() : RoomInfoViewCtrl
      {
         return _roomInfoViewCtrl;
      }
      
      public function get roomCreateViewCtrl() : RoomCreateViewCtrl
      {
         return _roomCreateViewCtrl;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.communication;
      }
      
      public function get roomSettingsCtrl() : RoomSettingsCtrl
      {
         return _roomSettingsCtrl;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.sessionData;
      }
      
      public function get passwordInput() : GuestRoomPasswordInput
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.passwordInput;
      }
      
      public function get doorbell() : GuestRoomDoorbell
      {
         return _doorbell;
      }
      
      public function get roomEventViewCtrl() : RoomEventViewCtrl
      {
         return _roomEventViewCtrl;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.localization;
      }
      
      public function get officialRoomEntryManager() : OfficialRoomEntryManager
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.officialRoomEntryManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.toolbar;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.habboHelp;
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
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.roomSessionManager;
      }
      
      public function get enforceCategoryCtrl() : EnforceCategoryCtrl
      {
         return _enforceCategoryCtrl;
      }
      
      public function send(param1:IMessageComposer, param2:Boolean = false) : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.send(param1,param2);
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : IWindowModel
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.getXmlWindow(param1,param2);
      }
      
      public function getText(param1:String) : String
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.getText(param1);
      }
      
      public function registerParameter(param1:String, param2:String, param3:String) : String
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.registerParameter(param1,param2,param3);
      }
      
      public function getButton(param1:String, param2:String, param3:Function, param4:int = 0, param5:int = 0, param6:int = 0) : IBitmapWrapperController
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.getButton(param1,param2,param3,param4,param5,param6);
      }
      
      public function refreshButton(param1:IWindowController_1, param2:String, param3:Boolean, param4:Function, param5:int, param6:String = null) : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.refreshButton(param1,param2,param3,param4,param5,param6);
      }
      
      public function getButtonImage(param1:String, param2:String = "_png") : BitmapData
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.getButtonImage(param1,param2);
      }
      
      public function openCatalogClubPage(param1:String) : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.openCatalogClubPage(param1);
      }
      
      public function openCatalogRoomAdsPage() : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.openCatalogRoomAdsPage();
      }
      
      public function showFavouriteRooms() : void
      {
         return _newNavigator.performSearch("favorites");
      }
      
      public function showHistoryRooms() : void
      {
         return _newNavigator.performSearch("history");
      }
      
      public function showFrequentRooms() : void
      {
         return _newNavigator.performSearch("history_freq");
      }
      
      public function get tracking() : IHabboTracking
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.tracking;
      }
      
      public function goToMainView() : void
      {
         _roomCreateViewCtrl.hide();
      }
      
      public function reportRoomFromWeb(param1:String, param2:String = null) : void
      {
         UnknownVarFromLegacyNavigator_HabboNavigator_1.enterRoomWebRequest(param1,true,param2);
      }
      
      public function goToRoom(param1:int, param2:Boolean, param3:String = "", param4:int = -1, param5:Boolean = false) : void
      {
         UnknownVarFromLegacyNavigator_HabboNavigator_1.goToRoom(param1,false,param3,param4,param5);
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.isPerkAllowed(param1);
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.trackGoogle(param1,param2,param3);
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.getBoolean(param1);
      }
      
      public function getInteger(param1:String, param2:int) : int
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.getInteger(param1,param2);
      }
      
      public function get events() : IEventDispatcher
      {
         return _newNavigator.events;
      }
      
      public function goToHomeRoom() : Boolean
      {
         _newNavigator.goToHomeRoom();
         return true;
      }
      
      public function performTagSearch(param1:String) : void
      {
         return _newNavigator.performTagSearch(param1);
      }
      
      public function performTextSearch(param1:String) : void
      {
         return _newNavigator.performTextSearch(param1);
      }
      
      public function performGuildBaseSearch() : void
      {
         return _newNavigator.performSearch("groups");
      }
      
      public function performCompetitionRoomsSearch(param1:int, param2:int) : void
      {
         return _newNavigator.performSearch("competition");
      }
      
      public function showOwnRooms() : void
      {
         return _newNavigator.performSearch("myworld_view");
      }
      
      public function goToPrivateRoom(param1:int) : void
      {
         _newNavigator.goToRoom(param1);
      }
      
      public function hasRoomRightsButIsNotOwner(param1:int) : Boolean
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.hasRoomRightsButIsNotOwner(param1);
      }
      
      public function removeRoomRights(param1:int) : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.removeRoomRights(param1);
      }
      
      public function goToRoomNetwork(param1:int, param2:Boolean) : void
      {
         return goToRoomNetwork(param1,param2);
      }
      
      public function startRoomCreation() : void
      {
         return _newNavigator.createRoom();
      }
      
      public function openNavigator(param1:Point = null) : void
      {
         return _newNavigator.open();
      }
      
      public function closeNavigator() : void
      {
         return _newNavigator.close();
      }
      
      public function get homeRoomId() : int
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.homeRoomId;
      }
      
      public function get enteredGuestRoomData() : GuestRoomData
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.enteredGuestRoomData;
      }
      
      public function showToolbarHover(param1:Point) : void
      {
      }
      
      public function hideToolbarHover(param1:Boolean) : void
      {
      }
      
      public function toggleRoomInfoVisibility() : void
      {
         if(_roomInfoViewCtrl)
         {
            _roomInfoViewCtrl.toggle();
         }
      }
      
      public function canRateRoom() : Boolean
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.canRateRoom();
      }
      
      public function queueInterface(param1:IID, param2:Function = null) : IUnknown
      {
         return _newNavigator.queueInterface(param1,param2);
      }
      
      public function release(param1:IID) : uint
      {
         return _newNavigator.release(param1);
      }
      
      public function dispose() : void
      {
         _roomSettingsCtrl.dispose();
         _roomInfoViewCtrl.dispose();
         _roomCreateViewCtrl.dispose();
         _passwordInput.dispose();
         _doorbell.dispose();
         _officialRoomEntryManager.dispose();
         _roomEventViewCtrl.dispose();
         _roomEventInfoCtrl.dispose();
         _roomFilterCtrl.dispose();
         _enforceCategoryCtrl = null;
         UnknownVarFromLegacyNavigator_HabboNavigator_1 = null;
         _newNavigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1 == null;
      }
      
      public function openCatalogRoomAdsExtendPage(param1:String, param2:String, param3:Date, param4:int) : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.openCatalogRoomAdsExtendPage(param1,param2,param3,param4);
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.getProperty(param1,param2);
      }
      
      public function trackNavigationDataPoint(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.trackNavigationDataPoint(param1,param2,param3,param4);
      }
      
      public function isRoomFavorite(param1:int) : Boolean
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.isRoomFavorite(param1);
      }
      
      public function isRoomHome(param1:int) : Boolean
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.isRoomHome(param1);
      }
      
      public function get visibleEventCategories() : Array
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.data.visibleEventCategories;
      }
      
      public function get roomSettingsControl() : RoomSettingsCtrl
      {
         return UnknownVarFromLegacyNavigator_HabboNavigator_1.roomSettingsCtrl;
      }
   }
}

