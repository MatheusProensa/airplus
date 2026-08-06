package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public class CatalogWidget implements ICatalogWidget
   {
      protected var _window:IWindowController_1;
      
      protected var _events:IEventDispatcher;
      
      private var _page:ICatalogPage;
      
      private var _disposed:Boolean;
      
      protected var _isEmbedded:Boolean = false;
      
      public function CatalogWidget(param1:IWindowController_1)
      {
         super();
         _window = param1;
         _isEmbedded = param1.tags.indexOf("EMBEDDED") > -1;
      }
      
      public function set page(param1:ICatalogPage) : void
      {
         _page = param1;
      }
      
      public function set events(param1:IEventDispatcher) : void
      {
         _events = param1;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get events() : IEventDispatcher
      {
         return _events;
      }
      
      public function get page() : ICatalogPage
      {
         return _page;
      }
      
      public function dispose() : void
      {
         _events = null;
         _page = null;
         _window = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function init() : Boolean
      {
         return true;
      }
      
      public function closed() : void
      {
      }
      
      protected function getAssetXML(param1:String) : XML
      {
         if(!page || !page.viewer || !page.viewer.catalog || !page.viewer.catalog.assets)
         {
            return null;
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as XML;
      }
      
      protected function attachWidgetView(param1:String) : void
      {
         if(_isEmbedded)
         {
            return;
         }
         var _loc2_:XML = getAssetXML(param1);
         if(_loc2_ == null)
         {
            return;
         }
         window.removeChildAt(0);
         if(!window || !page || !page.viewer || !page.viewer.catalog)
         {
            return;
         }
         window.addChild(page.viewer.catalog.windowManager.buildFromXML(_loc2_));
      }
      
      protected function getAssetBitmapData(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as BitmapData;
      }
   }
}

