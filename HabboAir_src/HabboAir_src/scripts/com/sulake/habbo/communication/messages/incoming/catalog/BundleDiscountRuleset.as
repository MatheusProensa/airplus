package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class BundleDiscountRuleset
   {
      private var _maxPurchaseSize:int;
      
      private var _bundleSize:int;
      
      private var _bundleDiscountSize:int;
      
      private var _bonusThreshold:int;
      
      private var _additionalBonusDiscountThresholdQuantities:Array;
      
      public function BundleDiscountRuleset(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _maxPurchaseSize = param1.readInteger();
         _bundleSize = param1.readInteger();
         _bundleDiscountSize = param1.readInteger();
         _bonusThreshold = param1.readInteger();
         _additionalBonusDiscountThresholdQuantities = [];
         var _loc2_:int = param1.readInteger();
         while(_loc3_ < _loc2_)
         {
            _additionalBonusDiscountThresholdQuantities.push(param1.readInteger());
            _loc3_++;
         }
      }
      
      public function get maxPurchaseSize() : int
      {
         return _maxPurchaseSize;
      }
      
      public function get bundleSize() : int
      {
         return _bundleSize;
      }
      
      public function get bundleDiscountSize() : int
      {
         return _bundleDiscountSize;
      }
      
      public function get bonusThreshold() : int
      {
         return _bonusThreshold;
      }
      
      public function get additionalBonusDiscountThresholdQuantities() : Array
      {
         return _additionalBonusDiscountThresholdQuantities;
      }
   }
}

