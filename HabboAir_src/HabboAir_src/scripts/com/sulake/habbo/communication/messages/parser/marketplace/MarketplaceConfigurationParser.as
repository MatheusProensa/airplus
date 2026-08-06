package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceConfigurationParser implements IMessageParser
   {
      private var _isEnabled:Boolean;
      
      private var _commission:int;
      
      private var _tokenBatchPrice:int;
      
      private var _tokenBatchSize:int;
      
      private var _offerMaxPrice:int;
      
      private var _offerMinPrice:int;
      
      private var _expirationHours:int;
      
      private var _averagePricePeriod:int;
      
      private var _sellingFeePercentage:int;
      
      private var _revenueLimit:int;
      
      private var _halfTaxLimit:int;
      
      public function MarketplaceConfigurationParser()
      {
         super();
      }
      
      public function get isEnabled() : Boolean
      {
         return _isEnabled;
      }
      
      public function get commission() : int
      {
         return _commission;
      }
      
      public function get tokenBatchPrice() : int
      {
         return _tokenBatchPrice;
      }
      
      public function get tokenBatchSize() : int
      {
         return _tokenBatchSize;
      }
      
      public function get offerMinPrice() : int
      {
         return _offerMinPrice;
      }
      
      public function get offerMaxPrice() : int
      {
         return _offerMaxPrice;
      }
      
      public function get expirationHours() : int
      {
         return _expirationHours;
      }
      
      public function get averagePricePeriod() : int
      {
         return _averagePricePeriod;
      }
      
      public function get tokensBatchSize() : int
      {
         return _tokenBatchSize;
      }
      
      public function get sellingFeePercentage() : int
      {
         return _sellingFeePercentage;
      }
      
      public function get revenueLimit() : int
      {
         return _revenueLimit;
      }
      
      public function get halfTaxLimit() : int
      {
         return _halfTaxLimit;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isEnabled = param1.readBoolean();
         _commission = param1.readInteger();
         _tokenBatchPrice = param1.readInteger();
         _tokenBatchSize = param1.readInteger();
         _offerMinPrice = param1.readInteger();
         _offerMaxPrice = param1.readInteger();
         _expirationHours = param1.readInteger();
         _averagePricePeriod = param1.readInteger();
         _sellingFeePercentage = param1.readInteger();
         _revenueLimit = param1.readInteger();
         _halfTaxLimit = param1.readInteger();
         return true;
      }
   }
}

