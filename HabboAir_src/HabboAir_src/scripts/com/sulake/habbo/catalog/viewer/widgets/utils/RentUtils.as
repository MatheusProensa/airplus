package com.sulake.habbo.catalog.viewer.widgets.utils
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   
   public class RentUtils
   {
      public function RentUtils()
      {
         super();
      }
      
      public static function updateBuyCaption(param1:UnknownIHabboCatalog1, param2:IWindowModel) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         param2.caption = param1.isRentOffer ? "${catalog.purchase_confirmation.rent}" : "${catalog.purchase_confirmation.buy}";
      }
   }
}

