package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultList;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultSet;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToSomeRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorAddCollapsedCategoryMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorAddSavedSearchComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorDeleteSavedSearchComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorRemoveCollapsedCategoryMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NavigatorSetSearchCodeViewModeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NewNavigatorInitComposer;
   import com.sulake.habbo.communication.messages.outgoing.newnavigator.NewNavigatorSearchComposer;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetNewNavigatorWindowPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorLiftedRoomsParser;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorMetaDataParser;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NavigatorSavedSearchesParser;
   import com.sulake.habbo.communication.messages.parser.newnavigator.NewNavigatorPreferencesParser;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.cache.NavigatorCache;
   import com.sulake.habbo.navigator.context.ContextContainer;
   import com.sulake.habbo.navigator.context.SearchContext;
   import com.sulake.habbo.navigator.context.SearchContextHistoryManager;
   import com.sulake.habbo.navigator.domain.NavigatorData;
   import com.sulake.habbo.navigator.lift.LiftDataContainer;
   import com.sulake.habbo.navigator.transitional.LegacyNavigator;
   import com.sulake.habbo.navigator.view.NavigatorView;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.utils.Base64;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.geom.Point;
   
   public class HabboNewNavigator extends Component implements IHabboNewNavigator, ILinkEventTracker
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
      
      private var _incomingMessages:NewIncomingMessages;
      
      private var _toolbar:IHabboToolbar;
      
      private var UnknownVarFromHabboNewNavigator_HabboNavigator_1:HabboNavigator;
      
      private var _legacyNavigator:LegacyNavigator;
      
      private var UnknownVarFromHabboNewNavigator_Boolean_1:Boolean = false;
      
      private var _view:NavigatorView;
      
      private var _contextContainer:ContextContainer;
      
      private var _liftDataContainer:LiftDataContainer;
      
      private var _searchContextHistoryManager:SearchContextHistoryManager;
      
      private var _currentResults:SearchResultContainer;
      
      private var _groupDetails:Map = new Map();
      
      private var UnknownVarFromHabboNewNavigator_Map_1:Map = new Map();
      
      private var _collapsedCategories:Vector.<String> = new Vector.<String>(0);
      
      private var _navigatorCache:NavigatorCache;
      
      private var _lastSearchCode:String = "official_view";
      
      private var UnknownVarFromHabboNewNavigator_String_1:String = "";
      
      private var UnknownVarFromHabboNewNavigator_String_2:String = "";
      
      private var UnknownVarFromHabboNewNavigator_Int_1:int = -1;
      
      private var _newResultsRendered:Boolean = false;
      
      private var _noPushToHistoryDueToNavigation:Boolean = false;
      
      public function HabboNewNavigator(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _legacyNavigator = new LegacyNavigator(this,UnknownVarFromHabboNewNavigator_HabboNavigator_1);
      }
      
      public static function getEventLogExtraStringFromSearch(param1:String, param2:String) : String
      {
         return param1 + (param2 == "" ? "" : ":" + param2);
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get sessionData() : ISessionDataManager
      {
         return _sessionData;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
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
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            UnknownVarFromHabboNewNavigator_HabboNavigator_1 = HabboNavigator(param1);
            if(_legacyNavigator)
            {
               _legacyNavigator.oldNavigator = UnknownVarFromHabboNewNavigator_HabboNavigator_1;
            }
         },true)]);
      }
      
      override protected function initComponent() : void
      {
         _incomingMessages = new NewIncomingMessages(this);
         context.addLinkEventTracker(this);
         _view = new NavigatorView(this);
         _contextContainer = new ContextContainer(this);
         _searchContextHistoryManager = new SearchContextHistoryManager(this);
         _liftDataContainer = new LiftDataContainer(this);
         _navigatorCache = new NavigatorCache();
         _communication.connection.send(new NewNavigatorInitComposer());
         UnknownVarFromHabboNewNavigator_Boolean_1 = true;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            var _loc2_:* = param1.iconId;
            if("HTIE_ICON_NAVIGATOR" === _loc2_)
            {
               toggle();
            }
         }
      }
      
      public function initialize(param1:NavigatorMetaDataParser) : void
      {
         _contextContainer.initialize(param1);
      }
      
      public function onSearchResult(param1:SearchResultContainer) : void
      {
         _windowManager.LilithCustomsInstance.OnNavigatorSearchResult(param1);
         _newResultsRendered = false;
         _currentResults = param1;
         extractRoomNamesFromResults(param1.resultSet);
         if(!_noPushToHistoryDueToNavigation)
         {
            _searchContextHistoryManager.addSearchContextAtCurrentOffset(new SearchContext(param1.searchCodeOriginal,param1.filteringData));
         }
         _navigatorCache.put(param1.searchCodeOriginal + "/" + param1.filteringData,param1);
         _noPushToHistoryDueToNavigation = false;
         if(_view.visible)
         {
            _view.onSearchResults(param1,UnknownVarFromHabboNewNavigator_String_2);
         }
      }
      
      private function extractRoomNamesFromResults(param1:SearchResultSet) : void
      {
         UnknownVarFromHabboNewNavigator_Map_1 = new Map();
         for each(var _loc2_ in param1.blocks)
         {
            for each(var _loc3_ in _loc2_.guestRooms)
            {
               UnknownVarFromHabboNewNavigator_Map_1.add(_loc3_.flatId,_loc3_.roomName);
            }
         }
      }
      
      public function get newResultsRendered() : Boolean
      {
         return _newResultsRendered;
      }
      
      public function set newResultsRendered(param1:Boolean) : void
      {
         _newResultsRendered = param1;
      }
      
      public function onLiftedRooms(param1:NavigatorLiftedRoomsParser) : void
      {
         _liftDataContainer.setLiftedRooms(param1.liftedRooms);
         _view.refreshLiftedRooms();
      }
      
      public function onPreferences(param1:NewNavigatorPreferencesParser) : void
      {
         _view.setInitialWindowDimensions(param1.windowX,param1.windowY,param1.windowHeight,param1.leftPaneHidden,param1.resultsMode);
      }
      
      public function onSavedSearches(param1:NavigatorSavedSearchesParser) : void
      {
         _contextContainer.savedSearches = param1.savedSearches.concat(new Vector.<SavedSearch>(0));
         _view.onSavedSearches(_contextContainer.savedSearches);
      }
      
      public function onGroupDetails(param1:HabboGroupDetailsData) : void
      {
         if(_groupDetails.hasKey(param1.groupId))
         {
            _groupDetails.remove(param1.groupId);
         }
         _groupDetails.add(param1.groupId,param1);
         _view.onGroupDetailsArrived(param1.groupId);
      }
      
      public function onCollapsedCategories(param1:Vector.<String>) : void
      {
         _collapsedCategories = param1.concat();
      }
      
      public function get collapsedCategories() : Vector.<String>
      {
         return _collapsedCategories;
      }
      
      public function getCachedGroupDetails(param1:int) : HabboGroupDetailsData
      {
         return _groupDetails.getValue(param1);
      }
      
      public function goBack() : void
      {
         if(_searchContextHistoryManager.hasPrevious)
         {
            _noPushToHistoryDueToNavigation = true;
            performSearchByContext(_searchContextHistoryManager.getPreviousSearchContextAndGoBack());
         }
         trackEventLog("browse.back","Results");
      }
      
      public function performLastSearch() : void
      {
         if(_lastSearchCode != null && UnknownVarFromHabboNewNavigator_String_1 != null)
         {
            _navigatorCache.removeEntry(_lastSearchCode + "/" + UnknownVarFromHabboNewNavigator_String_1);
            performSearch(_lastSearchCode,UnknownVarFromHabboNewNavigator_String_1);
         }
      }
      
      public function performSearch(param1:String, param2:String = "", param3:String = "") : void
      {
         param1 = _windowManager.LilithCustomsInstance.OnNavigatorPerformSearch(param1,param2);
         _view.isBusy = true;
         UnknownVarFromHabboNewNavigator_String_2 = param3;
         var _loc4_:SearchResultContainer = _navigatorCache.getEntry(param1 + "/" + param2);
         if(_loc4_ != null)
         {
            onSearchResult(_loc4_);
         }
         else
         {
            _lastSearchCode = param1;
            UnknownVarFromHabboNewNavigator_String_1 = param2;
            _communication.connection.send(new NewNavigatorSearchComposer(param1,param2));
            trackEventLog("search","Search",getEventLogExtraStringFromSearch(param1,param2));
         }
         open();
      }
      
      public function performSearchByContext(param1:SearchContext) : void
      {
         performSearch(param1.searchCode,param1.filtering);
      }
      
      public function addSavedSearch(param1:String, param2:String) : void
      {
         if(_currentResults != null)
         {
            _communication.connection.send(new NavigatorAddSavedSearchComposer(param1,param2));
         }
         trackEventLog("savedsearch.add","SavedSearch",getEventLogExtraStringFromSearch(param1,param2));
         _view.setLeftPaneVisibility(true);
      }
      
      public function deleteSavedSearch(param1:int) : void
      {
         _communication.connection.send(new NavigatorDeleteSavedSearchComposer(param1));
         trackEventLog("savedsearch.delete","SavedSearch");
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(!_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            context.removeLinkEventTracker(this);
            if(UnknownVarFromHabboNewNavigator_Boolean_1)
            {
               _incomingMessages.removeLegacyMessageListeners();
               close();
            }
            return;
         }
         if(!UnknownVarFromHabboNewNavigator_Boolean_1)
         {
            initComponent();
         }
         else if(_sessionData.isPerkAllowed("NAVIGATOR_PHASE_TWO_2014"))
         {
            _incomingMessages.addMessageListeners();
         }
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
                        _legacyNavigator.goToPrivateRoom(_loc3_);
                     }
                     else
                     {
                        communication.connection.send(new ForwardToSomeRoomMessageComposer(_loc2_[2]));
                     }
                  }
                  else
                  {
                     _legacyNavigator.goToHomeRoom();
                  }
               }
               break;
            case "search":
               if(_loc2_.length > 2)
               {
                  performSearch("hotel_view",_loc2_[2]);
               }
               break;
            case "tag":
               if(_loc2_.length > 2)
               {
                  performSearch("hotel_view",_loc2_[2]);
               }
               break;
            case "tab":
               if(_loc2_.length > 2)
               {
                  performSearch(getSearchCodeForTabLink(_loc2_[2]));
               }
               break;
            case "report":
               if(_loc2_.length > 3)
               {
                  _legacyNavigator.reportRoomFromWeb(_loc2_[2],Base64.decode(_loc2_[3]));
               }
               break;
            case "ask_forward":
               if(_loc2_.length > 2)
               {
                  UnknownVarFromHabboNewNavigator_Int_1 = int(_loc2_[2]);
                  _communication.connection.send(new GetGuestRoomMessageComposer(UnknownVarFromHabboNewNavigator_Int_1,false,false));
               }
               break;
            default:
               Logger.log("Navigator unknown link-type received: " + _loc2_[1]);
         }
      }
      
      private function getSearchCodeForTabLink(param1:String) : String
      {
         var _loc2_:* = param1;
         if("me" !== _loc2_)
         {
            return param1;
         }
         return "myworld_view";
      }
      
      public function onRoomInfo(param1:GuestRoomData) : void
      {
         var text:String;
         var roomData:GuestRoomData = param1;
         if(UnknownVarFromHabboNewNavigator_Int_1 != -1 && roomData.flatId == UnknownVarFromHabboNewNavigator_Int_1)
         {
            UnknownVarFromHabboNewNavigator_Int_1 = -1;
            text = _localization.getLocalizationWithParams("navigator.forward_confirmation.desc","","room_name",roomData.roomName);
            _windowManager.confirm("${navigator.forward_confirmation.title}",text,0,function(param1:UnknownICoreWindowUtils2, param2:WindowEvent):void
            {
               param1.dispose();
               if(param2.type == "WE_OK")
               {
                  _legacyNavigator.goToPrivateRoom(roomData.flatId);
               }
            });
         }
      }
      
      public function showOwnRooms() : void
      {
      }
      
      public function showToolbarHover(param1:Point) : void
      {
      }
      
      public function hideToolbarHover(param1:Boolean) : void
      {
      }
      
      public function get isReady() : Boolean
      {
         return _contextContainer != null && _contextContainer.isReady();
      }
      
      public function get contextContainer() : ContextContainer
      {
         return _contextContainer;
      }
      
      public function get searchContextHistoryManager() : SearchContextHistoryManager
      {
         return _searchContextHistoryManager;
      }
      
      public function get liftDataContainer() : LiftDataContainer
      {
         return _liftDataContainer;
      }
      
      public function get currentResults() : SearchResultContainer
      {
         return _currentResults;
      }
      
      public function goToRoom(param1:int, param2:String = "mainview") : void
      {
         communication.connection.send(new GetGuestRoomMessageComposer(param1,false,true));
         _view.visible = false;
         var _loc3_:String = UnknownVarFromHabboNewNavigator_Map_1.getValue(param1);
         trackEventLog("go",param2,!_loc3_ ? "" : _loc3_,param1);
      }
      
      public function getExtendedProfile(param1:int) : void
      {
         communication.connection.send(new GetExtendedProfileMessageComposer(param1));
      }
      
      public function get imageLibraryBaseUrl() : String
      {
         return context.configuration.getProperty("image.library.url");
      }
      
      public function performTagSearch(param1:String) : void
      {
         performSearch("hotel_view","tag:" + param1);
      }
      
      public function createRoom() : void
      {
         _legacyNavigator.roomCreateViewCtrl.show();
      }
      
      public function open() : void
      {
         if(_view == null)
         {
            return;
         }
         if(!_view.visible)
         {
            _view.visible = true;
         }
      }
      
      public function close() : void
      {
         if(_view.visible)
         {
            _view.visible = false;
         }
      }
      
      public function toggle() : void
      {
         if(_view == null)
         {
            return;
         }
         _view.visible = !_view.visible;
         if(_view.visible)
         {
            performLastSearch();
         }
      }
      
      public function get mainWindow() : IFrameController
      {
         return _view.mainWindow;
      }
      
      public function refresh() : void
      {
         if(_currentResults)
         {
            _view.onSearchResults(_currentResults);
         }
      }
      
      public function get legacyNavigator() : IHabboNavigator_1
      {
         return _legacyNavigator;
      }
      
      public function get data() : NavigatorData
      {
         return _legacyNavigator.data;
      }
      
      public function sendWindowPreferences(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int) : void
      {
         _communication.connection.send(new SetNewNavigatorWindowPreferencesMessageComposer(param1,param2,param3,param4,param5,param6));
      }
      
      public function getGuildInfo(param1:int, param2:Boolean = true) : void
      {
         _communication.connection.send(new GetHabboGroupDetailsMessageComposer(param1,param2));
      }
      
      public function sendAddCollapsedCategory(param1:String) : void
      {
         _communication.connection.send(new NavigatorAddCollapsedCategoryMessageComposer(param1));
      }
      
      public function sendRemoveCollapsedCategory(param1:String) : void
      {
         _communication.connection.send(new NavigatorRemoveCollapsedCategoryMessageComposer(param1));
      }
      
      public function goToHomeRoom() : void
      {
         goToRoom(_legacyNavigator.data.homeRoomId,"external");
      }
      
      public function trackEventLog(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         if(_tracking)
         {
            _tracking.trackEventLog("NewNavigator",param2,param1,param3,param4);
         }
      }
      
      public function get view() : NavigatorView
      {
         return _view;
      }
      
      public function toggleSearchCodeViewMode(param1:String, param2:int) : void
      {
         _communication.connection.send(new NavigatorSetSearchCodeViewModeMessageComposer(param1,param2));
         trackEventLog("browse.toggleviewmode","ViewMode","",param2);
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function performTextSearch(param1:String) : void
      {
      }
      
      public function performGuildBaseSearch() : void
      {
      }
      
      public function performCompetitionRoomsSearch(param1:int, param2:int) : void
      {
      }
   }
}

