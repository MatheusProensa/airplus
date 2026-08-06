package com.sulake.habbo.navigator.view
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.context.SearchContext;
   
   public class QuickLinksView
   {
      private var _navigator:HabboNewNavigator;
      
      private var UnknownVarFromQuickLinksView_IRegionWindow_1:IRegionWindow;
      
      private var _itemList:IItemListWindow;
      
      private var _linkSearches:Array = [];
      
      private var UnknownVarFromQuickLinksView_Array_1:Array = [];
      
      public function QuickLinksView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function set itemList(param1:IItemListWindow) : void
      {
         _itemList = param1;
      }
      
      public function set template(param1:IRegionWindow) : void
      {
         UnknownVarFromQuickLinksView_IRegionWindow_1 = param1;
      }
      
      public function setQuickLinks(param1:Vector.<SavedSearch>) : void
      {
         var _loc2_:int = 0;
         var _loc4_:IRegionWindow = null;
         var _loc3_:ITextWindow = null;
         _itemList.removeListItems();
         _linkSearches = [];
         UnknownVarFromQuickLinksView_Array_1 = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = IRegionWindow(UnknownVarFromQuickLinksView_IRegionWindow_1.clone());
            _loc4_.id = _loc2_;
            _loc3_ = ITextWindow(_loc4_.findChildByName("quick_link_text"));
            _loc3_.caption = _navigator.localization.getLocalization("navigator.searchcode.title." + param1[_loc2_].searchCode,param1[_loc2_].searchCode) + (param1[_loc2_].filter != "" ? " - " + param1[_loc2_].filter : "");
            if(param1[_loc2_].searchCode.indexOf("category__") == 0)
            {
               _loc3_.caption = param1[_loc2_].searchCode.substr("category__".length) + (param1[_loc2_].filter != "" ? " - " + param1[_loc2_].filter : "");
            }
            _loc4_.procedure = listItemProcedure;
            _linkSearches.push(new SearchContext(param1[_loc2_].searchCode,param1[_loc2_].filter));
            UnknownVarFromQuickLinksView_Array_1.push(param1[_loc2_].id);
            _itemList.addListItem(_loc4_);
            _loc2_++;
         }
      }
      
      private function listItemProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:* = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2 is IRegionWindow)
            {
               if(_linkSearches.length > param2.id)
               {
                  _navigator.performSearchByContext(_linkSearches[param2.id]);
                  _navigator.trackEventLog("savedsearch.execute","SavedSearch",HabboNewNavigator.getEventLogExtraStringFromSearch(_linkSearches[param2.id].searchCode,_linkSearches[param2.id].filtering));
               }
            }
            else if(param2 is UnknownICoreWindowComponents5)
            {
               _navigator.deleteSavedSearch(UnknownVarFromQuickLinksView_Array_1[param2.parent.id]);
            }
         }
         else if(param1.type == "WME_OVER" || param1.type == "WME_OUT")
         {
            _loc3_ = param1.type == "WME_OVER";
            if(param2 is IRegionWindow)
            {
               UnknownICoreWindowComponents5(IRegionWindow(param2).getChildAt(1)).visible = _loc3_;
            }
            else if(param2 is UnknownICoreWindowComponents5)
            {
               param2.visible = _loc3_;
            }
         }
      }
   }
}

