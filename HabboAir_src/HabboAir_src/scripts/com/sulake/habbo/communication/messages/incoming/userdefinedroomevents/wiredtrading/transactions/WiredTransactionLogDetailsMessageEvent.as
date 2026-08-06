package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionLogDetailsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionLogDetailsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTransactionLogDetailsMessageEvent(param1:Function)
      {
         super(param1,WiredTransactionLogDetailsMessageParser);
      }
      
      public function getParser() : WiredTransactionLogDetailsMessageParser
      {
         return this._parser as WiredTransactionLogDetailsMessageParser;
      }
   }
}

