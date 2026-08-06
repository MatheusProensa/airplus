package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface IViewCtrl
   {
      function refresh() : void;
      
      function set content(param1:IWindowController_1) : void;
      
      function get content() : IWindowController_1;
   }
}

