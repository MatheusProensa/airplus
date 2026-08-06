package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IUpdatingTimeStampWidget extends IWindowController_2
   {
      function reset() : void;
      
      function get timeStamp() : Number;
      
      function set timeStamp(param1:Number) : void;
      
      function set align(param1:String) : void;
   }
}

