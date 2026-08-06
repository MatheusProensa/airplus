package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import flash.events.Event;
   
   public class SelectProductEvent extends Event
   {
      private var _offer:UnknownIHabboCatalog1;
      
      public function SelectProductEvent(param1:UnknownIHabboCatalog1, param2:Boolean = false, param3:Boolean = false)
      {
         super("SELECT_PRODUCT",param2,param3);
         _offer = param1;
      }
      
      public function get offer() : UnknownIHabboCatalog1
      {
         return _offer;
      }
   }
}

