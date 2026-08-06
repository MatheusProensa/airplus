package com.sulake.habbo.navigator.view.search
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class SearchView
   {
      private static const INPUT_PLACEHOLDER_TEXTCOLOR:uint = 10461087;
      
      private static const INPUT_TEXTCOLOR:uint = 0;
      
      private static var FILTER_SELECTOR_INDEX_TO_MODE:Array = [5,2,1,3,4];
      
      private static var FILTER_MODE_TO_SELECTOR_INDEX:Array = [0,2,1,3,4,0];
      
      private var _navigator:HabboNewNavigator;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromSearchView_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromSearchView_IDropBaseController_1_1:IDropBaseController_1;
      
      private var UnknownVarFromSearchView_String_1:String;
      
      public function SearchView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         UnknownVarFromSearchView_String_1 = _navigator.localization.getLocalizationWithParams("navigator.filter.input.placeholder","filter rooms by...");
      }
      
      public function set container(param1:IWindowController_1) : void
      {
         _container = param1;
         UnknownVarFromSearchView_IDropBaseController_1_1 = IDropBaseController_1(_container.findChildByName("filter_type_drop_menu"));
         UnknownVarFromSearchView_ITextFieldWindow_1 = ITextFieldWindow(_container.findChildByName("search_input"));
         UnknownVarFromSearchView_ITextFieldWindow_1.addEventListener("WKE_KEY_UP",keyUpHandler);
         UnknownVarFromSearchView_ITextFieldWindow_1.addEventListener("WE_CHANGE",onInputChanged);
         UnknownVarFromSearchView_ITextFieldWindow_1.addEventListener("WE_FOCUSED",onInputFocused);
         var _loc2_:IWindowModel = _container.findChildByName("clear_search_button");
         if(_loc2_)
         {
            _loc2_.addEventListener("WME_CLICK",onClearSearch);
         }
         clear();
      }
      
      private function onClearSearch(param1:WindowMouseEvent = null) : void
      {
         UnknownVarFromSearchView_ITextFieldWindow_1.focus();
         UnknownVarFromSearchView_ITextFieldWindow_1.caption = "";
         var _loc2_:IStaticBitmapWrapperWindow = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
         _loc2_.assetUri = "common_small_pen";
      }
      
      public function clear() : void
      {
         setInputToFilterPlaceHolder();
         UnknownVarFromSearchView_IDropBaseController_1_1.selection = 0;
         _container.findChildByName("refreshButtonContainer").visible = false;
      }
      
      public function setTextAndSearchModeFromFilter(param1:String, param2:String = "") : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc3_:int = UnknownHabboNavigatorViewSearch1.filterInInput(param1);
         if(_loc3_ != 0)
         {
            UnknownVarFromSearchView_IDropBaseController_1_1.selection = FILTER_MODE_TO_SELECTOR_INDEX[_loc3_];
            UnknownVarFromSearchView_ITextFieldWindow_1.caption = param1.substr(UnknownHabboNavigatorViewSearch1.FILTER_PREFIX[_loc3_].length,param1.length - UnknownHabboNavigatorViewSearch1.FILTER_PREFIX[_loc3_].length);
         }
         else
         {
            UnknownVarFromSearchView_ITextFieldWindow_1.caption = param1;
            UnknownVarFromSearchView_IDropBaseController_1_1.selection = 0;
         }
         if(param2 != "" && param2 != UnknownVarFromSearchView_String_1)
         {
            UnknownVarFromSearchView_ITextFieldWindow_1.caption = param2;
            setInputFieldTextFormattingToPlaceholder(true);
         }
         else if(UnknownVarFromSearchView_ITextFieldWindow_1.caption == "")
         {
            setInputToFilterPlaceHolder();
         }
         else
         {
            setInputFieldTextFormattingToPlaceholder(false);
         }
         if(UnknownVarFromSearchView_ITextFieldWindow_1.caption.length != 0 && UnknownVarFromSearchView_ITextFieldWindow_1.caption != UnknownVarFromSearchView_String_1)
         {
            _container.findChildByName("refreshButtonContainer").visible = true;
            _loc4_ = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
            _loc4_.assetUri = "icons_close";
         }
         else
         {
            _container.findChildByName("refreshButtonContainer").visible = false;
            _loc4_ = _container.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow;
            _loc4_.assetUri = "common_small_pen";
         }
      }
      
      private function keyUpHandler(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            _navigator.performSearch(_navigator.currentResults.searchCodeOriginal,getFilterParameter());
         }
      }
      
      private function getFilterParameter() : String
      {
         return UnknownHabboNavigatorViewSearch1.FILTER_PREFIX[FILTER_SELECTOR_INDEX_TO_MODE[UnknownVarFromSearchView_IDropBaseController_1_1.selection]] + UnknownVarFromSearchView_ITextFieldWindow_1.caption;
      }
      
      private function setInputToFilterPlaceHolder() : void
      {
         setInputFieldTextFormattingToPlaceholder(true);
         UnknownVarFromSearchView_ITextFieldWindow_1.caption = UnknownVarFromSearchView_String_1;
      }
      
      private function onInputFocused(param1:WindowEvent) : void
      {
         setInputFieldTextFormattingToPlaceholder(false);
         if(UnknownVarFromSearchView_ITextFieldWindow_1.caption == UnknownVarFromSearchView_String_1)
         {
            UnknownVarFromSearchView_ITextFieldWindow_1.caption = "";
         }
      }
      
      private function setInputFieldTextFormattingToPlaceholder(param1:Boolean) : void
      {
         UnknownVarFromSearchView_ITextFieldWindow_1.textColor = param1 ? 10461087 : 0;
         UnknownVarFromSearchView_ITextFieldWindow_1.italic = param1;
      }
      
      private function onInputChanged(param1:WindowEvent) : void
      {
      }
      
      public function get currentInput() : String
      {
         if(UnknownVarFromSearchView_ITextFieldWindow_1 != null)
         {
            return UnknownVarFromSearchView_ITextFieldWindow_1.caption;
         }
         return UnknownVarFromSearchView_String_1;
      }
   }
}

