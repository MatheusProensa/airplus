package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class SetExtraPurchaseParameterEvent extends Event
   {
      private var _parameter:String;
      
      public function SetExtraPurchaseParameterEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("CWE_SET_EXTRA_PARM",param2,param3);
         _parameter = param1;
      }
      
      public function get parameter() : String
      {
         return _parameter;
      }
   }
}

