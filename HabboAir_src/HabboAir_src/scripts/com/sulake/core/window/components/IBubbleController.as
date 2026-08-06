package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.utils.IMargins;
   
   public interface IBubbleController extends IWindowController_1
   {
      function get direction() : String;
      
      function set direction(param1:String) : void;
      
      function get pointerOffset() : int;
      
      function set pointerOffset(param1:int) : void;
      
      function get margins() : IMargins;
      
      function get content() : IWindowController_1;
   }
}

