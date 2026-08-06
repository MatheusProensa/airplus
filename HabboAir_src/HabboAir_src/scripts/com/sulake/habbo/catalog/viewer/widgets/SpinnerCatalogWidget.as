package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SpinnerCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private static const SPIN_BUTTONDOWN_HOLD_VALUE_STEP_DELAY_MS:int = 75;
      
      private static const UnknownConstFromSpinnerCatalogWidget_Int_1:int = 35;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromSpinnerCatalogWidget_Int_1:int = 1;
      
      private var UnknownVarFromSpinnerCatalogWidget_Int_2:int = 1;
      
      private var UnknownVarFromSpinnerCatalogWidget_Int_3:int = 100;
      
      private var UnknownVarFromSpinnerCatalogWidget_Timer_1:Timer;
      
      private var UnknownVarFromSpinnerCatalogWidget_Boolean_1:Boolean = false;
      
      private var UnknownVarFromSpinnerCatalogWidget_Boolean_2:Boolean = false;
      
      private var UnknownVarFromSpinnerCatalogWidget_Boolean_3:Boolean = false;
      
      private var UnknownVarFromSpinnerCatalogWidget_Int_4:int = 1;
      
      private var UnknownVarFromSpinnerCatalogWidget_Array_1:Array = new Array(0);
      
      private var _promoInfo:IWindowModel;
      
      public function SpinnerCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromSpinnerCatalogWidget_Timer_1 != null)
            {
               UnknownVarFromSpinnerCatalogWidget_Timer_1.stop();
               UnknownVarFromSpinnerCatalogWidget_Timer_1 = null;
            }
            events.removeEventListener("CWSE_RESET",onRequestResetEvent);
            events.removeEventListener("CWSE_SHOW",onShowEvent);
            events.removeEventListener("CWSE_HIDE",onHideEvent);
            events.removeEventListener("CWSE_SET_MAX",onSetMaxEvent);
            events.removeEventListener("CWSE_SET_MIN",onSetMinEvent);
            super.dispose();
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
         attachWidgetView("spinnerWidget");
         window.visible = false;
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         window.procedure = spinnerWindowProcedure;
         var _loc1_:ITextFieldWindow = window.findChildByName("text_value") as ITextFieldWindow;
         if(_loc1_)
         {
            _loc1_.addEventListener("WKE_KEY_UP",onInputEvent);
         }
         events.addEventListener("CWSE_RESET",onRequestResetEvent);
         events.addEventListener("CWSE_SHOW",onShowEvent);
         events.addEventListener("CWSE_HIDE",onHideEvent);
         events.addEventListener("CWSE_SET_MAX",onSetMaxEvent);
         events.addEventListener("CWSE_SET_MIN",onSetMinEvent);
         UnknownVarFromSpinnerCatalogWidget_Timer_1 = new Timer(75);
         UnknownVarFromSpinnerCatalogWidget_Timer_1.addEventListener("timer",onSpinnerTimerEvent);
         _promoInfo = window.findChildByName("promo.info");
         return true;
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         UnknownVarFromSpinnerCatalogWidget_Int_1 = Math.max(UnknownVarFromSpinnerCatalogWidget_Int_1,UnknownVarFromSpinnerCatalogWidget_Int_2);
         UnknownVarFromSpinnerCatalogWidget_Int_1 = Math.min(UnknownVarFromSpinnerCatalogWidget_Int_1,UnknownVarFromSpinnerCatalogWidget_Int_3);
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_VALUE_CHANGED",UnknownVarFromSpinnerCatalogWidget_Int_1));
         setValueText(UnknownVarFromSpinnerCatalogWidget_Int_1.toString());
         if(_promoInfo && _catalog.bundleDiscountEnabled)
         {
            _loc1_ = _catalog.utils.getDiscountItemsCount(UnknownVarFromSpinnerCatalogWidget_Int_1);
            window.findChildByName("discountContainer").visible = _loc1_ > 0;
            _catalog.localization.registerParameter("shop.bonus.items.count","amount",_loc1_.toString());
         }
      }
      
      private function onRequestResetEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         UnknownVarFromSpinnerCatalogWidget_Int_1 = param1.value;
         if(param1.skipSteps != null)
         {
            UnknownVarFromSpinnerCatalogWidget_Array_1 = param1.skipSteps;
         }
         refresh();
      }
      
      private function onShowEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         window.visible = true;
      }
      
      private function onHideEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         window.visible = false;
      }
      
      private function onSetMaxEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         UnknownVarFromSpinnerCatalogWidget_Int_3 = param1.value;
      }
      
      private function onSetMinEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         UnknownVarFromSpinnerCatalogWidget_Int_2 = param1.value;
      }
      
      private function onSpinnerTimerEvent(param1:TimerEvent) : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromSpinnerCatalogWidget_Boolean_3 = true;
         if(UnknownVarFromSpinnerCatalogWidget_Boolean_1)
         {
            increaseValue();
            if(UnknownVarFromSpinnerCatalogWidget_Int_1 - UnknownVarFromSpinnerCatalogWidget_Int_4 > 35)
            {
               increaseValue();
            }
         }
         if(UnknownVarFromSpinnerCatalogWidget_Boolean_2)
         {
            decreaseValue();
            if(UnknownVarFromSpinnerCatalogWidget_Int_4 - UnknownVarFromSpinnerCatalogWidget_Int_1 > 35)
            {
               decreaseValue();
            }
         }
         refresh();
      }
      
      private function increaseValue() : void
      {
         var _loc1_:int = UnknownVarFromSpinnerCatalogWidget_Int_1 + 1;
         while(UnknownVarFromSpinnerCatalogWidget_Array_1.indexOf(_loc1_) != -1)
         {
            _loc1_++;
         }
         UnknownVarFromSpinnerCatalogWidget_Int_1 = _loc1_;
      }
      
      private function decreaseValue() : void
      {
         var _loc1_:int = UnknownVarFromSpinnerCatalogWidget_Int_1 - 1;
         while(UnknownVarFromSpinnerCatalogWidget_Array_1.indexOf(_loc1_) != -1)
         {
            _loc1_--;
         }
         UnknownVarFromSpinnerCatalogWidget_Int_1 = _loc1_;
      }
      
      private function setValueText(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.findChildByName("text_value") is ITextFieldWindow)
         {
            if(_window.findChildByName("text_value").caption.length > 0)
            {
               _window.findChildByName("text_value").caption = param1;
            }
         }
         else
         {
            _window.findChildByName("text_value").caption = param1;
         }
      }
      
      private function spinnerWindowProcedure(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOWN" && param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "button_less":
               switch(param1.type)
               {
                  case "WME_DOWN":
                     UnknownVarFromSpinnerCatalogWidget_Boolean_2 = true;
                     UnknownVarFromSpinnerCatalogWidget_Int_4 = UnknownVarFromSpinnerCatalogWidget_Int_1;
                     UnknownVarFromSpinnerCatalogWidget_Timer_1.start();
                     break;
                  case "WME_UP":
                  case "WME_UP_OUTSIDE":
                     UnknownVarFromSpinnerCatalogWidget_Boolean_2 = false;
                     UnknownVarFromSpinnerCatalogWidget_Timer_1.stop();
                     break;
                  case "WME_CLICK":
                     if(!UnknownVarFromSpinnerCatalogWidget_Boolean_3)
                     {
                        decreaseValue();
                     }
                     refresh();
                     UnknownVarFromSpinnerCatalogWidget_Boolean_3 = false;
               }
               break;
            case "button_more":
               switch(param1.type)
               {
                  case "WME_DOWN":
                     UnknownVarFromSpinnerCatalogWidget_Boolean_1 = true;
                     UnknownVarFromSpinnerCatalogWidget_Int_4 = UnknownVarFromSpinnerCatalogWidget_Int_1;
                     UnknownVarFromSpinnerCatalogWidget_Timer_1.start();
                     break;
                  case "WME_UP":
                  case "WME_UP_OUTSIDE":
                     UnknownVarFromSpinnerCatalogWidget_Boolean_1 = false;
                     UnknownVarFromSpinnerCatalogWidget_Timer_1.stop();
                     break;
                  case "WME_CLICK":
                     if(!UnknownVarFromSpinnerCatalogWidget_Boolean_3)
                     {
                        increaseValue();
                     }
                     refresh();
                     UnknownVarFromSpinnerCatalogWidget_Boolean_3 = false;
               }
         }
      }
      
      private function onInputEvent(param1:WindowKeyboardEvent) : void
      {
         UnknownVarFromSpinnerCatalogWidget_Int_1 = parseInt(param1.target.caption);
         refresh();
      }
   }
}

