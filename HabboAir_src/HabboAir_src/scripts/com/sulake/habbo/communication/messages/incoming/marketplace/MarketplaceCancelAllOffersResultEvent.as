package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelAllOffersResultParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceCancelAllOffersResultEvent extends MessageEvent implements IMessageEvent
   {
      public function MarketplaceCancelAllOffersResultEvent(param1:Function)
      {
         super(param1,MarketplaceCancelAllOffersResultParser);
      }
      
      public function getParser() : MarketplaceCancelAllOffersResultParser
      {
         return _parser as MarketplaceCancelAllOffersResultParser;
      }
   }
}

