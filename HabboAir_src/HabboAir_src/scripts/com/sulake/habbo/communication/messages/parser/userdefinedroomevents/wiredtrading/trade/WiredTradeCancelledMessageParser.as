package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTradeCancelledMessageParser implements IMessageParser
   {
      private var _transactionFailureTypeId:int;
      
      public function WiredTradeCancelledMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _transactionFailureTypeId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _transactionFailureTypeId = param1.readInteger();
         return true;
      }
      
      public function get transactionFailureTypeId() : int
      {
         return _transactionFailureTypeId;
      }
   }
}

