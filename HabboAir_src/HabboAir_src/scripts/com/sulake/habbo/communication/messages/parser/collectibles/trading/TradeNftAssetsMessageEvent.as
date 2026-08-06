package com.sulake.habbo.communication.messages.parser.collectibles.trading
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TradeNftAssetsMessageEvent(param1:Function)
      {
         super(param1,TradeNftAssetsMessageParser);
      }
      
      public function getParser() : TradeNftAssetsMessageParser
      {
         return _parser as TradeNftAssetsMessageParser;
      }
   }
}

