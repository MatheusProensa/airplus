package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface ISeparatorWidget extends IWindowController_2
   {
      function get vertical() : Boolean;
      
      function set vertical(param1:Boolean) : void;
   }
}

