package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IPetImageWidget extends IWindowController_2
   {
      function get figure() : String;
      
      function set figure(param1:String) : void;
      
      function get scale() : int;
      
      function set scale(param1:int) : void;
      
      function get direction() : int;
      
      function set direction(param1:int) : void;
      
      function get zoomX() : Number;
      
      function set zoomX(param1:Number) : void;
      
      function get zoomY() : Number;
      
      function set zoomY(param1:Number) : void;
      
      function get petWidth() : int;
      
      function get petHeight() : int;
      
      function get shrinkOnOverflow() : Boolean;
      
      function set shrinkOnOverflow(param1:Boolean) : void;
      
      function refresh() : void;
   }
}

