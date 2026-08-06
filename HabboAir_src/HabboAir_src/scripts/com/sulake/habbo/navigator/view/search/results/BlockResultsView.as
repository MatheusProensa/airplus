package com.sulake.habbo.navigator.view.search.results
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultList;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultSet;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import flash.utils.Dictionary;
   
   public class BlockResultsView
   {
      private var _navigator:HabboNewNavigator;
      
      private var _itemList:IItemListWindow;
      
      private var UnknownVarFromBlockResultsView_CategoryElementFactory_1:CategoryElementFactory;
      
      private var UnknownVarFromBlockResultsView_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromBlockResultsView_Dictionary_2:Dictionary = new Dictionary();
      
      private var _searchCodeViewMode:Dictionary = new Dictionary();
      
      public function BlockResultsView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function get itemList() : IItemListWindow
      {
         return _itemList;
      }
      
      public function set itemList(param1:IItemListWindow) : void
      {
         _itemList = param1;
      }
      
      public function set categoryElementFactory(param1:CategoryElementFactory) : void
      {
         UnknownVarFromBlockResultsView_CategoryElementFactory_1 = param1;
      }
      
      public function displayCurrentResults() : void
      {
         var _loc1_:IWindowModel = null;
         var _loc4_:SearchResultSet = null;
         var _loc2_:int = 0;
         var _loc3_:SearchResultList = null;
         if(_navigator.currentResults == null)
         {
            return;
         }
         UnknownVarFromBlockResultsView_Dictionary_2 = new Dictionary();
         UnknownVarFromBlockResultsView_Dictionary_1 = new Dictionary();
         _searchCodeViewMode = new Dictionary();
         _itemList.destroyListItems();
         if(_navigator.currentResults.resultSet.blocks.length == 0)
         {
            _itemList.addListItem(UnknownVarFromBlockResultsView_CategoryElementFactory_1.getNoResultsELement());
         }
         else
         {
            _loc4_ = _navigator.currentResults.resultSet;
            _loc2_ = 0;
            while(_loc2_ < _loc4_.blocks.length)
            {
               _loc3_ = _loc4_.blocks[_loc2_];
               _loc1_ = renderCurrentResultsBlock(_loc2_,(!isMinimized(_loc3_.searchCode) || isSingleBlock(_loc4_)) && !_loc3_.forceClosed);
               _loc1_.id = _loc2_;
               _itemList.addListItem(_loc1_);
               UnknownVarFromBlockResultsView_Dictionary_2[_loc2_] = _loc1_;
               UnknownVarFromBlockResultsView_Dictionary_1[_loc2_] = _loc3_.searchCode;
               _searchCodeViewMode[_loc2_] = _loc3_.viewMode;
               _loc2_++;
            }
         }
         _itemList.arrangeListItems();
      }
      
      public function onCategoryShowMoreClicked(param1:WindowEvent) : void
      {
         _navigator.performSearch(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id],_navigator.currentResults.filteringData);
         _navigator.trackEventLog("browse.expandsearch","Results",HabboNewNavigator.getEventLogExtraStringFromSearch(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id],_navigator.currentResults.filteringData));
      }
      
      public function onCategoryBackClicked(param1:WindowEvent) : void
      {
         _navigator.goBack();
      }
      
      public function onCategoryCollapseClicked(param1:WindowEvent) : void
      {
         _navigator.sendAddCollapsedCategory(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id]);
         _navigator.collapsedCategories.push(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id]);
         replaceBlock(param1.window.id,false);
         _navigator.trackEventLog("browse.collapsecategory","Results",HabboNewNavigator.getEventLogExtraStringFromSearch(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id],_navigator.currentResults.filteringData));
      }
      
      public function onCategoryExpandClicked(param1:WindowEvent) : void
      {
         _navigator.sendRemoveCollapsedCategory(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id]);
         _navigator.collapsedCategories.splice(_navigator.collapsedCategories.indexOf(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id]),1);
         replaceBlock(param1.window.id,true);
         _navigator.trackEventLog("browse.uncollapsecategory","Results",HabboNewNavigator.getEventLogExtraStringFromSearch(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id],_navigator.currentResults.filteringData));
      }
      
      public function onCategoryAddQuickLinkClicked(param1:WindowEvent) : void
      {
         _navigator.addSavedSearch(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id],_navigator.currentResults.filteringData);
      }
      
      public function onCategoryToggleModeClicked(param1:WindowEvent) : void
      {
         var _loc2_:int = getToggledViewMode(_searchCodeViewMode[param1.window.id]);
         _navigator.toggleSearchCodeViewMode(UnknownVarFromBlockResultsView_Dictionary_1[param1.window.id],_loc2_);
         _navigator.currentResults.resultSet.blocks[param1.window.id].viewMode = _loc2_;
         replaceBlock(param1.window.id,true);
         _searchCodeViewMode[param1.window.id] = _loc2_;
      }
      
      private function getToggledViewMode(param1:int) : int
      {
         if(param1 == 0)
         {
            return 1;
         }
         return 0;
      }
      
      public function get itemListWidth() : int
      {
         return _itemList.width;
      }
      
      private function isMinimized(param1:String) : Boolean
      {
         return _navigator.collapsedCategories.indexOf(param1) != -1;
      }
      
      private function isSingleBlock(param1:SearchResultSet) : Boolean
      {
         return param1.blocks.length == 1;
      }
      
      private function renderCurrentResultsBlock(param1:int, param2:Boolean) : IWindowModel
      {
         var _loc5_:int = 0;
         var _loc3_:SearchResultList = _navigator.currentResults.resultSet.blocks[param1];
         var _loc4_:String = _loc3_.text == "" ? "${navigator.searchcode.title." + _loc3_.searchCode + "}" : _loc3_.text;
         if(param2)
         {
            _loc5_ = !_navigator.sessionData.isPerkAllowed("NAVIGATOR_ROOM_THUMBNAIL_CAMERA") && _navigator.currentResults.searchCodeOriginal != "official_view" ? 0 : _loc3_.viewMode;
            return UnknownVarFromBlockResultsView_CategoryElementFactory_1.getOpenCategoryElement(_loc3_.guestRooms,_loc4_,param1,_loc3_.actionAllowed,_loc5_);
         }
         return UnknownVarFromBlockResultsView_CategoryElementFactory_1.getCollapsedCategoryElement(_loc4_,param1,_loc3_.actionAllowed);
      }
      
      private function replaceBlock(param1:int, param2:Boolean) : void
      {
         var _loc4_:int = _itemList.getListItemIndex(UnknownVarFromBlockResultsView_Dictionary_2[param1]);
         _itemList.removeListItemAt(_loc4_);
         var _loc3_:IWindowModel = renderCurrentResultsBlock(param1,param2);
         _loc3_.id = param1;
         _itemList.addListItemAt(_loc3_,_loc4_);
         UnknownVarFromBlockResultsView_Dictionary_2[param1] = _loc3_;
      }
   }
}

