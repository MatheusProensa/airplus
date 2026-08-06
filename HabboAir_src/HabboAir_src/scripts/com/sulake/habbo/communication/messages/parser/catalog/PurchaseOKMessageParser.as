package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageOfferData;
   
   [SecureSWF(rename="true")]
   public class PurchaseOKMessageParser implements IMessageParser
   {
      private var _offer:PurchaseOKMessageOfferData;
      
      public function PurchaseOKMessageParser()
      {
         super();
      }
      
      public function get offer() : PurchaseOKMessageOfferData
      {
         return _offer;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offer = new PurchaseOKMessageOfferData(param1);
         return true;
      }
   }
}

