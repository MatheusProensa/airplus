package com.sulake.habbo.window.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   
   public interface ILimitedItemOverlay extends IComponentInterfaceQueue
   {
      function get window() : IWindowController_1;
      
      function set serialNumber(param1:int) : void;
      
      function set seriesSize(param1:int) : void;
   }
}

