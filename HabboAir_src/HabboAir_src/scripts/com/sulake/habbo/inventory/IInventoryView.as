package com.sulake.habbo.inventory
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   
   public interface IInventoryView extends IComponentInterfaceQueue
   {
      function getWindowContainer() : IWindowController_1;
   }
}

