package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.WiredTradeInitiateMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTradeInitiateMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTradeInitiateMessageEvent(param1:Function)
      {
         super(param1,WiredTradeInitiateMessageParser);
      }
      
      public function getParser() : WiredTradeInitiateMessageParser
      {
         return this._parser as WiredTradeInitiateMessageParser;
      }
   }
}

