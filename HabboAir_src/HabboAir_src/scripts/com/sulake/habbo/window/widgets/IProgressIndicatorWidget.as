package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IProgressIndicatorWidget extends IWindowController_2
   {
      function get size() : uint;
      
      function set size(param1:uint) : void;
      
      function get position() : uint;
      
      function set position(param1:uint) : void;
      
      function get mode() : String;
      
      function set mode(param1:String) : void;
   }
}

