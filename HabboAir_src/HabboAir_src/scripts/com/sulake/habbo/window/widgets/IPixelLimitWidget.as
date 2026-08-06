package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   
   public interface IPixelLimitWidget extends IWindowController_2, UnknownICoreWindowUtils4
   {
      function get limit() : int;
      
      function set limit(param1:int) : void;
   }
}

