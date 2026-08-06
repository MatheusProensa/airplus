package com.sulake.habbo.navigator.view
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class TopViewSelector
   {
      private var _navigator:HabboNewNavigator;
      
      private var UnknownVarFromTopViewSelector_ITabButtonWindow_1:ITabButtonWindow;
      
      private var _tabContext:ITabContextWindow;
      
      public function TopViewSelector(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function set template(param1:ITabButtonWindow) : void
      {
         UnknownVarFromTopViewSelector_ITabButtonWindow_1 = param1;
      }
      
      public function set tabContext(param1:ITabContextWindow) : void
      {
         _tabContext = param1;
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc3_:String = null;
         var _loc2_:ITabButtonWindow = null;
         clearTabs();
         _loc1_ = 0;
         while(_loc1_ < _navigator.contextContainer.getTopLevelSearches().length)
         {
            _loc3_ = _navigator.contextContainer.getTopLevelSearches()[_loc1_];
            _loc2_ = ITabButtonWindow(UnknownVarFromTopViewSelector_ITabButtonWindow_1.clone());
            _loc2_.caption = "${navigator.toplevelview." + _loc3_ + "}";
            _loc2_.id = _loc1_;
            _loc2_.procedure = topViewSelectorButtonProcedure;
            _tabContext.addTabItem(_loc2_);
            _loc1_++;
         }
      }
      
      public function selectTabByIndex(param1:int) : void
      {
         _tabContext.selector.setSelected(_tabContext.getTabItemAt(param1));
      }
      
      private function clearTabs() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _tabContext.numTabItems)
         {
            _tabContext.removeTabItem(_tabContext.getTabItemAt(0));
            _loc1_++;
         }
      }
      
      private function topViewSelectorButtonProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(_navigator.contextContainer.getTopLevelSearches().length > param2.id)
            {
               _navigator.performSearch(_navigator.contextContainer.getTopLevelSearches()[param2.id].replace("hotel_view","popular"),"",_navigator.view.currentFilterText());
            }
         }
      }
   }
}

