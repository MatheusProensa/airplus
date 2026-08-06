package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionLogDetailsMessageParser implements IMessageParser
   {
      private var _details:WiredTransactionDetails;
      
      public function WiredTransactionLogDetailsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _details = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _details = new WiredTransactionDetails(param1);
         return true;
      }
      
      public function get details() : WiredTransactionDetails
      {
         return _details;
      }
   }
}

