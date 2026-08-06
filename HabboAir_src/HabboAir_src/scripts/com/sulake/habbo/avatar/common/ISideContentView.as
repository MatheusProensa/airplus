package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface ISideContentView
   {
      function dispose() : void;
      
      function getWindowContainer() : IWindowController_1;
   }
}

