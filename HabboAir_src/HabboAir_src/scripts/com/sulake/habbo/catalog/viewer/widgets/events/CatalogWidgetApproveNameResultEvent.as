package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetApproveNameResultEvent extends Event
   {
      private var _result:int;
      
      private var _nameValidationInfo:String;
      
      public function CatalogWidgetApproveNameResultEvent(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super("CWE_APPROVE_RESULT",param3,param4);
         _result = param1;
         _nameValidationInfo = param2;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function get nameValidationInfo() : String
      {
         return _nameValidationInfo;
      }
   }
}

