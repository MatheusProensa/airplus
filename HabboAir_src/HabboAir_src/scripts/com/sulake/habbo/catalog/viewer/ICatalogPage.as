package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import flash.events.Event;
   
   public interface ICatalogPage
   {
      function dispose() : void;
      
      function init() : void;
      
      function closed() : void;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get window() : IWindowController_1;
      
      function get viewer() : ICatalogViewer;
      
      function get pageId() : int;
      
      function get offers() : Vector.<UnknownIHabboCatalog1>;
      
      function get localization() : IPageLocalization;
      
      function get layoutCode() : String;
      
      function get hasLinks() : Boolean;
      
      function get links() : Array;
      
      function selectOffer(param1:int) : void;
      
      function replaceOffers(param1:Vector.<UnknownIHabboCatalog1>, param2:Boolean = false) : void;
      
      function updateLimitedItemsLeft(param1:int, param2:int) : void;
      
      function get acceptSeasonCurrencyAsCredits() : Boolean;
      
      function get allowDragging() : Boolean;
      
      function set searchPageId(param1:int) : void;
      
      function get mode() : int;
      
      function get isBuilderPage() : Boolean;
   }
}

