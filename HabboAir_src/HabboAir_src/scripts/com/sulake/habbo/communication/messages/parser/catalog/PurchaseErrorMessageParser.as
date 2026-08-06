package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PurchaseErrorMessageParser implements IMessageParser
   {
      private var _errorCode:int = 0;
      
      public function PurchaseErrorMessageParser()
      {
         super();
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
      
      public function flush() : Boolean
      {
         _errorCode = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _errorCode = param1.readInteger();
         return true;
      }
   }
}

