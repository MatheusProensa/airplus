package com.sulake.habbo.communication.messages.incoming.perk
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.perk.CitizenshipVipOfferPromoEnabledMessageParser;
   
   [SecureSWF(rename="true")]
   public class CitizenshipVipOfferPromoEnabledEvent extends MessageEvent implements IMessageEvent
   {
      public function CitizenshipVipOfferPromoEnabledEvent(param1:Function)
      {
         super(param1,CitizenshipVipOfferPromoEnabledMessageParser);
      }
      
      public function getParser() : CitizenshipVipOfferPromoEnabledMessageParser
      {
         return _parser as CitizenshipVipOfferPromoEnabledMessageParser;
      }
   }
}

