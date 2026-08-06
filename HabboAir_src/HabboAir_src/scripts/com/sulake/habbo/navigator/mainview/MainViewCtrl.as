package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.CompetitionRoomsData;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CompetitionRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GuildBaseSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFrequentRoomHistorySearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyGuildBasesSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRecommendedRoomsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomRightsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabViewedComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.TextSearchInputs;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tab;
   import com.sulake.habbo.utils.WindowToggle;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class MainViewCtrl implements ITransitionalMainViewCtrl, IProfiler_1, IComponentInterfaceQueue
   {
      public static const SEARCHMSG_SEARCH:int = 1;
      
      public static const UnknownConstFromMainViewCtrl_Int_1:int = 2;
      
      public static const SEARCHMSG_OFFICIALROOMS:int = 4;
      
      public static const UnknownConstFromMainViewCtrl_Int_2:int = 5;
      
      private static const BLEND_STAGE_BLENDING_OUT:int = 1;
      
      private static const BLEND_STAGE_LOADING:int = 2;
      
      private static const BLEND_STAGE_REFRESHING:int = 3;
      
      private static const BLEND_STAGE_BLENDING_IN:int = 4;
      
      private static const SCROLLBAR_WIDTH:int = 22;
      
      private static const PANIC_BUTTON_HEIGHT:int = 60;
      
      private var _navigator:HabboNavigator;
      
      private var _mainWindow:IFrameController;
      
      private var _content:IWindowController_1;
      
      private var UnknownVarFromMainViewCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromMainViewCtrl_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromMainViewCtrl_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1:PopularTagsListCtrl;
      
      private var _guestRooms:GuestRoomListCtrl;
      
      private var _officialRooms:OfficialRoomListCtrl;
      
      private var UnknownVarFromMainViewCtrl_RoomAdListCtrl_1:RoomAdListCtrl;
      
      private var UnknownVarFromMainViewCtrl_CategoryListCtrl_1:CategoryListCtrl;
      
      private var _tabContext:ITabContextWindow;
      
      private var UnknownVarFromMainViewCtrl_Boolean_1:Boolean;
      
      private var UnknownVarFromMainViewCtrl_Int_1:int;
      
      private var UnknownVarFromMainViewCtrl_Boolean_2:Boolean = true;
      
      private var UnknownVarFromMainViewCtrl_Int_2:int = 0;
      
      private var _loadingText:IWindowModel;
      
      private var UnknownVarFromMainViewCtrl_Int_3:int = 0;
      
      private var _searchInput:TextSearchInputs;
      
      private var UnknownVarFromMainViewCtrl_Timer_1:Timer;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromMainViewCtrl_WindowToggle_1:WindowToggle;
      
      private var _isPhaseOneNavigator:Boolean = false;
      
      private const DEFAULT_VIEW_LOCATION:Point = new Point(100,10);
      
      public function MainViewCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1 = new PopularTagsListCtrl(_navigator);
         _guestRooms = new GuestRoomListCtrl(_navigator,0,false);
         _officialRooms = new OfficialRoomListCtrl(_navigator);
         UnknownVarFromMainViewCtrl_RoomAdListCtrl_1 = new RoomAdListCtrl(_navigator,0,false);
         UnknownVarFromMainViewCtrl_CategoryListCtrl_1 = new CategoryListCtrl(_navigator);
         UnknownVarFromMainViewCtrl_Timer_1 = new Timer(300,1);
         UnknownVarFromMainViewCtrl_Timer_1.addEventListener("timer",onResizeTimer);
      }
      
      private static function refreshScrollbar(param1:IViewCtrl, param2:Boolean) : void
      {
         var _loc4_:IItemListWindow = null;
         var _loc5_:IWindowModel = null;
         if(param1.content == null || !param1.content.visible)
         {
            return;
         }
         _loc4_ = IItemListWindow(param1.content.findChildByName("item_list"));
         _loc5_ = param1.content.findChildByName("scroller");
         var _loc3_:* = _loc4_.scrollableRegion.height > _loc4_.height;
         if(_loc5_.visible)
         {
            if(!_loc3_)
            {
               _loc5_.visible = false;
               _loc4_.width += 22;
            }
         }
         else if(_loc3_)
         {
            _loc5_.visible = true;
            _loc4_.width -= 22;
         }
      }
      
      public static function stretchNewEntryIfNeeded(param1:IViewCtrl, param2:IWindowController_1) : void
      {
         var _loc3_:IWindowModel = param1.content.findChildByName("scroller");
         if(_loc3_ == null || _loc3_.visible)
         {
            return;
         }
         param2.width += 22;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function onNavigatorToolBarIconClick() : void
      {
         if(!_mainWindow)
         {
            reloadData();
            return;
         }
         if(!UnknownVarFromMainViewCtrl_WindowToggle_1 || UnknownVarFromMainViewCtrl_WindowToggle_1.disposed)
         {
            UnknownVarFromMainViewCtrl_WindowToggle_1 = new WindowToggle(_mainWindow,_mainWindow.desktop,reloadData,close);
         }
         UnknownVarFromMainViewCtrl_WindowToggle_1.toggle();
      }
      
      private function reloadData() : void
      {
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.navigatorOpenedWhileInTab();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _navigator = null;
            if(_mainWindow)
            {
               _mainWindow.dispose();
               _mainWindow = null;
            }
            if(UnknownVarFromMainViewCtrl_WindowToggle_1)
            {
               UnknownVarFromMainViewCtrl_WindowToggle_1.dispose();
               UnknownVarFromMainViewCtrl_WindowToggle_1 = null;
            }
            if(_content)
            {
               _content.dispose();
               _content = null;
            }
            if(UnknownVarFromMainViewCtrl_Timer_1)
            {
               UnknownVarFromMainViewCtrl_Timer_1.removeEventListener("timer",onResizeTimer);
               UnknownVarFromMainViewCtrl_Timer_1.reset();
               UnknownVarFromMainViewCtrl_Timer_1 = null;
            }
            if(UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1)
            {
               UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1.dispose();
               UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1 = null;
            }
            if(_guestRooms)
            {
               _guestRooms.dispose();
               _guestRooms = null;
            }
            if(_officialRooms)
            {
               _officialRooms.dispose();
               _officialRooms = null;
            }
            if(UnknownVarFromMainViewCtrl_RoomAdListCtrl_1)
            {
               UnknownVarFromMainViewCtrl_RoomAdListCtrl_1.dispose();
               UnknownVarFromMainViewCtrl_RoomAdListCtrl_1 = null;
            }
            if(_searchInput)
            {
               _searchInput.dispose();
               _searchInput = null;
            }
         }
      }
      
      public function open() : void
      {
         if(_mainWindow == null)
         {
            prepare();
         }
         refresh();
         _mainWindow.visible = true;
         _mainWindow.y = Math.max(_mainWindow.y,60);
         _mainWindow.activate();
      }
      
      public function isOpen() : Boolean
      {
         return _mainWindow != null && Boolean(_mainWindow.visible);
      }
      
      public function close() : void
      {
         if(_mainWindow != null)
         {
            if(_searchInput)
            {
               _searchInput.dispose();
               _searchInput = null;
            }
            if(UnknownVarFromMainViewCtrl_WindowToggle_1)
            {
               UnknownVarFromMainViewCtrl_WindowToggle_1.dispose();
               UnknownVarFromMainViewCtrl_WindowToggle_1 = null;
            }
            _mainWindow.dispose();
            _mainWindow = null;
            _tabContext = null;
            _content = null;
            UnknownVarFromMainViewCtrl_IWindowController_1_1 = null;
            UnknownVarFromMainViewCtrl_IWindowController_1_3 = null;
            UnknownVarFromMainViewCtrl_IWindowController_1_2 = null;
            _loadingText = null;
            UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1.content = null;
            _guestRooms.content = null;
            _officialRooms.content = null;
            UnknownVarFromMainViewCtrl_CategoryListCtrl_1.content = null;
            UnknownVarFromMainViewCtrl_RoomAdListCtrl_1.content = null;
            UnknownVarFromMainViewCtrl_Int_3 = 0;
         }
      }
      
      public function get mainWindow() : IFrameController
      {
         return _mainWindow;
      }
      
      private function prepare() : void
      {
         var _loc4_:Array = null;
         var _loc7_:ITabButtonWindow = null;
         var _loc5_:ITabButtonWindow = null;
         var _loc2_:Boolean = _navigator.getBoolean("eventinfo.enabled");
         var _loc6_:Boolean = false;
         _mainWindow = IFrameController(_navigator.getXmlWindow("grs_main_window_new"));
         _tabContext = ITabContextWindow(_mainWindow.findChildByName("tab_context"));
         _content = IWindowController_1(_mainWindow.findChildByName("tab_content"));
         UnknownVarFromMainViewCtrl_IWindowController_1_1 = IWindowController_1(_mainWindow.findChildByName("custom_content"));
         UnknownVarFromMainViewCtrl_IWindowController_1_3 = IWindowController_1(_mainWindow.findChildByName("list_content"));
         UnknownVarFromMainViewCtrl_IWindowController_1_2 = IWindowController_1(_mainWindow.findChildByName("custom_footer"));
         _loadingText = _mainWindow.findChildByName("loading_text");
         var _loc3_:IWindowModel = _mainWindow.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onWindowClose);
         }
         _mainWindow.addEventListener("WE_RESIZED",onWindowResized);
         if(!_loc2_ || !_isPhaseOneNavigator)
         {
            _loc4_ = [];
            while(_tabContext.numTabItems > 0)
            {
               _loc7_ = _tabContext.getTabItemAt(0);
               _loc4_.push(_loc7_);
               _tabContext.removeTabItem(_loc7_);
            }
            for each(_loc7_ in _loc4_)
            {
               if(!(_loc7_.id == 1 && !_loc2_ || _loc7_.id == 6 && !_loc6_))
               {
                  _tabContext.addTabItem(_loc7_);
               }
            }
         }
         for each(var _loc1_ in _navigator.tabs.tabs)
         {
            _loc5_ = _tabContext.getTabItemByID(_loc1_.id);
            if(_loc5_ != null)
            {
               _loc5_.addEventListener("WE_SELECTED",onTabSelected);
               _loc1_.button = _loc5_;
            }
         }
         _mainWindow.scaler.setParamFlag(12288,false);
         _mainWindow.scaler.setParamFlag(8192,true);
         _mainWindow.position = DEFAULT_VIEW_LOCATION;
         createSearchInput();
      }
      
      private function createSearchInput() : void
      {
         var _loc1_:IWindowController_1 = null;
         var _loc2_:String = "search_header";
         if(_searchInput == null)
         {
            _loc1_ = _mainWindow.findChildByName(_loc2_) as IWindowController_1;
            _searchInput = new TextSearchInputs(_navigator,_loc1_);
         }
         var _loc3_:IWindowController_1 = _mainWindow.findChildByName(_loc2_) as IWindowController_1;
         _loc3_.visible = true;
      }
      
      public function refresh() : void
      {
         if(_mainWindow == null)
         {
            return;
         }
         refreshTab();
         refreshCustomContent();
         refreshListContent(true);
         refreshFooter();
         UnknownVarFromMainViewCtrl_IWindowController_1_1.height = Util.getLowestPoint(UnknownVarFromMainViewCtrl_IWindowController_1_1);
         UnknownVarFromMainViewCtrl_IWindowController_1_2.height = Util.getLowestPoint(UnknownVarFromMainViewCtrl_IWindowController_1_2);
         var _loc1_:int = int(UnknownVarFromMainViewCtrl_IWindowController_1_3.y);
         Util.moveChildrenToColumn(_content,["custom_content","list_content"],UnknownVarFromMainViewCtrl_IWindowController_1_1.y,8);
         UnknownVarFromMainViewCtrl_IWindowController_1_3.height = UnknownVarFromMainViewCtrl_IWindowController_1_3.height + _loc1_ - UnknownVarFromMainViewCtrl_IWindowController_1_3.y - UnknownVarFromMainViewCtrl_IWindowController_1_2.height + UnknownVarFromMainViewCtrl_Int_3;
         Util.moveChildrenToColumn(_content,["list_content","custom_footer"],UnknownVarFromMainViewCtrl_IWindowController_1_3.y,0);
         UnknownVarFromMainViewCtrl_Int_3 = UnknownVarFromMainViewCtrl_IWindowController_1_2.height;
         onResizeTimer(null);
      }
      
      private function refreshTab() : void
      {
         var _loc2_:Tab = _navigator.tabs.getSelected();
         var _loc1_:ISelectableWindow = _tabContext.selector.getSelected();
         if(_loc2_.button != _loc1_)
         {
            UnknownVarFromMainViewCtrl_Boolean_1 = true;
            _tabContext.selector.setSelected(_loc2_.button);
         }
      }
      
      private function refreshCustomContent() : void
      {
         Util.hideChildren(UnknownVarFromMainViewCtrl_IWindowController_1_1);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshCustomContent(UnknownVarFromMainViewCtrl_IWindowController_1_1);
         if(Util.hasVisibleChildren(UnknownVarFromMainViewCtrl_IWindowController_1_1))
         {
            UnknownVarFromMainViewCtrl_IWindowController_1_1.visible = true;
         }
         else
         {
            UnknownVarFromMainViewCtrl_IWindowController_1_1.visible = false;
            UnknownVarFromMainViewCtrl_IWindowController_1_1.blend = 1;
         }
      }
      
      private function refreshFooter() : void
      {
         Util.hideChildren(UnknownVarFromMainViewCtrl_IWindowController_1_2);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshFooter(UnknownVarFromMainViewCtrl_IWindowController_1_2);
         UnknownVarFromMainViewCtrl_IWindowController_1_2.visible = Util.hasVisibleChildren(UnknownVarFromMainViewCtrl_IWindowController_1_2);
      }
      
      private function refreshListContent(param1:Boolean) : void
      {
         Util.hideChildren(UnknownVarFromMainViewCtrl_IWindowController_1_3);
         var _loc2_:Tab = _navigator.tabs.getSelected();
         var _loc3_:Boolean = _navigator.data.guestRoomSearchArrived && _loc2_.defaultSearchType == 16;
         refreshRoomAds(param1,_loc3_);
         refreshGuestRooms(param1,!_loc3_);
         refreshPopularTags(param1,_navigator.data.popularTagsArrived);
         refreshOfficialRooms(param1,_navigator.data.officialRoomsArrived);
      }
      
      private function refreshGuestRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,_guestRooms,"guest_rooms");
      }
      
      private function refreshPopularTags(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1,"popular_tags");
      }
      
      private function refreshOfficialRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,_officialRooms,"official_rooms");
      }
      
      private function refreshRoomAds(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,UnknownVarFromMainViewCtrl_RoomAdListCtrl_1,"room_ads");
      }
      
      private function refreshCategoryList(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,UnknownVarFromMainViewCtrl_CategoryListCtrl_1,"categories_container");
      }
      
      private function refreshList(param1:Boolean, param2:Boolean, param3:IViewCtrl, param4:String) : void
      {
         var _loc5_:IWindowModel = null;
         if(param2)
         {
            if(param3.content == null)
            {
               _loc5_ = UnknownVarFromMainViewCtrl_IWindowController_1_3.findChildByName(param4);
               param3.content = IWindowController_1(_loc5_);
            }
            if(param1)
            {
               param3.refresh();
            }
            param3.content.visible = true;
         }
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         Logger.log("Close navigator window");
         this.close();
      }
      
      private function onTabSelected(param1:WindowEvent) : void
      {
         var _loc4_:IWindowModel = param1.target;
         var _loc2_:int = _loc4_.id;
         if(UnknownVarFromMainViewCtrl_Boolean_1)
         {
            UnknownVarFromMainViewCtrl_Boolean_1 = false;
            return;
         }
         var _loc3_:Tab = _navigator.tabs.getTab(_loc2_);
         _loc3_.sendSearchRequest();
         switch(_loc3_.id - 1)
         {
            case 0:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS"));
               _navigator.send(new RoomAdEventTabViewedComposer());
               break;
            case 1:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS"));
               break;
            case 2:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ME"));
               break;
            case 3:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL"));
               break;
            case 4:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH"));
               break;
            case 5:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_CATEGORIES"));
         }
      }
      
      public function reloadRoomList(param1:int) : Boolean
      {
         ErrorReportStorage.addDebugData("MainViewCtrl","Reloading RoomList");
         if(this.isOpen() && this._navigator.data.guestRoomSearchResults != null && this._navigator.data.guestRoomSearchResults.searchType == param1)
         {
            startSearch(_navigator.tabs.getSelected().id,param1,"");
            return true;
         }
         return false;
      }
      
      public function startSearch(param1:int, param2:int, param3:String = "-1", param4:int = 1) : void
      {
         var _loc5_:Tab = _navigator.tabs.getSelected();
         _navigator.tabs.setSelectedTab(param1);
         var _loc6_:Tab = _navigator.tabs.getSelected();
         ErrorReportStorage.addDebugData("StartSearch","Start search " + _loc5_.id + " => " + _loc6_.id);
         if(_isPhaseOneNavigator)
         {
            if(param3.substr(0,1) == "#")
            {
               param2 = 9;
               param3 = param3.substr(1,param3.length - 1);
            }
         }
         this.UnknownVarFromMainViewCtrl_Boolean_2 = _loc5_ != _loc6_;
         if(_loc5_ != _loc6_)
         {
            _loc6_.tabPageDecorator.tabSelected();
         }
         _navigator.data.startLoading();
         if(param4 == 1)
         {
            _navigator.send(getSearchMsg(param2,param3));
         }
         else if(param4 == 2)
         {
            _navigator.send(new GetPopularRoomTagsMessageComposer());
         }
         else if(param4 != 5)
         {
            _navigator.send(new GetOfficialRoomsMessageComposer(_navigator.data.adIndex));
         }
         if(!isOpen())
         {
            open();
            this.UnknownVarFromMainViewCtrl_Int_1 = 2;
            this.UnknownVarFromMainViewCtrl_IWindowController_1_3.blend = 0;
            if(this.UnknownVarFromMainViewCtrl_IWindowController_1_1.visible)
            {
               this.UnknownVarFromMainViewCtrl_IWindowController_1_1.blend = 0;
               this.UnknownVarFromMainViewCtrl_IWindowController_1_2.blend = 0;
            }
         }
         else
         {
            this.UnknownVarFromMainViewCtrl_Int_1 = 1;
         }
         this.UnknownVarFromMainViewCtrl_Int_2 = 0;
         _navigator.registerUpdateReceiver(this,2);
         sendTrackingEvent(param2);
         _navigator.data.competitionRoomsData = null;
         if(_isPhaseOneNavigator)
         {
            if(searchInput != null && param3 != "-1")
            {
               if(param2 != 1)
               {
                  searchInput.setText(param3,param2);
               }
            }
         }
      }
      
      private function sendTrackingEvent(param1:int) : void
      {
         switch(param1)
         {
            case 6:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES"));
               break;
            case 3:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS"));
               break;
            case 7:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY"));
               break;
            case 5:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS"));
               break;
            case 11:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS"));
               break;
            case 1:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS"));
               break;
            case 4:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE"));
               break;
            case 2:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE"));
               break;
            case 9:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH"));
               break;
            case 8:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH"));
               break;
            case 23:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FREQUENT_HISTORY"));
         }
      }
      
      private function getSearchMsg(param1:int, param2:String) : IMessageComposer
      {
         var _loc3_:CompetitionRoomsData = null;
         switch(param1)
         {
            case 6:
               return new MyFavouriteRoomsSearchMessageComposer();
            case 3:
               return new MyFriendsRoomsSearchMessageComposer();
            case 7:
               return new MyRoomHistorySearchMessageComposer();
            case 5:
               return new MyRoomsSearchMessageComposer();
            case 1:
               return new PopularRoomsSearchMessageComposer(param2,_navigator.data.adIndex);
            case 4:
               return new RoomsWhereMyFriendsAreSearchMessageComposer();
            case 2:
               return new RoomsWithHighestScoreSearchMessageComposer(_navigator.data.adIndex);
            case 9:
               return new RoomTextSearchMessageComposer("tag:" + param2);
            case 8:
               return new RoomTextSearchMessageComposer(param2);
            case 13:
               return new RoomTextSearchMessageComposer("group:" + param2);
            case 10:
               return new RoomTextSearchMessageComposer("roomname:" + param2);
            case 14:
               return new GuildBaseSearchMessageComposer(_navigator.data.adIndex);
            case 15:
               _loc3_ = _navigator.data.competitionRoomsData;
               return new CompetitionRoomsSearchMessageComposer(_loc3_.goalId,_loc3_.pageIndex);
            case 16:
            case 17:
               break;
            case 18:
               return new MyRoomRightsSearchMessageComposer();
            case 19:
               return new MyGuildBasesSearchMessageComposer();
            case 20:
               return new RoomTextSearchMessageComposer("owner:" + param2);
            case 22:
               return new MyRecommendedRoomsMessageComposer();
            case 23:
               return new MyFrequentRoomHistorySearchMessageComposer();
            default:
               Logger.log("No message for searchType: " + param1);
               return null;
         }
         return new RoomAdSearchMessageComposer(_navigator.data.adIndex,param1);
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         if(this.UnknownVarFromMainViewCtrl_IWindowController_1_3 == null)
         {
            return;
         }
         var _loc2_:Number = param1 / 150;
         if(UnknownVarFromMainViewCtrl_Int_1 == 1)
         {
            _loc3_ = Math.min(1,Math.max(0,this.UnknownVarFromMainViewCtrl_IWindowController_1_3.blend - _loc2_));
            this.UnknownVarFromMainViewCtrl_IWindowController_1_3.blend = _loc3_;
            this.UnknownVarFromMainViewCtrl_IWindowController_1_1.blend = UnknownVarFromMainViewCtrl_Boolean_2 ? _loc3_ : 1;
            this.UnknownVarFromMainViewCtrl_IWindowController_1_2.blend = UnknownVarFromMainViewCtrl_Boolean_2 ? _loc3_ : 1;
            if(_loc3_ == 0)
            {
               UnknownVarFromMainViewCtrl_Int_1 = 2;
            }
         }
         else if(UnknownVarFromMainViewCtrl_Int_1 == 2)
         {
            if(UnknownVarFromMainViewCtrl_Int_2 % 10 == 1)
            {
               _loadingText.visible = !_loadingText.visible;
            }
            UnknownVarFromMainViewCtrl_Int_2++;
            if(!_navigator.data.isLoading())
            {
               UnknownVarFromMainViewCtrl_Int_1 = 3;
            }
         }
         else if(UnknownVarFromMainViewCtrl_Int_1 == 3)
         {
            this.refresh();
            UnknownVarFromMainViewCtrl_Int_1 = 4;
         }
         else
         {
            _loadingText.visible = false;
            _loc3_ = Math.min(1,Math.max(0,this.UnknownVarFromMainViewCtrl_IWindowController_1_3.blend + _loc2_));
            this.UnknownVarFromMainViewCtrl_IWindowController_1_3.blend = _loc3_;
            this.UnknownVarFromMainViewCtrl_IWindowController_1_1.blend = UnknownVarFromMainViewCtrl_Boolean_2 ? _loc3_ : 1;
            this.UnknownVarFromMainViewCtrl_IWindowController_1_2.blend = UnknownVarFromMainViewCtrl_Boolean_2 ? _loc3_ : 1;
            if(UnknownVarFromMainViewCtrl_IWindowController_1_3.blend >= 1)
            {
               _navigator.removeUpdateReceiver(this);
            }
         }
      }
      
      private function onWindowResized(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.target;
         if(_loc2_ != _mainWindow)
         {
            return;
         }
         if(!this.UnknownVarFromMainViewCtrl_Timer_1.running)
         {
            this.UnknownVarFromMainViewCtrl_Timer_1.reset();
            this.UnknownVarFromMainViewCtrl_Timer_1.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         refreshScrollbar(UnknownVarFromMainViewCtrl_PopularTagsListCtrl_1,false);
         refreshScrollbar(_guestRooms,false);
         refreshScrollbar(UnknownVarFromMainViewCtrl_RoomAdListCtrl_1,false);
         if(_navigator.isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
         {
         }
      }
      
      public function get searchInput() : TextSearchInputs
      {
         return _searchInput;
      }
      
      public function openAtPosition(param1:Point) : void
      {
         reloadData();
         if(param1 != null)
         {
            _mainWindow.position = param1;
         }
         else if(_mainWindow.position.x == 0)
         {
            _mainWindow.position = DEFAULT_VIEW_LOCATION;
         }
      }
      
      public function get isPhaseOneNavigator() : Boolean
      {
         return _isPhaseOneNavigator;
      }
   }
}

