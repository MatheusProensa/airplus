package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.HabboCatalogUtils;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ExtraInfoPromoItem extends UpdateableExtraInfoListItem
   {
      private static const UnknownConstFromExtraInfoPromoItem_String_1:String = "catalog.bundlewidget.discount.promo";
      
      private var _window:IWindowController_1 = null;
      
      private var UnknownVarFromExtraInfoPromoItem_Boolean_1:Boolean = true;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromExtraInfoPromoItem_Map_1:Map;
      
      private var UnknownVarFromExtraInfoPromoItem_Int_1:int = 0;
      
      private var UnknownVarFromExtraInfoPromoItem_BundlePurchaseExtraInfoWidget_1:BundlePurchaseExtraInfoWidget;
      
      private var UnknownVarFromExtraInfoPromoItem_Number_1:Number = 0;
      
      private var UnknownVarFromExtraInfoPromoItem_Timer_1:Timer;
      
      public function ExtraInfoPromoItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:HabboCatalog)
      {
         super(null,param2,param3,0);
         UnknownVarFromExtraInfoPromoItem_BundlePurchaseExtraInfoWidget_1 = param1;
         _catalog = param4;
         createNextDiscountMap();
         resolveNextDiscountLevel();
         UnknownVarFromExtraInfoPromoItem_Timer_1 = new Timer(50);
         UnknownVarFromExtraInfoPromoItem_Timer_1.addEventListener("timer",onEffectTimer);
         UnknownVarFromExtraInfoPromoItem_Timer_1.start();
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            UnknownVarFromExtraInfoPromoItem_Timer_1.stop();
            UnknownVarFromExtraInfoPromoItem_Timer_1.removeEventListener("timer",onEffectTimer);
            UnknownVarFromExtraInfoPromoItem_Timer_1 = null;
            UnknownVarFromExtraInfoPromoItem_Map_1 = null;
            _catalog = null;
            super.dispose();
         }
      }
      
      override public function update(param1:ExtraInfoItemData) : void
      {
         super.update(param1);
         var _loc2_:int = UnknownVarFromExtraInfoPromoItem_Int_1;
         resolveNextDiscountLevel();
         if(UnknownVarFromExtraInfoPromoItem_Int_1 != _loc2_)
         {
            UnknownVarFromExtraInfoPromoItem_Number_1 = 1;
         }
         UnknownVarFromExtraInfoPromoItem_Boolean_1 = true;
         render();
      }
      
      override public function getRenderedWindow() : IWindowController_1
      {
         if(_window == null)
         {
            createWindow();
         }
         if(UnknownVarFromExtraInfoPromoItem_Boolean_1)
         {
            render();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = IWindowController_1(_catalog.utils.createWindow("discountPromoItem"));
         _window.procedure = windowProcedure;
         var _loc1_:IBitmapWrapperController = IBitmapWrapperController(_window.findChildByName("icon_bitmap"));
         HabboCatalogUtils.replaceCenteredImage(_loc1_,BitmapData(_catalog.assets.getAssetByName("thumb_up").content).clone());
      }
      
      private function render() : void
      {
         _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo","quantity",UnknownVarFromExtraInfoPromoItem_Int_1.toString());
         _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo","discount",UnknownVarFromExtraInfoPromoItem_Map_1.getValue(UnknownVarFromExtraInfoPromoItem_Int_1));
         var _loc1_:String = _catalog.localization.getLocalizationRaw("catalog.bundlewidget.discount.promo").value;
         _window.findChildByName("promo_text").caption = _loc1_;
         _window.findChildByName("promo_text_effect").caption = _loc1_;
         UnknownVarFromExtraInfoPromoItem_Boolean_1 = false;
      }
      
      private function resolveNextDiscountLevel() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = UnknownVarFromExtraInfoPromoItem_Map_1.getKeys();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(int(_loc1_[_loc2_]) > data.quantity)
            {
               UnknownVarFromExtraInfoPromoItem_Int_1 = int(_loc1_[_loc2_]);
               break;
            }
            _loc2_++;
         }
      }
      
      private function createNextDiscountMap() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         UnknownVarFromExtraInfoPromoItem_Map_1 = new Map();
         _loc2_ = 1;
         _loc3_ = 0;
         while(_loc2_ <= 100)
         {
            _loc4_ = _catalog.utils.calculateBundlePrice(true,1,_loc2_);
            _loc1_ = _loc2_ - _loc4_;
            if(_loc1_ > _loc3_ && _catalog.utils.bundleDiscountFlatPriceSteps.indexOf(_loc2_) == -1)
            {
               UnknownVarFromExtraInfoPromoItem_Map_1.add(_loc2_,_loc1_);
               _loc3_ = _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function onEffectTimer(param1:TimerEvent) : void
      {
         if(UnknownVarFromExtraInfoPromoItem_Number_1 > 0)
         {
            UnknownVarFromExtraInfoPromoItem_Number_1 -= 0.1;
            if(UnknownVarFromExtraInfoPromoItem_Number_1 < 0)
            {
               UnknownVarFromExtraInfoPromoItem_Number_1 = 0;
            }
            _window.findChildByName("promo_text_effect").blend = UnknownVarFromExtraInfoPromoItem_Number_1;
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param2.name == "click_region")
         {
            switch(param1.type)
            {
               case "WME_CLICK":
                  UnknownVarFromExtraInfoPromoItem_BundlePurchaseExtraInfoWidget_1.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED",data,id));
                  break;
               case "WME_OVER":
                  ITextWindow(_window.findChildByName("promo_text")).textColor = 12582911;
                  break;
               case "WME_OUT":
                  ITextWindow(_window.findChildByName("promo_text")).textColor = 16777215;
            }
         }
      }
   }
}

