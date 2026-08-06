package com.sulake.habbo.catalog
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.navigation.CatalogNavigator;
   import com.sulake.habbo.catalog.navigation.ICatalogNode;
   
   public class TopViewSelector
   {
      private var _catalog:CatalogNavigator;
      
      private var UnknownVarFromTopViewSelector_ITabButtonWindow_1:ITabButtonWindow;
      
      private var _tabContext:ITabContextWindow;
      
      public function TopViewSelector(param1:CatalogNavigator, param2:ITabContextWindow)
      {
         super();
         _catalog = param1;
         _tabContext = param2;
         var _loc3_:ITabButtonWindow = ITabButtonWindow(param2.getTabItemAt(0).clone());
         UnknownVarFromTopViewSelector_ITabButtonWindow_1 = _loc3_;
         _tabContext.removeTabItem(_loc3_);
      }
      
      public function addTabItem(param1:ICatalogNode) : void
      {
         var _loc2_:ITabButtonWindow = ITabButtonWindow(UnknownVarFromTopViewSelector_ITabButtonWindow_1.clone());
         _loc2_.caption = param1.localization;
         _loc2_.name = param1.pageName;
         _loc2_.procedure = topViewSelectorButtonProcedure;
         _tabContext.addTabItem(_loc2_);
         alignTabs();
      }
      
      private function alignTabs() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _tabContext.numTabItems)
         {
            _tabContext.getTabItemAt(_loc1_).width = _tabContext.getTabItemAt(_loc1_).parent.width / _tabContext.numTabItems;
            _loc1_++;
         }
      }
      
      public function clearTabs() : void
      {
         while(_tabContext.numTabItems > 0)
         {
            _tabContext.removeTabItem(_tabContext.getTabItemAt(0));
         }
      }
      
      public function selectTabByIndex(param1:int) : void
      {
         _tabContext.selector.setSelected(_tabContext.getTabItemAt(param1));
         selectTabButton(_tabContext.getTabItemAt(param1));
      }
      
      private function topViewSelectorButtonProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:ITabButtonWindow = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = param2 as ITabButtonWindow;
            if(_loc3_)
            {
               selectTabButton(_loc3_);
            }
         }
      }
      
      private function selectTabButton(param1:ITabButtonWindow) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:ICatalogNode = _catalog.getNodeByName(param1.name);
         if(_loc2_ != null)
         {
            _catalog.showNodeContent(_loc2_);
         }
      }
   }
}

