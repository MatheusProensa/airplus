package com.sulake.habbo.roomevents.wired_menu.roomlogs
{
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.roomlogs.WiredGetRoomLogsComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.roomlogs.WiredLogEntry;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.roomlogs.WiredLogPage;
   import com.sulake.habbo.roomevents.common.PagedTableView;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   
   public class WiredRoomLogListView extends PagedTableView
   {
      public static const REQUEST_PAGE_RATELIMIT:uint = 190;
      
      public static const REFRESH_TIME:int = 2500;
      
      public static const LOG_COLUMN_TIMESTAMP:String = "timestamp";
      
      public static const UnknownConstFromWiredRoomLogListView_String_1:String = "source";
      
      public static const UnknownConstFromWiredRoomLogListView_String_2:String = "level";
      
      public static const LOG_COLUMN_MESSAGE:String = "message";
      
      private var UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1:WiredRoomLogListController;
      
      private var _ignoreDropmenuEvents:Boolean = false;
      
      private var UnknownVarFromWiredRoomLogListView_Timer_1:Timer;
      
      public function WiredRoomLogListView(param1:WiredRoomLogListController, param2:IHabboWindowManagerComponent)
      {
         super(param1.assets.getAssetByName("logs_overview_xml"),param2,param1.localizationManager,false);
         UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1 = param1;
         logSourceMenu.addEventListener("WE_SELECT",onSelectFilter);
         logLevelMenu.addEventListener("WE_SELECT",onSelectFilter);
         logSourceMenu.addEventListener("WE_SELECTED",onSelectedFilter);
         logLevelMenu.addEventListener("WE_SELECTED",onSelectedFilter);
         filterInput.addEventListener("WKE_KEY_DOWN",onFilterInputDown);
         autoRefreshCheckbox.select();
         startAutoRefresh();
      }
      
      private function onFilterInputDown(param1:WindowKeyboardEvent) : void
      {
         var _loc2_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.keyCode == 13)
         {
            updateFilters();
         }
      }
      
      private function startAutoRefresh() : void
      {
         if(UnknownVarFromWiredRoomLogListView_Timer_1 == null)
         {
            UnknownVarFromWiredRoomLogListView_Timer_1 = new Timer(2500);
            UnknownVarFromWiredRoomLogListView_Timer_1.addEventListener("timer",onAutoRefresh);
         }
         UnknownVarFromWiredRoomLogListView_Timer_1.start();
      }
      
      private function onAutoRefresh(param1:TimerEvent) : void
      {
         if(!autoRefreshCheckbox.isSelected || !isShowing())
         {
            return;
         }
         var _loc2_:WiredLogPage = UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page;
         if(_loc2_ != null)
         {
            requestPageWithFilters(_loc2_.currentPage,_loc2_.logSourceFilter,_loc2_.logLevelFilter,_loc2_.query == null ? "" : _loc2_.query,true);
         }
      }
      
      public function displayNewPage(param1:Boolean) : void
      {
         if(UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page == null)
         {
            return;
         }
         var _loc3_:WiredLogPage = UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page;
         if(!param1)
         {
            sourceOption = _loc3_.logSourceFilter;
            levelOption = _loc3_.logLevelFilter;
            filterInput.text = _loc3_.query;
         }
         onPageLoaded();
         var _loc2_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc4_ in _loc3_.elements)
         {
            _loc2_.push(new WiredRoomLogListTableObject(UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1,_loc4_));
         }
         UnknownVarFromPagedTableView_TableView_1.setObjects(_loc2_);
         if(!param1)
         {
            UnknownVarFromPagedTableView_TableView_1.scrollToTop();
            _window.activate();
         }
      }
      
      override protected function createTable() : void
      {
         UnknownVarFromPagedTableView_TableView_1 = new TableView(_windowManager,tableViewContainer,true);
         var _loc1_:Array = [new TableColumn("timestamp",loc("wiredmenu.logs_overview.col.timestamp"),0.2),new TableColumn("source",loc("wiredmenu.logs_overview.col.source"),0.08),new TableColumn("level",loc("wiredmenu.logs_overview.col.level"),0.08),new TableColumn("message",loc("wiredmenu.logs_overview.col.message"),0.64)];
         UnknownVarFromPagedTableView_TableView_1.initialize(Vector.<TableColumn>(_loc1_),true,true);
      }
      
      override protected function calculateLastPage() : int
      {
         if(UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page == null)
         {
            return -1;
         }
         return Math.max(UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page.totalEntries - 1,0) / WiredRoomLogsConfig.PAGE_SIZE + 1;
      }
      
      override protected function currentPage() : int
      {
         if(UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page == null)
         {
            return -1;
         }
         return UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page.currentPage;
      }
      
      override protected function requestPageRatelimit() : int
      {
         return 190;
      }
      
      override protected function pagingTextKey() : String
      {
         return "wiredmenu.logs_overview.bottom_text";
      }
      
      override protected function totalEntries() : int
      {
         if(UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page == null)
         {
            return -1;
         }
         return UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page.totalEntries;
      }
      
      private function requestPageWithFilters(param1:int, param2:int, param3:int, param4:String, param5:Boolean = false) : Boolean
      {
         if(!super.requestPage(param1))
         {
            return false;
         }
         var _loc6_:WiredLogPage = UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.page;
         if(_loc6_ == null)
         {
            return false;
         }
         if(param2 == 2147483647)
         {
            param2 = _loc6_.logSourceFilter;
         }
         if(param3 == 2147483647)
         {
            param3 = _loc6_.logLevelFilter;
         }
         if(param4 == null)
         {
            param4 = "";
         }
         UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1.send(new WiredGetRoomLogsComposer(param1,WiredRoomLogsConfig.PAGE_SIZE,param3,param2,param4),param5);
         onPageLoaded();
         return true;
      }
      
      override protected function requestPage(param1:int) : Boolean
      {
         return requestPageWithFilters(param1,2147483647,2147483647,null);
      }
      
      private function onSelectFilter(param1:WindowEvent) : void
      {
         if(_ignoreDropmenuEvents)
         {
            return;
         }
         if(!canRequestNewPage(false))
         {
            param1.preventWindowOperation();
         }
      }
      
      private function onSelectedFilter(param1:WindowEvent) : void
      {
         if(_ignoreDropmenuEvents)
         {
            return;
         }
         updateFilters();
      }
      
      private function updateFilters(param1:Boolean = true) : void
      {
         var firstAttempt:Boolean = param1;
         if(!canRequestNewPage(false))
         {
            if(!firstAttempt)
            {
               UnknownVarFromWiredRoomLogListView_Timer_1.reset();
               UnknownVarFromWiredRoomLogListView_Timer_1.start();
               setTimeout(function():void
               {
                  updateFilters(false);
               },190 + 10);
            }
            return;
         }
         UnknownVarFromWiredRoomLogListView_Timer_1.reset();
         UnknownVarFromWiredRoomLogListView_Timer_1.start();
         requestPageWithFilters(1,sourceOption,levelOption,filterInput.text);
      }
      
      private function set levelOption(param1:int) : void
      {
         _ignoreDropmenuEvents = true;
         logLevelMenu.selection = param1 + 1;
         _ignoreDropmenuEvents = false;
      }
      
      private function get levelOption() : int
      {
         return logLevelMenu.selection - 1;
      }
      
      private function set sourceOption(param1:int) : void
      {
         _ignoreDropmenuEvents = true;
         logSourceMenu.selection = param1 + 1;
         _ignoreDropmenuEvents = false;
      }
      
      private function get sourceOption() : int
      {
         return logSourceMenu.selection - 1;
      }
      
      public function activate() : void
      {
         _window.activate();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromWiredRoomLogListView_WiredRoomLogListController_1 = null;
      }
      
      private function get autoRefreshCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("auto_refresh_cbx") as UnknownICoreWindowComponents2;
      }
      
      private function get logSourceMenu() : IDropBaseController_1
      {
         return _window.findChildByName("log_source_menu") as IDropBaseController_1;
      }
      
      private function get logLevelMenu() : IDropBaseController_1
      {
         return _window.findChildByName("log_level_menu") as IDropBaseController_1;
      }
      
      private function get filterInput() : ITextFieldWindow
      {
         return _window.findChildByName("filter_input") as ITextFieldWindow;
      }
   }
}

