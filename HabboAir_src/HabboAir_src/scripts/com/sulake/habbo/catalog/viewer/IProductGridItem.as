package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   
   public interface IProductGridItem extends IComponentInterfaceQueue
   {
      function get view() : IWindowController_1;
      
      function set view(param1:IWindowController_1) : void;
      
      function set grid(param1:IItemGrid) : void;
      
      function setDraggable(param1:Boolean) : void;
      
      function activate() : void;
      
      function deactivate() : void;
   }
}

