package com.sulake.habbo.roomevents.common
{
   import com.sulake.core.assets.ISoundAsset;
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
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.utils.LoadingIcon;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.getTimer;
   
   public class PagedTableView
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      public static const REQUEST_SAME_PAGE_TIMEOUT:uint = 2000;
      
      private var _disposed:Boolean = false;
      
      protected var _windowManager:IHabboWindowManagerComponent;
      
      protected var UnknownVarFromPagedTableView_IHabboLocalizationManager_1:IHabboLocalizationManager;
      
      protected var _window:IFrameController;
      
      protected var UnknownVarFromPagedTableView_TableView_1:TableView;
      
      private var UnknownVarFromPagedTableView_Int_1:int = -1;
      
      private var UnknownVarFromPagedTableView_Int_2:int = 0;
      
      private var _loadingIcon:LoadingIcon;
      
      private var _samePageTimeout:Boolean = false;
      
      public function PagedTableView(param1:ISoundAsset, param2:IHabboWindowManagerComponent, param3:IHabboLocalizationManager, param4:Boolean = true)
      {
         super();
         _samePageTimeout = param4;
         _windowManager = param2;
         UnknownVarFromPagedTableView_IHabboLocalizationManager_1 = param3;
         _window = _windowManager.buildFromXML(XML(param1.content),1) as IFrameController;
         _loadingIcon = new LoadingIcon();
         pageNumberInput.restrict = "0-9";
         createTable();
         firstPageButton.addEventListener("WME_CLICK",onFirstPageClick);
         previousPageButton.addEventListener("WME_CLICK",onPreviousPageClick);
         nextPageButton.addEventListener("WME_CLICK",onNextPageClick);
         lastPageButton.addEventListener("WME_CLICK",onLastPageClick);
         if(refreshButton != null)
         {
            refreshButton.addEventListener("WME_CLICK",onRefreshClick);
         }
         pageNumberInput.addEventListener("WKE_KEY_DOWN",onPageInputDown);
         pageNumberInput.addEventListener("WME_CLICK_AWAY",onPageInputClickAway);
         closeButton.addEventListener("WME_CLICK",onClose);
         hide();
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
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
      
      private function onLastPageClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = calculateLastPage();
         if(_loc2_ == -1)
         {
            return;
         }
         requestPage(_loc2_);
      }
      
      private function onNextPageClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = currentPage();
         if(_loc2_ == -1)
         {
            return;
         }
         requestPage(_loc2_ + 1);
      }
      
      private function onPreviousPageClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = currentPage();
         if(_loc2_ == -1)
         {
            return;
         }
         requestPage(_loc2_ - 1);
      }
      
      private function onFirstPageClick(param1:WindowMouseEvent) : void
      {
         requestPage(1);
      }
      
      private function onRefreshClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = currentPage();
         if(_loc2_ == -1)
         {
            return;
         }
         requestPage(_loc2_);
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
         var _loc3_:* = int(pageNumberInput.text);
         var _loc2_:int = calculateLastPage();
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
            pageNumberInput.text = String(_loc3_);
         }
         else if(_loc3_ > _loc2_)
         {
            _loc3_ = _loc2_;
            pageNumberInput.text = String(_loc3_);
         }
         var _loc1_:int = currentPage();
         if(_loc1_ == -1)
         {
            return;
         }
         if(_loc3_ != _loc1_)
         {
            requestPage(_loc3_);
         }
      }
      
      protected function canRequestNewPage(param1:Boolean) : Boolean
      {
         var _loc2_:int = getTimer();
         if(UnknownVarFromPagedTableView_Int_2 > _loc2_ - requestPageRatelimit())
         {
            return false;
         }
         if(_samePageTimeout && param1 && UnknownVarFromPagedTableView_Int_2 > _loc2_ - 2000)
         {
            return false;
         }
         return true;
      }
      
      public function loc(param1:String) : String
      {
         return UnknownVarFromPagedTableView_IHabboLocalizationManager_1.getLocalization(param1,param1);
      }
      
      protected function onPageRequested() : void
      {
         _loadingIcon.setVisible(loadingIconWindow,true);
      }
      
      protected function onPageLoaded() : void
      {
         var _loc4_:String = null;
         var _loc6_:String = null;
         _loadingIcon.setVisible(loadingIconWindow,false);
         var _loc5_:int = currentPage();
         if(_loc5_ == UnknownVarFromPagedTableView_Int_1)
         {
            UnknownVarFromPagedTableView_Int_1 = -1;
         }
         var _loc2_:int = calculateLastPage();
         Util.disableSection(firstPageButton,_loc5_ <= 1);
         Util.disableSection(previousPageButton,_loc5_ <= 1);
         Util.disableSection(nextPageButton,_loc5_ >= _loc2_);
         Util.disableSection(lastPageButton,_loc5_ >= _loc2_);
         var _loc3_:String = loc(pagingTextKey());
         var _loc1_:Array = _loc3_.split("%page%");
         if(_loc1_.length == 2)
         {
            _loc4_ = _loc1_[0];
            _loc6_ = _loc1_[1];
            pageTextStart.text = _loc4_.replace("%entries_count%",totalEntries());
            pageTextEnd.text = _loc6_.replace("%page_count%",_loc2_);
            pageNumberInput.text = _loc5_ + "";
         }
      }
      
      protected function createTable() : void
      {
      }
      
      protected function calculateLastPage() : int
      {
         return 0;
      }
      
      protected function currentPage() : int
      {
         return 0;
      }
      
      protected function requestPageRatelimit() : int
      {
         return 200;
      }
      
      protected function pagingTextKey() : String
      {
         return "";
      }
      
      protected function totalEntries() : int
      {
         return 0;
      }
      
      protected function requestPage(param1:int) : Boolean
      {
         var _loc2_:int = getTimer();
         if(!canRequestNewPage(param1 == UnknownVarFromPagedTableView_Int_1))
         {
            return false;
         }
         UnknownVarFromPagedTableView_Int_1 = param1;
         UnknownVarFromPagedTableView_Int_2 = _loc2_;
         return true;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _loadingIcon.dispose();
         _loadingIcon = null;
         UnknownVarFromPagedTableView_TableView_1.dispose();
         UnknownVarFromPagedTableView_TableView_1 = null;
         _window.dispose();
         _window = null;
         _windowManager = null;
         UnknownVarFromPagedTableView_IHabboLocalizationManager_1 = null;
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
      
      private function get loadingIconWindow() : IIconWindow
      {
         return _window.findChildByName("searching_icon") as IIconWindow;
      }
      
      private function get refreshButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("refresh_btn") as UnknownICoreWindowComponents4;
      }
      
      protected function get tableViewContainer() : IWindowController_1
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

