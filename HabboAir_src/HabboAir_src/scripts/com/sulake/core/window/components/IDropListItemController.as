package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   
   public interface IDropListItemController extends UnknownICoreWindowComponents4
   {
      function get menu() : IDropBaseController_1;
      
      function get value() : IWindowModel;
      
      function set value(param1:IWindowModel) : void;
   }
}

