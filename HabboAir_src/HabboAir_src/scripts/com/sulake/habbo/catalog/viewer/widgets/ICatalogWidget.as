package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import flash.events.IEventDispatcher;
   
   public interface ICatalogWidget
   {
      function set page(param1:ICatalogPage) : void;
      
      function set events(param1:IEventDispatcher) : void;
      
      function get window() : IWindowController_1;
      
      function get events() : IEventDispatcher;
      
      function get page() : ICatalogPage;
      
      function dispose() : void;
      
      function init() : Boolean;
      
      function closed() : void;
   }
}

