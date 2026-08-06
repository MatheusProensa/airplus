package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.FurniRentOrBuyoutOfferMessageParser;
   
   [SecureSWF(rename="true")]
   public class FurniRentOrBuyoutOfferMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function FurniRentOrBuyoutOfferMessageEvent(param1:Function)
      {
         super(param1,FurniRentOrBuyoutOfferMessageParser);
      }
      
      public function getParser() : FurniRentOrBuyoutOfferMessageParser
      {
         return _parser as FurniRentOrBuyoutOfferMessageParser;
      }
   }
}

