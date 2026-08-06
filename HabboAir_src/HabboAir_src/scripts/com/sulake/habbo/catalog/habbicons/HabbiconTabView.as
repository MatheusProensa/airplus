package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class HabbiconTabView implements IComponentInterfaceQueue
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconTabView_Function_1:Function;
      
      private var _activeMode:String;
      
      private var _disposed:Boolean;
      
      public function HabbiconTabView(param1:IWindowController_1, param2:Function)
      {
         super();
         _window = param1;
         UnknownVarFromHabbiconTabView_Function_1 = param2;
         tabAllSets.addEventListener("WE_SELECTED",onTabSelected);
         tabOwned.addEventListener("WE_SELECTED",onTabSelected);
         tabFavourited.addEventListener("WE_SELECTED",onTabSelected);
      }
      
      public function select(param1:String) : void
      {
         var _loc2_:ITabButtonWindow = getTabByMode(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == _activeMode)
         {
            return;
         }
         _activeMode = param1;
         if(tabContext.selector.getSelected() != _loc2_)
         {
            tabContext.selector.setSelected(_loc2_);
         }
      }
      
      private function onTabSelected(param1:WindowEvent) : void
      {
         var _loc2_:String = getModeByTab(param1.target);
         if(_loc2_ == null || _loc2_ == _activeMode)
         {
            return;
         }
         _activeMode = _loc2_;
         UnknownVarFromHabbiconTabView_Function_1(_loc2_);
      }
      
      private function getModeByTab(param1:IWindowModel) : String
      {
         switch(param1.name)
         {
            case "tab_all_sets":
               return "all_sets";
            case "tab_owned":
               return "owned";
            case "tab_favourited":
               return "favourited";
            default:
               return null;
         }
      }
      
      private function getTabByMode(param1:String) : ITabButtonWindow
      {
         switch(param1)
         {
            case "all_sets":
               return tabAllSets;
            case "owned":
               return tabOwned;
            case "favourited":
               return tabFavourited;
            default:
               return null;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         tabAllSets.removeEventListener("WE_SELECTED",onTabSelected);
         tabOwned.removeEventListener("WE_SELECTED",onTabSelected);
         tabFavourited.removeEventListener("WE_SELECTED",onTabSelected);
         UnknownVarFromHabbiconTabView_Function_1 = null;
         _activeMode = null;
         _window = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get tabContext() : ITabContextWindow
      {
         return _window.findChildByName("tab_context") as ITabContextWindow;
      }
      
      private function get tabAllSets() : ITabButtonWindow
      {
         return _window.findChildByName("tab_all_sets") as ITabButtonWindow;
      }
      
      private function get tabOwned() : ITabButtonWindow
      {
         return _window.findChildByName("tab_owned") as ITabButtonWindow;
      }
      
      private function get tabFavourited() : ITabButtonWindow
      {
         return _window.findChildByName("tab_favourited") as ITabButtonWindow;
      }
   }
}

