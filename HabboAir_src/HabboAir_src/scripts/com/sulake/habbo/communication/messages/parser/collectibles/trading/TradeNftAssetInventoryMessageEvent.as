package com.sulake.habbo.communication.messages.parser.collectibles.trading
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class TradeNftAssetInventoryMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function TradeNftAssetInventoryMessageEvent(param1:Function)
      {
         super(param1,TradeNftAssetInventoryMessageParser);
      }
      
      public function getParser() : TradeNftAssetInventoryMessageParser
      {
         return _parser as TradeNftAssetInventoryMessageParser;
      }
   }
}

