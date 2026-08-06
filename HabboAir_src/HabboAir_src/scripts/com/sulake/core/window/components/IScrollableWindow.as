package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import flash.geom.Rectangle;
   
   public interface IScrollableWindow extends IWindowModel
   {
      function get scrollH() : Number;
      
      function get scrollV() : Number;
      
      function set scrollH(param1:Number) : void;
      
      function set scrollV(param1:Number) : void;
      
      function get maxScrollH() : int;
      
      function get maxScrollV() : int;
      
      function get visibleRegion() : Rectangle;
      
      function get scrollableRegion() : Rectangle;
   }
}

