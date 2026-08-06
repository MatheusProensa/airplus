package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.room.IRoomEngine;
   import flash.events.Event;
   
   public interface ICatalogViewer
   {
      function showCatalogPage(param1:int, param2:String, param3:IPageLocalization, param4:Vector.<UnknownIHabboCatalog1>, param5:int, param6:Boolean) : void;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get catalog() : IHabboCatalog;
      
      function get catalogType() : String;
      
      function get mainContainer() : IWindowController_1;
      
      function get roomEngine() : IRoomEngine;
      
      function dispose() : void;
      
      function getCurrentLayoutCode() : String;
      
      function get viewerTags() : Array;
   }
}

