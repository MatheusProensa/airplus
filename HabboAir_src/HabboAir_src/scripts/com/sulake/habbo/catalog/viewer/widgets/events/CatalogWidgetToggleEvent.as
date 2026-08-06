package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetToggleEvent extends Event
   {
      private var _widgetId:String;
      
      private var _enabled:Boolean;
      
      public function CatalogWidgetToggleEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false)
      {
         super("CWE_TOGGLE",param3,param4);
         _widgetId = param1;
         _enabled = param2;
      }
      
      public function get widgetId() : String
      {
         return _widgetId;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
   }
}

