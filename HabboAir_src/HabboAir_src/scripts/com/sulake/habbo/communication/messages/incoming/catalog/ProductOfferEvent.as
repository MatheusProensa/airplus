package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.ProductOfferMessageParser;
   
   [SecureSWF(rename="true")]
   public class ProductOfferEvent extends MessageEvent implements IMessageEvent
   {
      public function ProductOfferEvent(param1:Function)
      {
         super(param1,ProductOfferMessageParser);
      }
      
      public function getParser() : ProductOfferMessageParser
      {
         return this._parser as ProductOfferMessageParser;
      }
   }
}

