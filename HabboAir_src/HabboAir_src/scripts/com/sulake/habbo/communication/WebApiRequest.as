package com.sulake.habbo.communication
{
   public class WebApiRequest extends ApiRequest
   {
      private var _requiresSession:Boolean;
      
      public function WebApiRequest(param1:String, param2:String, param3:Boolean = true)
      {
         _requiresSession = param3;
         super(param2,param1);
      }
      
      public function get requiresSession() : Boolean
      {
         return _requiresSession;
      }
   }
}

