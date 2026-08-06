package com.sulake.habbo.catalog.marketplace
{
   public class MarketplaceItemStats
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
      
      public function MarketplaceItemStats()
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
      
      public function set averagePrice(param1:int) : void
      {
         _averagePrice = param1;
      }
      
      public function set offerCount(param1:int) : void
      {
         _offerCount = param1;
      }
      
      public function set historyLength(param1:int) : void
      {
         _historyLength = param1;
      }
      
      public function set dayOffsets(param1:Array) : void
      {
         _dayOffsets = param1.slice();
      }
      
      public function set averagePrices(param1:Array) : void
      {
         _averagePrices = param1.slice();
      }
      
      public function set soldAmounts(param1:Array) : void
      {
         _soldAmounts = param1.slice();
      }
      
      public function set furniTypeId(param1:int) : void
      {
         _furniTypeId = param1;
      }
      
      public function set furniCategoryId(param1:int) : void
      {
         _furniCategoryId = param1;
      }
      
      public function set lowestCurrentPrice(param1:int) : void
      {
         _lowestCurrentPrice = param1;
      }
      
      public function set suggestedPrice(param1:int) : void
      {
         _suggestedPrice = param1;
      }
   }
}

