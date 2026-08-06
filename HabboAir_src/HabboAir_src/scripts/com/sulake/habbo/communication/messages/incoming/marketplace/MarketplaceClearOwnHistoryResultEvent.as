package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceClearOwnHistoryResultParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceClearOwnHistoryResultEvent extends MessageEvent implements IMessageEvent
   {
      public function MarketplaceClearOwnHistoryResultEvent(param1:Function)
      {
         super(param1,MarketplaceClearOwnHistoryResultParser);
      }
      
      public function getParser() : MarketplaceClearOwnHistoryResultParser
      {
         return _parser as MarketplaceClearOwnHistoryResultParser;
      }
   }
}

