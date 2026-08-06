package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.window.utils.ILimitedItemOverlay;
   import com.sulake.habbo.window.widgets.ILimitedItemSupplyLeftOverlayWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UniqueLimitedItemWidget extends CatalogWidget implements ICatalogWidget
   {
      private static const SUPPLY_REFRESH_PERIOD_MS:int = 20000;
      
      private var _catalog:HabboCatalog;
      
      private var _overlay:ILimitedItemOverlay;
      
      private var UnknownVarFromUniqueLimitedItemWidget_UnknownIHabboCatalog1_1:UnknownIHabboCatalog1;
      
      private var UnknownVarFromUniqueLimitedItemWidget_Timer_1:Timer;
      
      private var _overlayWidget:ILimitedItemSupplyLeftOverlayWidget;
      
      public function UniqueLimitedItemWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromUniqueLimitedItemWidget_Timer_1 != null)
            {
               UnknownVarFromUniqueLimitedItemWidget_Timer_1.stop();
               UnknownVarFromUniqueLimitedItemWidget_Timer_1.removeEventListener("timer",onSupplyLeftTimer);
               UnknownVarFromUniqueLimitedItemWidget_Timer_1 = null;
            }
            window.visible = false;
            _catalog = null;
            UnknownVarFromUniqueLimitedItemWidget_UnknownIHabboCatalog1_1 = null;
            if(_overlay)
            {
               _overlay.dispose();
               _overlay = null;
            }
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            events.removeEventListener("CWE_PRODUCT_OFFER_UPDATED",onOfferUpdated);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var _loc1_:IWidgetWindowController = IWidgetWindowController(_window.findChildByName("unique_item_overlay_container"));
         _overlayWidget = ILimitedItemSupplyLeftOverlayWidget(_loc1_.widget);
         window.visible = false;
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("CWE_PRODUCT_OFFER_UPDATED",onOfferUpdated);
         UnknownVarFromUniqueLimitedItemWidget_Timer_1 = new Timer(20000);
         UnknownVarFromUniqueLimitedItemWidget_Timer_1.addEventListener("timer",onSupplyLeftTimer);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromUniqueLimitedItemWidget_UnknownIHabboCatalog1_1 = param1.offer;
         update(param1.offer,true);
      }
      
      private function onOfferUpdated(param1:ProductOfferUpdatedEvent) : void
      {
         UnknownVarFromUniqueLimitedItemWidget_UnknownIHabboCatalog1_1 = param1.offer;
         update(param1.offer);
      }
      
      private function update(param1:UnknownIHabboCatalog1, param2:Boolean = false) : void
      {
         var _loc3_:IProduct = null;
         if(param1.pricingModel == "pricing_model_single" && param1.product.isUniqueLimitedItem)
         {
            _loc3_ = param1.product;
            _overlayWidget.supplyLeft = _loc3_.uniqueLimitedItemsLeft;
            _overlayWidget.seriesSize = _loc3_.uniqueLimitedItemSeriesSize;
            window.visible = true;
            if(param2)
            {
               _catalog.sendGetProductOffer(param1.offerId);
            }
            UnknownVarFromUniqueLimitedItemWidget_Timer_1.start();
         }
         else
         {
            window.visible = false;
            UnknownVarFromUniqueLimitedItemWidget_Timer_1.stop();
         }
      }
      
      private function onSupplyLeftTimer(param1:TimerEvent) : void
      {
         if(_window.visible && UnknownVarFromUniqueLimitedItemWidget_UnknownIHabboCatalog1_1 != null)
         {
            update(UnknownVarFromUniqueLimitedItemWidget_UnknownIHabboCatalog1_1,true);
         }
      }
   }
}

