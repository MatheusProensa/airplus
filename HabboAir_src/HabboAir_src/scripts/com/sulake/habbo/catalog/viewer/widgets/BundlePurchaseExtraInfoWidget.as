package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoViewManager;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BundlePurchaseExtraInfoWidget extends CatalogWidget implements ICatalogWidget
   {
      private static const PROMO_ITEM_DROP_DELAY_MS:uint = 4000;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1:ExtraInfoViewManager;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Int_1:int = 1;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Int_2:int;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Int_3:int;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Int_4:int;
      
      private var _itemBadgeCode:String;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5:int = -1;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6:int = -1;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Int_7:int = -1;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Boolean_1:Boolean = false;
      
      private var UnknownVarFromBundlePurchaseExtraInfoWidget_Timer_1:Timer;
      
      public function BundlePurchaseExtraInfoWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.dispose();
            UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1 = null;
            _catalog = null;
            UnknownVarFromBundlePurchaseExtraInfoWidget_Timer_1.stop();
            UnknownVarFromBundlePurchaseExtraInfoWidget_Timer_1.removeEventListener("timerComplete",onPromoItemDropDownTimerEvent);
            UnknownVarFromBundlePurchaseExtraInfoWidget_Timer_1 = null;
            events.removeEventListener("CWPPEIE_RESET",onResetEvent);
            events.removeEventListener("CWPPEIE_HIDE",onHideEvent);
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
            events.removeEventListener("CWPPEIE_ITEM_CLICKED",onExtraInfoItemClickedEvent);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(page.isBuilderPage)
         {
            _window.visible = false;
            return true;
         }
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1 = new ExtraInfoViewManager(this,_catalog);
         events.addEventListener("CWPPEIE_RESET",onResetEvent);
         events.addEventListener("CWPPEIE_HIDE",onHideEvent);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
         events.addEventListener("CWPPEIE_ITEM_CLICKED",onExtraInfoItemClickedEvent);
         UnknownVarFromBundlePurchaseExtraInfoWidget_Timer_1 = new Timer(4000,1);
         UnknownVarFromBundlePurchaseExtraInfoWidget_Timer_1.addEventListener("timerComplete",onPromoItemDropDownTimerEvent);
         return true;
      }
      
      private function createPromoItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(0);
         _loc1_.quantity = UnknownVarFromBundlePurchaseExtraInfoWidget_Int_1;
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5 = UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.addItem(_loc1_);
      }
      
      private function updatePromoItem(param1:int) : void
      {
         var _loc3_:UpdateableExtraInfoListItem = null;
         var _loc2_:ExtraInfoItemData = null;
         if(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5 != -1)
         {
            _loc3_ = UpdateableExtraInfoListItem(UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.getItem(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5));
            _loc2_ = _loc3_.data;
            _loc2_.quantity = param1;
            _loc3_.update(_loc2_);
         }
      }
      
      private function removePromoItem() : void
      {
         if(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5 != -1)
         {
            UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.removeItem(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5);
            UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5 = -1;
         }
      }
      
      private function createDiscountValueItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(2);
         _loc1_.quantity = UnknownVarFromBundlePurchaseExtraInfoWidget_Int_1;
         _loc1_.priceActivityPoints = UnknownVarFromBundlePurchaseExtraInfoWidget_Int_3;
         _loc1_.activityPointType = UnknownVarFromBundlePurchaseExtraInfoWidget_Int_4;
         _loc1_.priceCredits = UnknownVarFromBundlePurchaseExtraInfoWidget_Int_2;
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6 = UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.addItem(_loc1_);
         _catalog.utils.discountShownEventTrack();
      }
      
      private function updateDiscountValueItem(param1:int) : void
      {
         var _loc2_:UpdateableExtraInfoListItem = null;
         var _loc3_:ExtraInfoItemData = null;
         if(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6 != -1)
         {
            _loc2_ = UpdateableExtraInfoListItem(UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.getItem(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6));
            _loc3_ = _loc2_.data;
            _loc3_.quantity = param1;
            _loc3_.discountPriceCredits = _catalog.utils.calculateBundlePrice(true,UnknownVarFromBundlePurchaseExtraInfoWidget_Int_2,param1);
            _loc3_.discountPriceActivityPoints = _catalog.utils.calculateBundlePrice(true,UnknownVarFromBundlePurchaseExtraInfoWidget_Int_3,param1);
            _loc2_.update(_loc3_);
         }
      }
      
      private function removeDiscountValueItem() : void
      {
         if(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6 != -1)
         {
            UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.removeItem(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6);
            UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6 = -1;
         }
      }
      
      private function createBundleInfoItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(1);
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_7 = UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.addItem(_loc1_);
         _catalog.utils.bundlesInfoShownEventTrack();
      }
      
      private function removeBundleInfoItem() : void
      {
         if(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_7 != -1)
         {
            UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.removeItem(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_7);
            UnknownVarFromBundlePurchaseExtraInfoWidget_Int_7 = -1;
         }
      }
      
      private function onResetEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         if(disposed)
         {
            return;
         }
         window.visible = true;
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_2 = param1.data.priceCredits;
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_3 = param1.data.priceActivityPoints;
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_4 = param1.data.activityPointType;
         _itemBadgeCode = param1.data.badgeCode;
         UnknownVarFromBundlePurchaseExtraInfoWidget_ExtraInfoViewManager_1.clear();
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6 = -1;
         UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5 = -1;
         UnknownVarFromBundlePurchaseExtraInfoWidget_Timer_1.start();
      }
      
      private function onSpinnerEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_catalog.bundleDiscountEnabled)
         {
            return;
         }
         if(param1.type == "CWSE_VALUE_CHANGED")
         {
            if(param1.value != UnknownVarFromBundlePurchaseExtraInfoWidget_Int_1)
            {
               if(param1.value >= _catalog.bundleDiscountRuleset.bundleSize && UnknownVarFromBundlePurchaseExtraInfoWidget_Int_6 == -1)
               {
                  createDiscountValueItem();
               }
               else if(param1.value < _catalog.bundleDiscountRuleset.bundleSize)
               {
                  removeDiscountValueItem();
               }
               updatePromoItem(param1.value);
               updateDiscountValueItem(param1.value);
               UnknownVarFromBundlePurchaseExtraInfoWidget_Int_1 = param1.value;
               removeBundleInfoItem();
               if(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_1 >= _catalog.utils.bundleDiscountHighestFlatPriceStep)
               {
                  removePromoItem();
                  UnknownVarFromBundlePurchaseExtraInfoWidget_Boolean_1 = true;
               }
               else if(UnknownVarFromBundlePurchaseExtraInfoWidget_Boolean_1)
               {
                  createPromoItem();
                  UnknownVarFromBundlePurchaseExtraInfoWidget_Boolean_1 = false;
               }
               _catalog.utils.spinnerValueChangedEventTrack();
            }
         }
      }
      
      private function onHideEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         window.visible = false;
      }
      
      private function onExtraInfoItemClickedEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         switch(param1.id)
         {
            case UnknownVarFromBundlePurchaseExtraInfoWidget_Int_5:
               if(UnknownVarFromBundlePurchaseExtraInfoWidget_Int_7 == -1)
               {
                  createBundleInfoItem();
               }
               break;
            case UnknownVarFromBundlePurchaseExtraInfoWidget_Int_7:
               removeBundleInfoItem();
         }
      }
      
      private function onPromoItemDropDownTimerEvent(param1:TimerEvent) : void
      {
         createPromoItem();
      }
   }
}

