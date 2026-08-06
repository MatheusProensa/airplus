package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTradeTransactionNotificationMessageParser implements IMessageParser
   {
      private var _tradeTransactionNotificationId:int;
      
      public function WiredTradeTransactionNotificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _tradeTransactionNotificationId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _tradeTransactionNotificationId = param1.readInteger();
         return true;
      }
      
      public function get tradeTransactionNotificationId() : int
      {
         return _tradeTransactionNotificationId;
      }
   }
}

