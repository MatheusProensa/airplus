package com.sulake.core.runtime.events
{
   public class ErrorEvent extends WarningEvent
   {
      protected var _category:int;
      
      protected var _critical:Boolean;
      
      protected var _error:Error;
      
      public function ErrorEvent(param1:String, param2:String, param3:Boolean, param4:int, param5:Error = null)
      {
         _critical = param3;
         _category = param4;
         _error = param5;
         super(param1,param2);
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get critical() : Boolean
      {
         return _critical;
      }
      
      public function get error() : Error
      {
         return _error;
      }
   }
}

