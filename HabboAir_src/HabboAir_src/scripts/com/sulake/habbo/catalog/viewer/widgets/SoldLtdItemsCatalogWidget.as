package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.navigation.ICatalogNavigator;
   import com.sulake.habbo.catalog.navigation.ICatalogNode;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   
   public class SoldLtdItemsCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var _catalog:HabboCatalog;
      
      public function SoldLtdItemsCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onPreviewProduct);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("soldLtdItemsWidget");
         window.visible = false;
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         return true;
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc4_:ICatalogNavigator = null;
         var _loc3_:* = undefined;
         if(param1 == null || param1.offer == null || param1.offer.product == null)
         {
            return;
         }
         if(page.mode == 1)
         {
            _loc4_ = _catalog.getCatalogNavigator(page.viewer.catalogType);
            _loc3_ = _loc4_ == null ? null : _loc4_.getNodesByOfferId(param1.offer.offerId);
            if(!_loc3_)
            {
               _loc3_ = new Vector.<ICatalogNode>(0);
            }
            for each(var _loc2_ in _loc3_)
            {
               if(_loc2_.pageName.indexOf("limited_sold") > -1)
               {
                  window.visible = true;
                  events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget",false));
                  return;
               }
            }
         }
         if(page.layoutCode == "sold_ltd_items")
         {
            window.visible = true;
            events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget",false));
            return;
         }
         if(param1.offer.product.isUniqueLimitedItem && param1.offer.product.uniqueLimitedItemsLeft == 0)
         {
            window.visible = true;
            events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget",false));
         }
         else
         {
            window.visible = false;
            events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget",true));
         }
      }
   }
}

