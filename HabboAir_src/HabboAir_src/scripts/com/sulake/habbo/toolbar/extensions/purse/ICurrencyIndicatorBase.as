package com.sulake.habbo.toolbar.extensions.purse
{
   import com.sulake.core.window.IWindowController_1;
   import flash.events.IEventDispatcher;
   
   public interface ICurrencyIndicatorBase
   {
      function dispose() : void;
      
      function get window() : IWindowController_1;
      
      function registerUpdateEvents(param1:IEventDispatcher) : void;
   }
}

