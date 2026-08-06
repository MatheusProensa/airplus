package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   
   public interface IRarityItemOverlayWidget extends IWindowController_2
   {
      function set rarityLevel(param1:int) : void;
      
      function get rarityLevel() : int;
   }
}

