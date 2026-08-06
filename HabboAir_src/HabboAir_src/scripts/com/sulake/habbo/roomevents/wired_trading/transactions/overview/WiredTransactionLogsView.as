package com.sulake.habbo.roomevents.wired_trading.transactions.overview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions.WiredTransactionGetChestLogsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions.WiredTransactionGetRoomLogsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionInfo;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionLogList;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.utils.LoadingIcon;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.getTimer;
   
   public class WiredTransactionLogsView implements IComponentInterfaceQueue
   {
      public static const LOG_COLUMN_TYPE:String = "type";
      
      public static const LOG_COLUMN_TIMESTAMP:String = "timestamp";
      
      public static const LOG_COLUMN_USERNAME:String = "username";
      
      public static const LOG_COLUMN_WITHDRAWS:String = "withdraws";
      
      public static const UnknownConstFromWiredTransactionLogsView_String_1:String = "deposits";
      
      public static const UnknownConstFromWiredTransactionLogsView_String_2:String = "chests";
      
      public static const LOG_COLUMN_DETAILS:String = "details";
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      public static const REQUEST_SAME_PAGE_TIMEOUT:uint = 2000;
      
      public static const REQUEST_PAGE_RATELIMIT:uint = 280;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1:WiredTransactionLogsController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromWiredTransactionLogsView_TableView_1:TableView;
      
      private var UnknownVarFromWiredTransactionLogsView_Int_1:int = -1;
      
      private var UnknownVarFromWiredTransactionLogsView_Int_2:int = 0;
      
      private var _loadingIcon:LoadingIcon;
      
      public function WiredTransactionLogsView(param1:WiredTransactionLogsController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.assets.getAssetByName("transaction_overview_xml").content),1) as IFrameController;
         _loadingIcon = new LoadingIcon();
         pageNumberInput.restrict = "0-9";
         createTransactionTable();
         firstPageButton.addEventListener("WME_CLICK",onFirstPageClick);
         previousPageButton.addEventListener("WME_CLICK",onPreviousPageClick);
         nextPageButton.addEventListener("WME_CLICK",onNextPageClick);
         lastPageButton.addEventListener("WME_CLICK",onLastPageClick);
         refreshButton.addEventListener("WME_CLICK",onRefreshClick);
         pageNumberInput.addEventListener("WKE_KEY_DOWN",onPageInputDown);
         pageNumberInput.addEventListener("WME_CLICK_AWAY",onPageInputClickAway);
         closeButton.addEventListener("WME_CLICK",onClose);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function createTransactionTable() : void
      {
         UnknownVarFromWiredTransactionLogsView_TableView_1 = new TableView(_windowManager,tableView,true,true);
         var _loc1_:Array = [new TableColumn("type",loc("wiredchests.logs.col.type"),0.17),new TableColumn("timestamp",loc("wiredchests.logs.col.timestamp"),0.15),new TableColumn("username",loc("wiredchests.logs.col.username"),0.14),new TableColumn("withdraws",loc("wiredchests.logs.col.withdraws"),0.14),new TableColumn("deposits",loc("wiredchests.logs.col.deposits"),0.14),new TableColumn("chests",loc("wiredchests.logs.col.chests"),0.12),new TableColumn("details",loc("wiredchests.logs.col.details"),0.14)];
         UnknownVarFromWiredTransactionLogsView_TableView_1.initialize(Vector.<TableColumn>(_loc1_),true,true);
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(!isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
               _window.center();
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _window.parent != null;
      }
      
      public function displayNewPage() : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return;
         }
         _loadingIcon.setVisible(loadingIconWindow,false);
         var _loc7_:WiredTransactionLogList = UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs;
         if(_loc7_.currentPage == UnknownVarFromWiredTransactionLogsView_Int_1)
         {
            UnknownVarFromWiredTransactionLogsView_Int_1 = -1;
         }
         listTypeValueText.text = loc("wiredchests.logs.type." + _loc7_.logListType);
         if(_loc7_.logListType == WiredTransactionLogList.UnknownVarFromWiredTransactionLogList_Int_1)
         {
            idKeyText.text = loc("wiredchests.logs.chest_id");
         }
         else
         {
            idKeyText.text = loc("wiredchests.logs.room_id");
         }
         idValueText.text = _loc7_.logListId + "";
         var _loc3_:int = calculateLastPage();
         Util.disableSection(firstPageButton,_loc7_.currentPage <= 1);
         Util.disableSection(previousPageButton,_loc7_.currentPage <= 1);
         Util.disableSection(nextPageButton,_loc7_.currentPage >= _loc3_);
         Util.disableSection(lastPageButton,_loc7_.currentPage >= _loc3_);
         var _loc4_:String = loc("wiredchests.logs.bottom_text");
         var _loc1_:Array = _loc4_.split("%page%");
         if(_loc1_.length == 2)
         {
            _loc5_ = _loc1_[0];
            _loc6_ = _loc1_[1];
            pageTextStart.text = _loc5_.replace("%transaction_count%",_loc7_.totalLogs);
            pageTextEnd.text = _loc6_.replace("%page_count%",_loc3_);
            pageNumberInput.text = _loc7_.currentPage + "";
         }
         var _loc2_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc8_ in _loc7_.logs)
         {
            _loc2_.push(new TransactionTableObject(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1,_loc8_));
         }
         UnknownVarFromWiredTransactionLogsView_TableView_1.setObjects(_loc2_);
         UnknownVarFromWiredTransactionLogsView_TableView_1.scrollToTop();
         _window.activate();
      }
      
      private function calculateLastPage() : int
      {
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return 1;
         }
         return Math.max(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs.totalLogs - 1,0) / TransactionConfig.PAGE_SIZE + 1;
      }
      
      private function onLastPageClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return;
         }
         requestPage(calculateLastPage());
      }
      
      private function onNextPageClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return;
         }
         requestPage(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs.currentPage + 1);
      }
      
      private function onPreviousPageClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return;
         }
         requestPage(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs.currentPage - 1);
      }
      
      private function onFirstPageClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return;
         }
         requestPage(1);
      }
      
      private function onRefreshClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return;
         }
         requestPage(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs.currentPage);
      }
      
      private function onPageInputClickAway(param1:WindowMouseEvent) : void
      {
         navigateToInputPage();
      }
      
      private function onPageInputDown(param1:WindowKeyboardEvent) : void
      {
         var _loc2_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.keyCode == 13)
         {
            navigateToInputPage();
         }
      }
      
      private function navigateToInputPage() : void
      {
         var _loc2_:* = int(pageNumberInput.text);
         var _loc1_:int = calculateLastPage();
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
            pageNumberInput.text = String(_loc2_);
         }
         else if(_loc2_ > _loc1_)
         {
            _loc2_ = _loc1_;
            pageNumberInput.text = String(_loc2_);
         }
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs == null)
         {
            return;
         }
         if(_loc2_ != UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs.currentPage)
         {
            requestPage(_loc2_);
         }
      }
      
      private function requestPage(param1:int) : void
      {
         var _loc2_:int = getTimer();
         if(UnknownVarFromWiredTransactionLogsView_Int_2 > _loc2_ - 280)
         {
            return;
         }
         if(param1 == UnknownVarFromWiredTransactionLogsView_Int_1 && UnknownVarFromWiredTransactionLogsView_Int_2 > _loc2_ - 2000)
         {
            return;
         }
         UnknownVarFromWiredTransactionLogsView_Int_1 = param1;
         UnknownVarFromWiredTransactionLogsView_Int_2 = _loc2_;
         if(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs.logListType == WiredTransactionLogList.UnknownVarFromWiredTransactionLogList_Int_1)
         {
            UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.send(new WiredTransactionGetChestLogsMessageComposer(UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.logs.logListId,TransactionConfig.PAGE_SIZE,param1));
         }
         else
         {
            UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.send(new WiredTransactionGetRoomLogsMessageComposer(TransactionConfig.PAGE_SIZE,param1));
         }
         _loadingIcon.setVisible(loadingIconWindow,true);
      }
      
      public function loc(param1:String) : String
      {
         return UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1.localizationManager.getLocalization(param1,param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _loadingIcon.dispose();
         _loadingIcon = null;
         UnknownVarFromWiredTransactionLogsView_TableView_1.dispose();
         UnknownVarFromWiredTransactionLogsView_TableView_1 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromWiredTransactionLogsView_WiredTransactionLogsController_1 = null;
         _windowManager = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get listTypeValueText() : ITextWindow
      {
         return _window.findChildByName("list_type_value") as ITextWindow;
      }
      
      private function get idKeyText() : ITextWindow
      {
         return _window.findChildByName("id_key") as ITextWindow;
      }
      
      private function get idValueText() : ITextWindow
      {
         return _window.findChildByName("id_value") as ITextWindow;
      }
      
      private function get refreshButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("refresh_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get loadingIconWindow() : IIconWindow
      {
         return _window.findChildByName("searching_icon") as IIconWindow;
      }
      
      private function get tableView() : IWindowController_1
      {
         return _window.findChildByName("table_view") as IWindowController_1;
      }
      
      private function get firstPageButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("first_page_btn") as UnknownICoreWindowComponents5;
      }
      
      private function get previousPageButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("prev_page_btn") as UnknownICoreWindowComponents5;
      }
      
      private function get nextPageButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("next_page_btn") as UnknownICoreWindowComponents5;
      }
      
      private function get lastPageButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("last_page_btn") as UnknownICoreWindowComponents5;
      }
      
      private function get pageTextStart() : ITextWindow
      {
         return _window.findChildByName("pagina_text_start") as ITextWindow;
      }
      
      private function get pageNumberInput() : ITextFieldWindow
      {
         return _window.findChildByName("pagina_number_input") as ITextFieldWindow;
      }
      
      private function get pageTextEnd() : ITextWindow
      {
         return _window.findChildByName("pagina_text_end") as ITextWindow;
      }
   }
}

