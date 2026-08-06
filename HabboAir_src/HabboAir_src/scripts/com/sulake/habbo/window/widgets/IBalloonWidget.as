package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IBalloonWidget extends IWindowController_2
   {
      function get arrowPivot() : String;
      
      function set arrowPivot(param1:String) : void;
      
      function get arrowDisplacement() : int;
      
      function set arrowDisplacement(param1:int) : void;
   }
}

