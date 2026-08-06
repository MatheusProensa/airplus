package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionFailMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionFailMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTransactionFailMessageEvent(param1:Function)
      {
         super(param1,WiredTransactionFailMessageParser);
      }
      
      public function getParser() : WiredTransactionFailMessageParser
      {
         return this._parser as WiredTransactionFailMessageParser;
      }
   }
}

