package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BonusRareInfoMessageParser implements IMessageParser
   {
      private var _productType:String;
      
      private var _productClassId:int;
      
      private var _totalCoinsForBonus:int;
      
      private var _coinsStillRequiredToBuy:int;
      
      public function BonusRareInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _totalCoinsForBonus = -1;
         _coinsStillRequiredToBuy = -1;
         _productType = "";
         _productClassId = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _productType = param1.readString();
         _productClassId = param1.readInteger();
         _totalCoinsForBonus = param1.readInteger();
         _coinsStillRequiredToBuy = param1.readInteger();
         return true;
      }
      
      public function get totalCoinsForBonus() : int
      {
         return _totalCoinsForBonus;
      }
      
      public function get coinsStillRequiredToBuy() : int
      {
         return _coinsStillRequiredToBuy;
      }
      
      public function get productType() : String
      {
         return _productType;
      }
      
      public function get productClassId() : int
      {
         return _productClassId;
      }
   }
}

