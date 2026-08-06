package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.utils.IIterable;
   
   public interface IDropBaseController_2 extends IInteractiveWindow, IIterable
   {
      function get selection() : int;
      
      function set selection(param1:int) : void;
      
      function get numMenuItems() : int;
      
      function addMenuItem(param1:IWindowModel) : IWindowModel;
      
      function addMenuItemAt(param1:IWindowModel, param2:int) : IWindowModel;
      
      function getMenuItemIndex(param1:IWindowModel) : int;
      
      function getMenuItemAt(param1:int) : IWindowModel;
      
      function removeMenuItem(param1:IWindowModel) : IWindowModel;
      
      function removeMenuItemAt(param1:int) : IWindowModel;
   }
}

