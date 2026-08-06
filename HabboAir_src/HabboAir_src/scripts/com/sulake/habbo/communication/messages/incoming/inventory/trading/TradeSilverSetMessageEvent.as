package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeSilverSetParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverSetMessageEvent extends MessageEvent
   {
      public function TradeSilverSetMessageEvent(param1:Function)
      {
         super(param1,TradeSilverSetParser);
      }
      
      public function getParser() : TradeSilverSetParser
      {
         return _parser as TradeSilverSetParser;
      }
   }
}

