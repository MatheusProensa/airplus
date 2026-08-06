package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetSellablePetPalettesEvent extends Event
   {
      private var _productCode:String;
      
      private var _sellablePalettes:Array;
      
      public function CatalogWidgetSellablePetPalettesEvent(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super("SELLABLE_PET_PALETTES",param3,param4);
         _productCode = param1;
         _sellablePalettes = param2;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get sellablePalettes() : Array
      {
         if(_sellablePalettes != null)
         {
            return _sellablePalettes.slice();
         }
         return [];
      }
   }
}

