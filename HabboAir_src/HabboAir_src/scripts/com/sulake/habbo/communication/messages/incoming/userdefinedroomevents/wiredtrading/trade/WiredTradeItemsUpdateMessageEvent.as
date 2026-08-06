package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.WiredTradeItemsUpdateMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredTradeItemsUpdateMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredTradeItemsUpdateMessageEvent(param1:Function)
      {
         super(param1,WiredTradeItemsUpdateMessageParser);
      }
      
      public function getParser() : WiredTradeItemsUpdateMessageParser
      {
         return this._parser as WiredTradeItemsUpdateMessageParser;
      }
   }
}

