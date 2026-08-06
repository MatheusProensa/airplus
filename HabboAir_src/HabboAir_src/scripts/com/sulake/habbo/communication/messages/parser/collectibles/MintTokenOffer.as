package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class MintTokenOffer
   {
      private var _offerId:int;
      
      private var _productCode:String;
      
      private var _silverPrice:int;
      
      private var _amountTokens:int;
      
      public function MintTokenOffer(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         _productCode = param1.readString();
         _silverPrice = param1.readInteger();
         _amountTokens = param1.readInteger();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get silverPrice() : int
      {
         return _silverPrice;
      }
      
      public function get amountTokens() : int
      {
         return _amountTokens;
      }
   }
}

