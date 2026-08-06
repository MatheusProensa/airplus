package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.HabboCatalogUtils;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ExtraInfoDiscountValueItem extends UpdateableExtraInfoListItem
   {
      private static const ELEMENT_SPLASH_STAR:String = "icon_splash_bitmap";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_1:String = "icon_bitmap";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_2:String = "total_currency_value_left";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_3:String = "total_currency_icon_left";
      
      private static const ELEMENT_TOTAL_LEFT_CURRENCY_STRIKETHROUGH:String = "striketrough_total_currency_left";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_4:String = "total_currency_value_right";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_5:String = "total_currency_icon_right";
      
      private static const ELEMENT_TOTAL_RIGHT_CURRENCY_STRIKETHROUGH:String = "striketrough_total_currency_right";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_6:String = "discount_currency_value_left";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_7:String = "discount_currency_icon_left";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_8:String = "discount_currency_value_right";
      
      private static const UnknownConstFromExtraInfoDiscountValueItem_String_9:String = "discount_currency_icon_right";
      
      private static const STRIKETHROUGH_LEFT_MARGIN:int = 4;
      
      private static const STRIKETHROUGH_RIGHT_MARGIN:int = 20;
      
      private var _window:IWindowController_1 = null;
      
      private var UnknownVarFromExtraInfoDiscountValueItem_Boolean_1:Boolean = true;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromExtraInfoDiscountValueItem_Int_1:int = 0;
      
      private var UnknownVarFromExtraInfoDiscountValueItem_Timer_1:Timer;
      
      private var UnknownVarFromExtraInfoDiscountValueItem_Boolean_2:Boolean;
      
      private var UnknownVarFromExtraInfoDiscountValueItem_Boolean_3:Boolean;
      
      private var UnknownVarFromExtraInfoDiscountValueItem_Boolean_4:Boolean;
      
      private var UnknownVarFromExtraInfoDiscountValueItem_Boolean_5:Boolean = false;
      
      public function ExtraInfoDiscountValueItem(param1:int, param2:ExtraInfoItemData, param3:HabboCatalog)
      {
         super(null,param1,param2,1,true);
         _catalog = param3;
         UnknownVarFromExtraInfoDiscountValueItem_Timer_1 = new Timer(150);
         UnknownVarFromExtraInfoDiscountValueItem_Timer_1.addEventListener("timer",starAnimationTimerEvent);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromExtraInfoDiscountValueItem_Timer_1 != null)
            {
               UnknownVarFromExtraInfoDiscountValueItem_Timer_1.stop();
               UnknownVarFromExtraInfoDiscountValueItem_Timer_1 = null;
            }
            _catalog = null;
            super.dispose();
         }
      }
      
      override public function update(param1:ExtraInfoItemData) : void
      {
         super.update(param1);
         UnknownVarFromExtraInfoDiscountValueItem_Boolean_2 = false;
         UnknownVarFromExtraInfoDiscountValueItem_Boolean_3 = false;
         UnknownVarFromExtraInfoDiscountValueItem_Boolean_4 = false;
         if(param1.priceCredits > 0 && param1.priceActivityPoints > 0)
         {
            UnknownVarFromExtraInfoDiscountValueItem_Boolean_2 = true;
         }
         else if(param1.priceActivityPoints > 0 && param1.priceCredits == 0)
         {
            UnknownVarFromExtraInfoDiscountValueItem_Boolean_4 = true;
         }
         else
         {
            UnknownVarFromExtraInfoDiscountValueItem_Boolean_3 = true;
         }
         UnknownVarFromExtraInfoDiscountValueItem_Boolean_1 = true;
         render();
         if(!UnknownVarFromExtraInfoDiscountValueItem_Boolean_5)
         {
            setCurrencyIcons();
         }
      }
      
      override public function getRenderedWindow() : IWindowController_1
      {
         if(UnknownVarFromExtraInfoDiscountValueItem_Boolean_1)
         {
            render();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = IWindowController_1(_catalog.utils.createWindow("discountValueItem"));
         setElementBitmap("icon_bitmap","thumb_up");
         startSplashAnimation();
      }
      
      private function render() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         updateColumns();
         updatePriceIndicators();
         updateStrikeThroughElements();
         UnknownVarFromExtraInfoDiscountValueItem_Boolean_1 = false;
      }
      
      private function updateColumns() : void
      {
         if(UnknownVarFromExtraInfoDiscountValueItem_Boolean_4 || UnknownVarFromExtraInfoDiscountValueItem_Boolean_3)
         {
            setLeftColumnVisibility(false);
         }
         else
         {
            setLeftColumnVisibility(true);
         }
      }
      
      private function setCurrencyIcons() : void
      {
         if(UnknownVarFromExtraInfoDiscountValueItem_Boolean_2)
         {
            setIconStyle("total_currency_icon_left",-1);
            setIconStyle("discount_currency_icon_left",-1);
         }
         if(UnknownVarFromExtraInfoDiscountValueItem_Boolean_3)
         {
            setIconStyle("total_currency_icon_right",-1);
            setIconStyle("discount_currency_icon_right",-1);
         }
         else
         {
            setIconStyle("total_currency_icon_right",data.activityPointType);
            setIconStyle("discount_currency_icon_right",data.activityPointType);
         }
         UnknownVarFromExtraInfoDiscountValueItem_Boolean_5 = true;
      }
      
      private function updatePriceIndicators() : void
      {
         if(UnknownVarFromExtraInfoDiscountValueItem_Boolean_2)
         {
            setElementText("total_currency_value_left",(data.quantity * data.priceCredits).toString());
            setElementText("discount_currency_value_left",(data.quantity * data.priceCredits - data.discountPriceCredits).toString());
         }
         if(UnknownVarFromExtraInfoDiscountValueItem_Boolean_3)
         {
            setElementText("total_currency_value_right",(data.quantity * data.priceCredits).toString());
            setElementText("discount_currency_value_right",(data.quantity * data.priceCredits - data.discountPriceCredits).toString());
         }
         else
         {
            setElementText("total_currency_value_right",(data.quantity * data.priceActivityPoints).toString());
            setElementText("discount_currency_value_right",(data.quantity * data.priceActivityPoints - data.discountPriceActivityPoints).toString());
         }
      }
      
      private function updateStrikeThroughElements() : void
      {
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("total_currency_value_left"));
         var _loc2_:int = _loc4_.x + _loc4_.width - _loc4_.textWidth;
         var _loc5_:IWindowController_1 = IWindowController_1(_window.findChildByName("striketrough_total_currency_left"));
         _loc5_.x = _loc2_ - 4;
         _loc5_.width = 4 + _loc4_.textWidth + 20;
         var _loc1_:ITextWindow = ITextWindow(_window.findChildByName("total_currency_value_right"));
         var _loc3_:int = _loc1_.x + _loc1_.width - _loc1_.textWidth;
         var _loc6_:IWindowController_1 = IWindowController_1(_window.findChildByName("striketrough_total_currency_right"));
         _loc6_.x = _loc3_ - 4;
         _loc6_.width = 4 + _loc1_.textWidth + 20;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         _window.findChildByName(param1).caption = param2;
      }
      
      private function setElementBitmap(param1:String, param2:String) : void
      {
         var _loc4_:IBitmapWrapperController = IBitmapWrapperController(_window.findChildByName(param1));
         var _loc3_:BitmapData = BitmapData(_catalog.assets.getAssetByName(param2).content);
         HabboCatalogUtils.replaceCenteredImage(_loc4_,_loc3_);
      }
      
      private function setIconStyle(param1:String, param2:int) : void
      {
         var _loc3_:IWindowModel = _window.findChildByName(param1);
         _loc3_.style = ActivityPointTypeEnum.getIconStyleFor(param2,_catalog,false);
      }
      
      private function setLeftColumnVisibility(param1:Boolean) : void
      {
         var _loc2_:Array = ["discount_currency_icon_left","discount_currency_value_left","total_currency_icon_left","striketrough_total_currency_left","total_currency_value_left"];
         for each(var _loc3_ in _loc2_)
         {
            _window.findChildByName(_loc3_).visible = param1;
         }
      }
      
      private function startSplashAnimation() : void
      {
         var _loc1_:IBitmapWrapperController = IBitmapWrapperController(_window.findChildByName("icon_splash_bitmap"));
         _loc1_.bitmap = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         starAnimationTimerEvent(new TimerEvent("timer"));
         UnknownVarFromExtraInfoDiscountValueItem_Timer_1.start();
      }
      
      private function starAnimationTimerEvent(param1:TimerEvent) : void
      {
         var _loc2_:IBitmapWrapperController = null;
         var _loc3_:ISoundAsset = null;
         if(_window != null)
         {
            _loc2_ = IBitmapWrapperController(_window.findChildByName("icon_splash_bitmap"));
            _loc3_ = _catalog.assets.getAssetByName("bundle_discount_star_" + UnknownVarFromExtraInfoDiscountValueItem_Int_1);
            HabboCatalogUtils.replaceCenteredImage(_loc2_,BitmapData(_loc3_.content),BitmapDataAsset(_loc3_).rectangle);
            if(++UnknownVarFromExtraInfoDiscountValueItem_Int_1 > 7)
            {
               UnknownVarFromExtraInfoDiscountValueItem_Int_1 = 0;
            }
         }
      }
   }
}

