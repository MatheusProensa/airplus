package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeSilverFeeParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverFeeMessageEvent extends MessageEvent
   {
      public function TradeSilverFeeMessageEvent(param1:Function)
      {
         super(param1,TradeSilverFeeParser);
      }
      
      public function getParser() : TradeSilverFeeParser
      {
         return _parser as TradeSilverFeeParser;
      }
   }
}

