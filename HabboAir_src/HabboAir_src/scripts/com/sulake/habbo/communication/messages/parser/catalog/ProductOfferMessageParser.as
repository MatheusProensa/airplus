package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   
   [SecureSWF(rename="true")]
   public class ProductOfferMessageParser implements IMessageParser
   {
      private var _offerData:CatalogPageMessageOfferData;
      
      public function ProductOfferMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offerData = new CatalogPageMessageOfferData(param1);
         return true;
      }
      
      public function get offerData() : CatalogPageMessageOfferData
      {
         return _offerData;
      }
   }
}

