package com.sulake.habbo.inventory
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   
   public interface IInventoryModel extends IComponentInterfaceQueue
   {
      function getWindowContainer() : IWindowController_1;
      
      function requestInitialization() : void;
      
      function categorySwitch(param1:String) : void;
      
      function subCategorySwitch(param1:String) : void;
      
      function closingInventoryView() : void;
      
      function updateView() : void;
      
      function selectItemById(param1:String) : void;
   }
}

