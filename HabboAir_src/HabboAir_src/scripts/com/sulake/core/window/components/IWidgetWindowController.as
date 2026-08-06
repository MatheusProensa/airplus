package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_2;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.utils.IIterable;
   
   public interface IWidgetWindowController extends IWindowModel, IIterable
   {
      function get widget() : IWindowController_2;
      
      function get rootWindow() : IWindowModel;
      
      function set rootWindow(param1:IWindowModel) : void;
   }
}

