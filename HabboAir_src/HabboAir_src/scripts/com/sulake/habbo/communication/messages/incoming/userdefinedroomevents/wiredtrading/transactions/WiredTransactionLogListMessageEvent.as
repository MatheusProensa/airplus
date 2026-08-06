package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionLogListMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionLogListMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTransactionLogListMessageEvent(param1:Function)
      {
         super(param1,WiredTransactionLogListMessageParser);
      }
      
      public function getParser() : WiredTransactionLogListMessageParser
      {
         return this._parser as WiredTransactionLogListMessageParser;
      }
   }
}

