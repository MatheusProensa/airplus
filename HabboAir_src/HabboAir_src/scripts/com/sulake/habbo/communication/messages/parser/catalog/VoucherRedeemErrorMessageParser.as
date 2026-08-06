package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class VoucherRedeemErrorMessageParser implements IMessageParser
   {
      private var _errorCode:String = "";
      
      public function VoucherRedeemErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _errorCode = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _errorCode = param1.readString();
         return true;
      }
      
      public function get errorCode() : String
      {
         return _errorCode;
      }
   }
}

