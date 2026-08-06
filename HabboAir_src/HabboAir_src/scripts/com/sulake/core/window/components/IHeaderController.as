package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface IHeaderController extends IWindowController_1
   {
      function get title() : ILabelWindow;
      
      function get controls() : IItemListWindow;
   }
}

