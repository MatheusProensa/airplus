package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetSpinnerEvent extends Event
   {
      public static const VALUE_CHANGED:String = "CWSE_VALUE_CHANGED";
      
      public static const RESET:String = "CWSE_RESET";
      
      public static const SHOW:String = "CWSE_SHOW";
      
      public static const HIDE:String = "CWSE_HIDE";
      
      public static const UnknownConstFromCatalogWidgetSpinnerEvent_String_1:String = "CWSE_SET_MAX";
      
      public static const SET_MIN:String = "CWSE_SET_MIN";
      
      private var _value:int;
      
      private var _skipSteps:Array;
      
      public function CatalogWidgetSpinnerEvent(param1:String, param2:int = 1, param3:Array = null)
      {
         super(param1);
         _value = param2;
         _skipSteps = param3;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get skipSteps() : Array
      {
         return _skipSteps;
      }
   }
}

