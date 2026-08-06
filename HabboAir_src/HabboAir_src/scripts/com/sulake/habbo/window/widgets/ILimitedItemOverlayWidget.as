package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface ILimitedItemOverlayWidget extends IWindowController_2
   {
      function set serialNumber(param1:int) : void;
      
      function set seriesSize(param1:int) : void;
      
      function get serialNumber() : int;
      
      function get seriesSize() : int;
   }
}

