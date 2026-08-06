package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.WiredTradeCancelledMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTradeCancelledMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTradeCancelledMessageEvent(param1:Function)
      {
         super(param1,WiredTradeCancelledMessageParser);
      }
      
      public function getParser() : WiredTradeCancelledMessageParser
      {
         return this._parser as WiredTradeCancelledMessageParser;
      }
   }
}

