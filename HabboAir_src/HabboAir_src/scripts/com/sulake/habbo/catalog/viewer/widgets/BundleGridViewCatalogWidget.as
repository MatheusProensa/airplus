package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class BundleGridViewCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid, IProductContainer
   {
      private var _offer:UnknownIHabboCatalog1;
      
      private var _gridItemLayout:XML;
      
      private var _itemGrid:IItemGridWindow;
      
      public function BundleGridViewCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         _itemGrid = IItemGridWindow(_window.findChildByName("bundleGrid"));
         return true;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            events.removeEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
            super.dispose();
         }
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc2_:UnknownIHabboCatalog1 = null;
         if(page.offers.length == 1)
         {
            _loc2_ = page.offers[0];
            if(_loc2_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc2_));
            }
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         _offer = param1.offer;
         _itemGrid.destroyGridItems();
         populateItemGrid();
      }
      
      protected function populateItemGrid() : void
      {
         var _loc5_:IWindowController_1 = null;
         var _loc1_:IWindowModel = null;
         var _loc4_:BitmapData = null;
         var _loc2_:IWindowController_1 = _offer.page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as IWindowController_1;
         for each(var _loc3_ in _offer.productContainer.products)
         {
            if(_loc3_.productType != "b")
            {
               _loc5_ = _loc2_.clone() as IWindowController_1;
               _loc1_ = _loc5_.findChildByName("clubLevelIcon");
               if(_loc1_ != null)
               {
                  _loc1_.visible = false;
               }
               _itemGrid.addGridItem(_loc5_);
               _loc3_.view = _loc5_;
               _loc4_ = _loc3_.initIcon(this);
               if(_loc4_ != null)
               {
                  _loc4_.dispose();
               }
               _loc3_.grid = this;
            }
         }
      }
      
      public function get offer() : UnknownIHabboCatalog1
      {
         return _offer;
      }
      
      public function select(param1:IProductGridItem, param2:Boolean) : void
      {
      }
      
      public function startDragAndDrop(param1:IProductGridItem) : Boolean
      {
         return false;
      }
      
      public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
      }
      
      public function activate() : void
      {
      }
      
      public function get products() : Vector.<IProduct>
      {
         return null;
      }
      
      public function get firstProduct() : IProduct
      {
         return null;
      }
      
      public function set view(param1:IWindowController_1) : void
      {
      }
      
      public function get view() : IWindowController_1
      {
         return null;
      }
      
      public function set grid(param1:IItemGrid) : void
      {
      }
      
      public function setClubIconLevel(param1:int) : void
      {
      }
   }
}

