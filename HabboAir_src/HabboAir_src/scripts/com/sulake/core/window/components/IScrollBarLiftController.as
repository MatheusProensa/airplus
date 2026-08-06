package com.sulake.core.window.components
{
   public interface IScrollBarLiftController extends IInteractiveWindow
   {
      function get scrollbarOffsetX() : Number;
      
      function get scrollbarOffsetY() : Number;
      
      function set scrollbarOffsetX(param1:Number) : void;
      
      function set scrollbarOffsetY(param1:Number) : void;
   }
}

