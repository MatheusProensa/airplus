package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.WiredTradeTransactionNotificationMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTradeTransactionNotificationMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTradeTransactionNotificationMessageEvent(param1:Function)
      {
         super(param1,WiredTradeTransactionNotificationMessageParser);
      }
      
      public function getParser() : WiredTradeTransactionNotificationMessageParser
      {
         return this._parser as WiredTradeTransactionNotificationMessageParser;
      }
   }
}

