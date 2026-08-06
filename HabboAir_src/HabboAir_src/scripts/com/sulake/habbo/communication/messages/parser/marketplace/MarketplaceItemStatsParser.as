package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceItemStatsParser implements IMessageParser
   {
      private var _averagePrice:int;
      
      private var _offerCount:int;
      
      private var _historyLength:int;
      
      private var _dayOffsets:Array;
      
      private var _averagePrices:Array;
      
      private var _soldAmounts:Array;
      
      private var _furniTypeId:int;
      
      private var _furniCategoryId:int;
      
      private var _lowestCurrentPrice:int;
      
      private var _suggestedPrice:int;
      
      public function MarketplaceItemStatsParser()
      {
         super();
      }
      
      public function get averagePrice() : int
      {
         return _averagePrice;
      }
      
      public function get offerCount() : int
      {
         return _offerCount;
      }
      
      public function get historyLength() : int
      {
         return _historyLength;
      }
      
      public function get dayOffsets() : Array
      {
         return _dayOffsets;
      }
      
      public function get averagePrices() : Array
      {
         return _averagePrices;
      }
      
      public function get soldAmounts() : Array
      {
         return _soldAmounts;
      }
      
      public function get furniTypeId() : int
      {
         return _furniTypeId;
      }
      
      public function get furniCategoryId() : int
      {
         return _furniCategoryId;
      }
      
      public function get lowestCurrentPrice() : int
      {
         return _lowestCurrentPrice;
      }
      
      public function get suggestedPrice() : int
      {
         return _suggestedPrice;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _averagePrice = param1.readInteger();
         _offerCount = param1.readInteger();
         _historyLength = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _dayOffsets = [];
         _averagePrices = [];
         _soldAmounts = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _dayOffsets.push(param1.readInteger());
            _averagePrices.push(param1.readInteger());
            _soldAmounts.push(param1.readInteger());
            _loc3_++;
         }
         _furniCategoryId = param1.readInteger();
         _furniTypeId = param1.readInteger();
         _lowestCurrentPrice = param1.readInteger();
         _suggestedPrice = param1.readInteger();
         return true;
      }
   }
}

