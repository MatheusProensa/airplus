package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionSuccessMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionSuccessMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTransactionSuccessMessageEvent(param1:Function)
      {
         super(param1,WiredTransactionSuccessMessageParser);
      }
      
      public function getParser() : WiredTransactionSuccessMessageParser
      {
         return this._parser as WiredTransactionSuccessMessageParser;
      }
   }
}

