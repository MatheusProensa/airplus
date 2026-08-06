package com.sulake.habbo.navigator.view
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultContainer;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.view.search.SearchView;
   import com.sulake.habbo.navigator.view.search.ViewMode;
   import com.sulake.habbo.navigator.view.search.results.BlockResultsView;
   import com.sulake.habbo.navigator.view.search.results.CategoryElementFactory;
   import com.sulake.habbo.navigator.view.search.results.RoomEntryElementFactory;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class NavigatorView implements IProfiler_1
   {
      private static const POPUP_HIDE_DELAY_MS:uint = 4000;
      
      private static const MAX_WINDOW_WIDTH:int = 578;
      
      private static const STARTING_TAB_POSITION:int = 115;
      
      private static const UnknownConstFromNavigatorView_Int_1:int = 7;
      
      private static const UnknownConstFromNavigatorView_Int_2:int = 7;
      
      private var _navigator:HabboNewNavigator;
      
      private var UnknownVarFromNavigatorView_LiftView_1:LiftView;
      
      private var UnknownVarFromNavigatorView_QuickLinksView_1:QuickLinksView;
      
      private var UnknownVarFromNavigatorView_SearchView_1:SearchView;
      
      private var UnknownVarFromNavigatorView_BlockResultsView_1:BlockResultsView;
      
      private var UnknownVarFromNavigatorView_RoomEntryElementFactory_1:RoomEntryElementFactory;
      
      private var UnknownVarFromNavigatorView_CategoryElementFactory_1:CategoryElementFactory;
      
      private var UnknownVarFromNavigatorView_TopViewSelector_1:TopViewSelector;
      
      private var _roomInfoPopup:RoomInfoPopup;
      
      private var UnknownVarFromNavigatorView_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromNavigatorView_UnknownICoreWindowComponents6_2:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromNavigatorView_UnknownICoreWindowComponents6_3:UnknownICoreWindowComponents6;
      
      private var _window:IWindowController_1;
      
      private var _isBusy:Boolean;
      
      private var UnknownVarFromNavigatorView_Uint_1:uint = getTimer();
      
      private var UnknownVarFromNavigatorView_Int_1:int = -1;
      
      private var UnknownVarFromNavigatorView_Int_2:int = -1;
      
      private var _lastWindowWidth:int = -1;
      
      private var UnknownVarFromNavigatorView_Int_3:int = -1;
      
      private var _lastLeftPaneHidden:Boolean = false;
      
      private var _waitingForGroupDetails:int = -1;
      
      private var UnknownVarFromNavigatorView_Int_4:int = 4000;
      
      private var UnknownVarFromNavigatorView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromNavigatorView_Int_5:int;
      
      private var UnknownVarFromNavigatorView_Int_6:int;
      
      private var UnknownVarFromNavigatorView_IWindowModel_1:IWindowModel;
      
      private var _leftPaneMargin:int;
      
      private var roomInfoGlobalRectangle:Rectangle = new Rectangle();
      
      public function NavigatorView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(param1 && _navigator.isReady)
         {
            if(UnknownVarFromNavigatorView_RoomEntryElementFactory_1 == null)
            {
               UnknownVarFromNavigatorView_RoomEntryElementFactory_1 = new RoomEntryElementFactory(_navigator);
            }
            if(UnknownVarFromNavigatorView_CategoryElementFactory_1 == null)
            {
               UnknownVarFromNavigatorView_CategoryElementFactory_1 = new CategoryElementFactory(_navigator,UnknownVarFromNavigatorView_RoomEntryElementFactory_1);
            }
            createSubViews();
            if(_window == null)
            {
               createMainWindow();
               _navigator.registerUpdateReceiver(this,1000);
               UnknownVarFromNavigatorView_QuickLinksView_1.setQuickLinks(_navigator.contextContainer.savedSearches);
            }
            if(_navigator.currentResults != null)
            {
               this.onSearchResults(_navigator.currentResults);
            }
            else if(!_isBusy)
            {
               _navigator.performSearch("official_view");
            }
            _window.activate();
         }
         else if(_roomInfoPopup)
         {
            _roomInfoPopup.show(false);
         }
         if(_window)
         {
            _window.visible = param1;
         }
      }
      
      public function get visible() : Boolean
      {
         if(_window)
         {
            return _window.visible;
         }
         return false;
      }
      
      public function setInitialWindowDimensions(param1:int, param2:int, param3:int, param4:Boolean, param5:int) : void
      {
         if(_window)
         {
            setLeftPaneVisibility(!param4);
            _window.x = param1;
            _window.y = param2;
            _window.height = param3;
         }
         else
         {
            UnknownVarFromNavigatorView_Int_1 = param1;
            UnknownVarFromNavigatorView_Int_2 = param2;
            UnknownVarFromNavigatorView_Int_3 = param3;
            _lastLeftPaneHidden = param4;
         }
      }
      
      public function onSavedSearches(param1:Vector.<SavedSearch>) : void
      {
         if(UnknownVarFromNavigatorView_QuickLinksView_1)
         {
            UnknownVarFromNavigatorView_QuickLinksView_1.setQuickLinks(param1);
         }
      }
      
      private function createSubViews() : void
      {
         if(UnknownVarFromNavigatorView_BlockResultsView_1 == null)
         {
            UnknownVarFromNavigatorView_BlockResultsView_1 = new BlockResultsView(_navigator);
            UnknownVarFromNavigatorView_BlockResultsView_1.categoryElementFactory = UnknownVarFromNavigatorView_CategoryElementFactory_1;
            UnknownVarFromNavigatorView_CategoryElementFactory_1.blockResultsView = UnknownVarFromNavigatorView_BlockResultsView_1;
         }
         if(UnknownVarFromNavigatorView_SearchView_1 == null)
         {
            UnknownVarFromNavigatorView_SearchView_1 = new SearchView(_navigator);
         }
         if(UnknownVarFromNavigatorView_QuickLinksView_1 == null)
         {
            UnknownVarFromNavigatorView_QuickLinksView_1 = new QuickLinksView(_navigator);
         }
         if(UnknownVarFromNavigatorView_LiftView_1 == null)
         {
         }
         if(UnknownVarFromNavigatorView_TopViewSelector_1 == null)
         {
            UnknownVarFromNavigatorView_TopViewSelector_1 = new TopViewSelector(_navigator);
         }
      }
      
      public function onSearchResults(param1:SearchResultContainer, param2:String = "") : void
      {
         var _loc3_:int = 0;
         if(_navigator.newResultsRendered)
         {
            return;
         }
         if(!UnknownVarFromNavigatorView_RoomEntryElementFactory_1 || !UnknownVarFromNavigatorView_BlockResultsView_1)
         {
            return;
         }
         UnknownVarFromNavigatorView_RoomEntryElementFactory_1.viewMode = ViewMode.getViewMode(param1.searchCodeOriginal);
         UnknownVarFromNavigatorView_BlockResultsView_1.displayCurrentResults();
         if(_navigator.contextContainer.hasContextFor(param1.searchCodeOriginal))
         {
            _loc3_ = int(_navigator.contextContainer.getTopLevelSearches().indexOf(param1.searchCodeOriginal));
            if(_loc3_ != -1)
            {
               UnknownVarFromNavigatorView_TopViewSelector_1.selectTabByIndex(_loc3_);
            }
         }
         _window.findChildByName("create_room").procedure = createRoomProcedure;
         _window.findChildByName("random_room_border").visible = false;
         _window.findChildByName("promote_room_border").visible = false;
         if(param1.searchCodeOriginal == "roomads_view" || param1.searchCodeOriginal == "myworld_view")
         {
            _window.findChildByName("promote_room_border").visible = true;
            _window.findChildByName("promote_room").procedure = promoteRoomProcedure;
         }
         else
         {
            _window.findChildByName("random_room_border").visible = true;
            _window.findChildByName("random_room").procedure = randomRoomProcedure;
         }
         UnknownVarFromNavigatorView_SearchView_1.setTextAndSearchModeFromFilter(param1.filteringData,param2);
         _navigator.newResultsRendered = true;
         isBusy = false;
         if(_roomInfoPopup)
         {
            _roomInfoPopup.show(false);
         }
      }
      
      public function currentFilterText() : String
      {
         if(UnknownVarFromNavigatorView_SearchView_1 != null)
         {
            return UnknownVarFromNavigatorView_SearchView_1.currentInput;
         }
         return null;
      }
      
      public function refreshLiftedRooms() : void
      {
         if(UnknownVarFromNavigatorView_LiftView_1)
         {
            UnknownVarFromNavigatorView_LiftView_1.refresh();
         }
      }
      
      public function showRoomInfoBubbleAt(param1:GuestRoomData, param2:int, param3:int, param4:Boolean = false) : void
      {
         UnknownVarFromNavigatorView_Boolean_1 = true;
         if(!_window)
         {
            return;
         }
         if(!_roomInfoPopup)
         {
            _roomInfoPopup = new RoomInfoPopup(_navigator);
         }
         if(_roomInfoPopup.visible && !param4)
         {
            _roomInfoPopup.show(false);
         }
         else
         {
            _roomInfoPopup.setData(param1);
            if(param1.habboGroupId != 0 && _navigator.getCachedGroupDetails(param1.habboGroupId) == null)
            {
               _navigator.getGuildInfo(param1.habboGroupId,false);
               _waitingForGroupDetails = param1.habboGroupId;
            }
            _roomInfoPopup.showAt(true,param2,param3);
            _navigator.trackEventLog("browse.openroominfo","Results",param1.roomName,param1.flatId);
            UnknownVarFromNavigatorView_Int_4 = 4000;
         }
      }
      
      public function get mainWindow() : IFrameController
      {
         return _window as IFrameController;
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         if(_window)
         {
            _window.caption = param1 ? "${navigator.title.is.busy}" : "${navigator.title}";
            _window.findChildByName("search_waiting_for_results_mask").visible = param1;
         }
         _isBusy = param1;
      }
      
      public function get isBusy() : Boolean
      {
         return _isBusy;
      }
      
      private function createMainWindow() : void
      {
         var _loc8_:IWindowController_1 = IWindowController_1(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("navigator_frame_2_xml").content)));
         IScrollableListWindow(_loc8_.findChildByName("block_results")).autoHideScrollBar = false;
         var _loc10_:IWindowController_1 = IWindowController_1(_loc8_.findChildByName("navigator_entry_row_container"));
         UnknownVarFromNavigatorView_RoomEntryElementFactory_1.rowEntryTemplate = IWindowController_1(_loc10_.clone());
         _loc10_.destroy();
         var _loc4_:IItemListWindow = IItemListWindow(_loc8_.findChildByName("navigator_entry_tile_container").clone());
         var _loc5_:IWindowController_1 = IWindowController_1(_loc4_.getListItemByName("navigator_entry_tile").clone());
         UnknownVarFromNavigatorView_RoomEntryElementFactory_1.tileEntryTemplate = _loc5_;
         _loc4_.destroyListItems();
         UnknownVarFromNavigatorView_RoomEntryElementFactory_1.tileContainerTemplate = _loc4_;
         IItemListWindow(_loc8_.findChildByName("category_content")).destroyListItems();
         var _loc9_:IWindowController_1 = IWindowController_1(_loc8_.findChildByName("category_container"));
         UnknownVarFromNavigatorView_CategoryElementFactory_1.categoryTemplate = IWindowController_1(_loc9_.clone());
         IItemListWindow(_loc8_.findChildByName("block_results")).removeListItemAt(0);
         _loc9_.destroy();
         var _loc1_:IWindowController_1 = IWindowController_1(_loc8_.findChildByName("category_container_collapsed"));
         UnknownVarFromNavigatorView_CategoryElementFactory_1.collapsedCategoryTemplate = IWindowController_1(_loc1_.clone());
         IItemListWindow(_loc8_.findChildByName("block_results")).removeListItemAt(0);
         _loc1_.destroy();
         var _loc6_:IWindowController_1 = IWindowController_1(_loc8_.findChildByName("no_results_container"));
         UnknownVarFromNavigatorView_CategoryElementFactory_1.noResultsTemplate = IWindowController_1(_loc6_.clone());
         IItemListWindow(_loc8_.findChildByName("block_results")).removeListItemAt(0);
         _loc6_.destroy();
         UnknownVarFromNavigatorView_BlockResultsView_1.itemList = IItemListWindow(_loc8_.findChildByName("block_results"));
         UnknownVarFromNavigatorView_SearchView_1.container = IWindowController_1(_loc8_.findChildByName("search_tools"));
         var _loc3_:IRegionWindow = IRegionWindow(_loc8_.findChildByName("quick_link"));
         _loc3_.findChildByName("quick_link_text").caption = "";
         UnknownVarFromNavigatorView_QuickLinksView_1.template = IRegionWindow(_loc3_.clone());
         UnknownVarFromNavigatorView_QuickLinksView_1.itemList = IItemListWindow(_loc8_.findChildByName("quicklinks_list"));
         IItemListWindow(_loc8_.findChildByName("quicklinks_list")).removeListItems();
         _loc3_.destroy();
         var _loc2_:ITabContextWindow = ITabContextWindow(_loc8_.findChildByName("top_view_select_tab_context"));
         var _loc7_:ITabButtonWindow = ITabButtonWindow(_loc2_.getTabItemAt(0).clone());
         UnknownVarFromNavigatorView_TopViewSelector_1.template = _loc7_;
         UnknownVarFromNavigatorView_TopViewSelector_1.tabContext = _loc2_;
         _loc2_.removeTabItem(_loc7_);
         UnknownVarFromNavigatorView_TopViewSelector_1.refresh();
         _leftPaneMargin = _loc8_.findChildByName("left_pane").x;
         _loc8_.findChildByName("refreshButton").procedure = refreshSearchResults;
         _loc8_.findChildByName("header_button_close").procedure = headerProcedure;
         UnknownVarFromNavigatorView_Int_5 = 7;
         _loc8_.findChildByName("temp_back").procedure = leftPaneShowHideProcedure;
         UnknownVarFromNavigatorView_IWindowModel_1 = _loc8_.findChildByName("right_pane");
         UnknownVarFromNavigatorView_Int_6 = UnknownVarFromNavigatorView_IWindowModel_1.x;
         _window = _loc8_;
         setLeftPaneVisibility(false);
         if(UnknownVarFromNavigatorView_Int_1 == -1 && UnknownVarFromNavigatorView_Int_2 == -1)
         {
            UnknownVarFromNavigatorView_Int_1 = _window.x;
            UnknownVarFromNavigatorView_Int_2 = _window.y;
            _lastWindowWidth = _window.width;
            UnknownVarFromNavigatorView_Int_3 = _window.height;
         }
         else
         {
            if(_lastLeftPaneHidden)
            {
               setLeftPaneVisibility(true);
            }
            _window.x = UnknownVarFromNavigatorView_Int_1;
            _window.y = UnknownVarFromNavigatorView_Int_2;
            _window.height = UnknownVarFromNavigatorView_Int_3;
         }
         UnknownVarFromNavigatorView_Uint_1 = getTimer();
      }
      
      private function refreshSearchResults(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && param2.name == "refreshButton")
         {
            _navigator.performLastSearch();
         }
      }
      
      private function headerProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "header_button_close")
            {
               visible = false;
            }
         }
      }
      
      private function createRoomProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.createRoom();
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      private function promoteRoomProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.context.createLinkEvent("catalog/open/room_ad");
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      private function randomRoomProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.context.createLinkEvent("navigator/goto/random_friending_room");
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
            visible = false;
         }
      }
      
      private function leftPaneShowHideProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IWindowModel = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _window.findChildByName("left_pane");
            setLeftPaneVisibility(!_loc3_.visible);
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      public function setLeftPaneVisibility(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowModel = _window.findChildByName("left_pane");
         var _loc5_:int = UnknownVarFromNavigatorView_Int_6 - _leftPaneMargin + 7;
         UnknownVarFromNavigatorView_IWindowModel_1.setParamFlag(0,true);
         UnknownVarFromNavigatorView_IWindowModel_1.setParamFlag(128,false);
         if(!param1)
         {
            _loc2_.visible = false;
            UnknownVarFromNavigatorView_IWindowModel_1.x = UnknownVarFromNavigatorView_Int_5;
            _window.limits.minWidth = _window.width - _loc5_ + UnknownVarFromNavigatorView_Int_5;
            _window.limits.maxWidth = _window.width - _loc5_ + UnknownVarFromNavigatorView_Int_5;
            _window.width = _window.width - _loc5_ + UnknownVarFromNavigatorView_Int_5;
         }
         else
         {
            _loc2_.visible = true;
            UnknownVarFromNavigatorView_IWindowModel_1.x = UnknownVarFromNavigatorView_Int_6;
            _loc3_ = _window.width + _loc5_ - UnknownVarFromNavigatorView_Int_5;
            _window.limits.minWidth = _loc3_ > 578 ? 578 : _loc3_;
            _window.limits.maxWidth = _loc3_ > 578 ? 578 : _loc3_;
            _window.width = _loc3_ > 578 ? 578 : _loc3_;
         }
         UnknownVarFromNavigatorView_IWindowModel_1.setParamFlag(0,false);
         UnknownVarFromNavigatorView_IWindowModel_1.setParamFlag(128,true);
         _window.findChildByName("left_hide_container").visible = param1;
         _window.findChildByName("left_show_container").visible = !param1;
         var _loc4_:int = int(param1 ? 115 : 115 - _loc5_ / 2);
         _window.findChildByName("top_view_select_tab_context").x = _loc4_;
      }
      
      private function keepWindowInsideScreenRegion() : void
      {
         _window.x = Math.max(0,_window.x);
         _window.y = Math.max(0,_window.y);
         if(_window.desktop)
         {
            _window.x = Math.min(_window.desktop.width - _window.width,_window.x);
            _window.y = Math.min(_window.desktop.height - _window.height,_window.y);
         }
      }
      
      private function sendWindowPreferences() : void
      {
         UnknownVarFromNavigatorView_Int_1 = _window.x;
         UnknownVarFromNavigatorView_Int_2 = _window.y;
         _lastWindowWidth = _window.width;
         UnknownVarFromNavigatorView_Int_3 = _window.height;
         _lastLeftPaneHidden = _window.findChildByName("left_pane").visible;
         UnknownVarFromNavigatorView_Uint_1 = getTimer();
         _navigator.sendWindowPreferences(UnknownVarFromNavigatorView_Int_1,UnknownVarFromNavigatorView_Int_2,_lastWindowWidth,UnknownVarFromNavigatorView_Int_3,_lastLeftPaneHidden,0);
         _navigator.trackEventLog("windowsettings","Interface",_window.width + " x " + _window.height);
      }
      
      private function get windowPreferencesChanged() : Boolean
      {
         if(_lastLeftPaneHidden != _window.findChildByName("left_pane").visible)
         {
            return true;
         }
         if(UnknownVarFromNavigatorView_Int_1 != _window.x)
         {
            return true;
         }
         if(UnknownVarFromNavigatorView_Int_2 != _window.y)
         {
            return true;
         }
         if(UnknownVarFromNavigatorView_Int_3 != _window.height)
         {
            return true;
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(windowPreferencesChanged && _loc2_ - UnknownVarFromNavigatorView_Uint_1 > 5000)
         {
            sendWindowPreferences();
         }
         keepWindowInsideScreenRegion();
         UnknownVarFromNavigatorView_Int_4 -= param1;
         if(isRoomInfoBubbleVisible && UnknownVarFromNavigatorView_Int_4 < 0)
         {
            _roomInfoPopup.getGlobalRectangle(roomInfoGlobalRectangle);
            if(!roomInfoGlobalRectangle.contains(_window.desktop.mouseX,_window.desktop.mouseY))
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      public function dispose() : void
      {
         _navigator.removeUpdateReceiver(this);
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function onGroupDetailsArrived(param1:int) : void
      {
         if(_waitingForGroupDetails == param1)
         {
            _waitingForGroupDetails = -1;
         }
      }
      
      public function get isRoomInfoBubbleVisible() : Boolean
      {
         if(_roomInfoPopup)
         {
            return _roomInfoPopup.visible;
         }
         return false;
      }
      
      public function refreshRoomInfoBubbleHomeState() : void
      {
         if(_roomInfoPopup)
         {
            _roomInfoPopup.refreshHomeState();
         }
      }
   }
}

