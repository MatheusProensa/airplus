package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import flash.events.Event;
   
   public class TotalPriceWidget extends CatalogWidget implements ICatalogWidget
   {
      private static const ELEMENT_TOTAL_PRICE_CONTAINER:String = "totalprice_container";
      
      private static const ELEMENT_PLUS:String = "plus";
      
      private static const UnknownConstFromTotalPriceWidget_String_1:String = "amount_text_left";
      
      private static const ELEMENT_AMOUNT_TEXT_RIGHT:String = "amount_text_right";
      
      private static const UnknownConstFromTotalPriceWidget_String_2:String = "total_left";
      
      private static const ELEMENT_TOTAL_RIGHT:String = "total_right";
      
      private static const UnknownConstFromTotalPriceWidget_String_3:String = "currency_indicator_bitmap_left";
      
      private static const ELEMENT_CURRENCY_INDICATOR_BITMAP_RIGHT:String = "currency_indicator_bitmap_right";
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromTotalPriceWidget_Int_1:int;
      
      private var UnknownVarFromTotalPriceWidget_Int_2:int;
      
      private var UnknownVarFromTotalPriceWidget_Int_3:int;
      
      private var UnknownVarFromTotalPriceWidget_Int_4:int;
      
      private var UnknownVarFromTotalPriceWidget_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromTotalPriceWidget_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromTotalPriceWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromTotalPriceWidget_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromTotalPriceWidget_Int_5:int = 1;
      
      public function TotalPriceWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _catalog = null;
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChangedEvent);
            events.removeEventListener("SELECT_PRODUCT",onSelectProductEvent);
            clear();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(page.isBuilderPage)
         {
            window.visible = false;
            return true;
         }
         attachWidgetView("totalPriceWidget");
         window.visible = false;
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChangedEvent);
         events.addEventListener("SELECT_PRODUCT",onSelectProductEvent);
         events.dispatchEvent(new Event("TOTAL_PRICE_WIDGET_INITIALIZED"));
         return true;
      }
      
      private function onSpinnerValueChangedEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         UnknownVarFromTotalPriceWidget_Int_5 = param1.value;
         updateCurrencyIndicators();
      }
      
      private function onSelectProductEvent(param1:SelectProductEvent) : void
      {
         window.visible = param1.offer.bundlePurchaseAllowed;
         UnknownVarFromTotalPriceWidget_Int_1 = param1.offer.priceInCredits;
         UnknownVarFromTotalPriceWidget_Int_2 = param1.offer.priceInActivityPoints;
         UnknownVarFromTotalPriceWidget_Int_3 = param1.offer.priceInSilver;
         UnknownVarFromTotalPriceWidget_Int_4 = param1.offer.activityPointType;
         UnknownVarFromTotalPriceWidget_Int_5 = 1;
         clear();
         createCurrencyIndicators();
         updateCurrencyIndicators();
      }
      
      private function clear() : void
      {
         UnknownVarFromTotalPriceWidget_IWindowModel_1 = null;
         UnknownVarFromTotalPriceWidget_IWindowModel_2 = null;
         UnknownVarFromTotalPriceWidget_IWindowController_1_1 = null;
         UnknownVarFromTotalPriceWidget_IWindowController_1_2 = null;
         _window.findChildByName("plus").visible = false;
         _window.findChildByName("amount_text_left").visible = false;
         if(_window.findChildByName("total_left"))
         {
            _window.findChildByName("total_left").visible = false;
         }
         if(_window.findChildByName("total_right"))
         {
            _window.findChildByName("total_right").visible = false;
         }
         _window.findChildByName("currency_indicator_bitmap_left").visible = false;
      }
      
      private function updateCurrencyIndicators() : void
      {
         var _loc4_:IWindowModel = null;
         var _loc8_:IWindowModel = null;
         _loc8_ = null;
         var _loc3_:int = UnknownVarFromTotalPriceWidget_Int_5 * UnknownVarFromTotalPriceWidget_Int_1;
         var _loc7_:int = UnknownVarFromTotalPriceWidget_Int_5 * UnknownVarFromTotalPriceWidget_Int_2;
         var _loc6_:int = UnknownVarFromTotalPriceWidget_Int_5 * UnknownVarFromTotalPriceWidget_Int_3;
         var _loc1_:* = _loc3_;
         var _loc2_:* = _loc7_;
         var _loc5_:* = _loc6_;
         if(_catalog.bundleDiscountEnabled)
         {
            _loc1_ = _catalog.utils.calculateBundlePrice(true,UnknownVarFromTotalPriceWidget_Int_1,UnknownVarFromTotalPriceWidget_Int_5);
            _loc2_ = _catalog.utils.calculateBundlePrice(true,UnknownVarFromTotalPriceWidget_Int_2,UnknownVarFromTotalPriceWidget_Int_5);
            _loc5_ = _catalog.utils.calculateBundlePrice(true,UnknownVarFromTotalPriceWidget_Int_3,UnknownVarFromTotalPriceWidget_Int_5);
         }
         if(UnknownVarFromTotalPriceWidget_IWindowModel_1 != null)
         {
            UnknownVarFromTotalPriceWidget_IWindowModel_1.caption = _catalog.bundleDiscountEnabled ? _loc1_.toString() : _loc3_.toString();
         }
         if(UnknownVarFromTotalPriceWidget_IWindowModel_2 != null)
         {
            if(UnknownVarFromTotalPriceWidget_Int_3 > 0)
            {
               UnknownVarFromTotalPriceWidget_IWindowModel_2.caption = _catalog.bundleDiscountEnabled ? _loc5_.toString() : _loc6_.toString();
            }
            else
            {
               UnknownVarFromTotalPriceWidget_IWindowModel_2.caption = _catalog.bundleDiscountEnabled ? _loc2_.toString() : _loc7_.toString();
            }
         }
         if(UnknownVarFromTotalPriceWidget_IWindowController_1_1)
         {
            UnknownVarFromTotalPriceWidget_IWindowController_1_1.visible = _loc3_ != _loc1_;
            _loc4_ = UnknownVarFromTotalPriceWidget_IWindowController_1_1.findChildByName("text");
            _loc4_.caption = !!UnknownVarFromTotalPriceWidget_IWindowController_1_1.visible ? _loc3_.toString() : "0";
            UnknownVarFromTotalPriceWidget_IWindowController_1_1.findChildByName("strike").width = _loc4_.width;
         }
         if(UnknownVarFromTotalPriceWidget_IWindowController_1_2)
         {
            if(UnknownVarFromTotalPriceWidget_Int_3 > 0)
            {
               UnknownVarFromTotalPriceWidget_IWindowController_1_2.visible = _loc6_ != _loc5_;
               _loc8_ = UnknownVarFromTotalPriceWidget_IWindowController_1_2.findChildByName("text");
               _loc8_.caption = !!UnknownVarFromTotalPriceWidget_IWindowController_1_2.visible ? _loc6_.toString() : "0";
               UnknownVarFromTotalPriceWidget_IWindowController_1_2.findChildByName("strike").width = _loc8_.width;
            }
            else
            {
               UnknownVarFromTotalPriceWidget_IWindowController_1_2.visible = _loc7_ != _loc2_;
               _loc8_ = UnknownVarFromTotalPriceWidget_IWindowController_1_2.findChildByName("text");
               _loc8_.caption = !!UnknownVarFromTotalPriceWidget_IWindowController_1_2.visible ? _loc7_.toString() : "0";
               UnknownVarFromTotalPriceWidget_IWindowController_1_2.findChildByName("strike").width = _loc8_.width;
            }
         }
      }
      
      private function createCurrencyIndicators() : void
      {
         var _loc2_:IWindowModel = null;
         var _loc3_:IWindowModel = null;
         var _loc1_:IWindowModel = null;
         if(UnknownVarFromTotalPriceWidget_Int_1 > 0)
         {
            if(UnknownVarFromTotalPriceWidget_Int_2 > 0 || UnknownVarFromTotalPriceWidget_Int_3 > 0)
            {
               UnknownVarFromTotalPriceWidget_IWindowModel_1 = _window.findChildByName("amount_text_left");
               UnknownVarFromTotalPriceWidget_IWindowModel_1.visible = true;
               UnknownVarFromTotalPriceWidget_IWindowController_1_1 = _window.findChildByName("total_left") as IWindowController_1;
               if(UnknownVarFromTotalPriceWidget_IWindowController_1_1)
               {
                  UnknownVarFromTotalPriceWidget_IWindowController_1_1.visible = false;
               }
               _loc2_ = _window.findChildByName("currency_indicator_bitmap_left");
               _loc2_.visible = true;
               _window.findChildByName("plus").visible = true;
            }
            else
            {
               UnknownVarFromTotalPriceWidget_IWindowModel_1 = _window.findChildByName("amount_text_right");
               UnknownVarFromTotalPriceWidget_IWindowController_1_1 = _window.findChildByName("total_right") as IWindowController_1;
               if(UnknownVarFromTotalPriceWidget_IWindowController_1_1)
               {
                  UnknownVarFromTotalPriceWidget_IWindowController_1_1.visible = false;
               }
               _loc2_ = _window.findChildByName("currency_indicator_bitmap_right");
            }
            if(page.acceptSeasonCurrencyAsCredits)
            {
               _loc2_.style = ActivityPointTypeEnum.getIconStyleFor(_catalog.getSeasonalCurrencyActivityPointType(),_catalog,true,true);
               _loc2_.width = 53;
            }
            else
            {
               _loc2_.style = ActivityPointTypeEnum.getIconStyleFor(-1,_catalog,true);
               _loc2_.width = 22;
            }
         }
         if(UnknownVarFromTotalPriceWidget_Int_2 > 0)
         {
            UnknownVarFromTotalPriceWidget_IWindowModel_2 = ITextWindow(_window.findChildByName("amount_text_right"));
            UnknownVarFromTotalPriceWidget_IWindowController_1_2 = _window.findChildByName("total_left") as IWindowController_1;
            if(UnknownVarFromTotalPriceWidget_IWindowController_1_2)
            {
               UnknownVarFromTotalPriceWidget_IWindowController_1_2.visible = false;
            }
            _loc3_ = _window.findChildByName("currency_indicator_bitmap_right");
            _loc3_.style = ActivityPointTypeEnum.getIconStyleFor(UnknownVarFromTotalPriceWidget_Int_4,_catalog,true);
         }
         else if(UnknownVarFromTotalPriceWidget_Int_3 > 0)
         {
            UnknownVarFromTotalPriceWidget_IWindowModel_2 = ITextWindow(_window.findChildByName("amount_text_right"));
            UnknownVarFromTotalPriceWidget_IWindowController_1_2 = _window.findChildByName("total_left") as IWindowController_1;
            if(UnknownVarFromTotalPriceWidget_IWindowController_1_2)
            {
               UnknownVarFromTotalPriceWidget_IWindowController_1_2.visible = false;
            }
            _loc1_ = _window.findChildByName("currency_indicator_bitmap_right");
            _loc1_.style = ActivityPointTypeEnum.getIconStyleFor(1000,_catalog,true);
         }
         IItemListWindow(_window.findChildByName("totalprice_container")).arrangeListItems();
      }
   }
}

