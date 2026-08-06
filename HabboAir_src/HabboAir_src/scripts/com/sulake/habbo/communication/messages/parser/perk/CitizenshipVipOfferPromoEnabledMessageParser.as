package com.sulake.habbo.communication.messages.parser.perk
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CitizenshipVipOfferPromoEnabledMessageParser implements IMessageParser
   {
      public function CitizenshipVipOfferPromoEnabledMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         return true;
      }
   }
}

