package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IFurnitureImageWidget extends IWindowController_2
   {
      function get furnitureType() : String;
      
      function set furnitureType(param1:String) : void;
      
      function get scale() : int;
      
      function set scale(param1:int) : void;
      
      function get direction() : int;
      
      function set direction(param1:int) : void;
   }
}

