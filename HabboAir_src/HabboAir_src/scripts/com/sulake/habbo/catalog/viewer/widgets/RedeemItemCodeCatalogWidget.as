package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   
   public class RedeemItemCodeCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var UnknownVarFromRedeemItemCodeCatalogWidget_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromRedeemItemCodeCatalogWidget_ITextFieldWindow_1:ITextFieldWindow;
      
      public function RedeemItemCodeCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(UnknownVarFromRedeemItemCodeCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            UnknownVarFromRedeemItemCodeCatalogWidget_UnknownICoreWindowComponents4_1.removeEventListener("WME_CLICK",onRedeem);
            UnknownVarFromRedeemItemCodeCatalogWidget_UnknownICoreWindowComponents4_1 = null;
         }
         if(UnknownVarFromRedeemItemCodeCatalogWidget_ITextFieldWindow_1 != null)
         {
            UnknownVarFromRedeemItemCodeCatalogWidget_ITextFieldWindow_1.removeEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
            UnknownVarFromRedeemItemCodeCatalogWidget_ITextFieldWindow_1 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         UnknownVarFromRedeemItemCodeCatalogWidget_UnknownICoreWindowComponents4_1 = _window.findChildByName("redeem") as UnknownICoreWindowComponents4;
         if(UnknownVarFromRedeemItemCodeCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            UnknownVarFromRedeemItemCodeCatalogWidget_UnknownICoreWindowComponents4_1.addEventListener("WME_CLICK",onRedeem);
         }
         UnknownVarFromRedeemItemCodeCatalogWidget_ITextFieldWindow_1 = _window.findChildByName("voucher_code") as ITextFieldWindow;
         if(UnknownVarFromRedeemItemCodeCatalogWidget_ITextFieldWindow_1 != null)
         {
            UnknownVarFromRedeemItemCodeCatalogWidget_ITextFieldWindow_1.addEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
         }
         return true;
      }
      
      private function onRedeem(param1:WindowMouseEvent) : void
      {
         redeem();
      }
      
      private function windowKeyEventProcessor(param1:WindowEvent = null, param2:IWindowModel = null) : void
      {
         var _loc3_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc3_.charCode == 13)
         {
            redeem();
         }
      }
      
      private function redeem() : void
      {
         var voucher:String;
         var input:IWindowModel = _window.findChildByName("voucher_code");
         if(input != null)
         {
            voucher = input.caption;
            if(voucher.length > 0)
            {
               page.viewer.catalog.redeemVoucher(voucher);
               input.caption = "";
            }
            else
            {
               page.viewer.catalog.windowManager.alert("${catalog.voucher.empty.title}","${catalog.voucher.empty.desc}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
               {
                  param1.dispose();
               });
            }
         }
      }
   }
}

