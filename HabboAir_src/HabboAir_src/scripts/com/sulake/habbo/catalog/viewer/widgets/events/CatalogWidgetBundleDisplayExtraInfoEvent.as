package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import flash.events.Event;
   
   public class CatalogWidgetBundleDisplayExtraInfoEvent extends Event
   {
      public static const RESET:String = "CWPPEIE_RESET";
      
      public static const HIDE:String = "CWPPEIE_HIDE";
      
      public static const ITEM_CLICKED:String = "CWPPEIE_ITEM_CLICKED";
      
      private var _id:int;
      
      private var _data:ExtraInfoItemData;
      
      public function CatalogWidgetBundleDisplayExtraInfoEvent(param1:String, param2:ExtraInfoItemData = null, param3:int = -1)
      {
         super(param1);
         _id = param3;
         _data = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get data() : ExtraInfoItemData
      {
         return _data;
      }
   }
}

