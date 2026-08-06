package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IRoomThumbnailWidget extends IWindowController_2
   {
      function reset() : void;
      
      function set flatId(param1:int) : void;
   }
}

