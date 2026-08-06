package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IChestItemGridOverlayWidget extends IWindowController_2
   {
      function set contentsCount(param1:int) : void;
      
      function get contentsCount() : int;
      
      function set color(param1:String) : void;
      
      function get color() : String;
   }
}

