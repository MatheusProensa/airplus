package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class WiredValidationParameter
   {
      private var _key:String;
      
      private var _value:String;
      
      public function WiredValidationParameter(param1:IMessageDataWrapper)
      {
         super();
         _key = param1.readString();
         _value = param1.readString();
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get value() : String
      {
         return _value;
      }
   }
}

