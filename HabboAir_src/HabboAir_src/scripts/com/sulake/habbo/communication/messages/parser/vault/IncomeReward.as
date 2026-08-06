package com.sulake.habbo.communication.messages.parser.vault
{
   [SecureSWF(rename="true")]
   public class IncomeReward
   {
      private var _rewardCategory:int;
      
      private var _rewardType:int;
      
      private var _amount:int;
      
      private var _productCode:String;
      
      public function IncomeReward(param1:int, param2:int, param3:int, param4:String)
      {
         super();
         _rewardCategory = param1;
         _rewardType = param2;
         _amount = param3;
         _productCode = param4;
      }
      
      public function get rewardCategory() : int
      {
         return _rewardCategory;
      }
      
      public function get rewardType() : int
      {
         return _rewardType;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
   }
}

