package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionLogListMessageParser implements IMessageParser
   {
      private var _logs:WiredTransactionLogList;
      
      public function WiredTransactionLogListMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _logs = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _logs = new WiredTransactionLogList(param1);
         return true;
      }
      
      public function get logs() : WiredTransactionLogList
      {
         return _logs;
      }
   }
}

