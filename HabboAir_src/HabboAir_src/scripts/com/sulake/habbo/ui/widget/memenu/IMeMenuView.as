package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface IMeMenuView
   {
      function init(param1:MeMenuWidget, param2:String) : void;
      
      function dispose() : void;
      
      function get window() : IWindowController_1;
      
      function updateUnseenItemCount(param1:String, param2:int) : void;
   }
}

