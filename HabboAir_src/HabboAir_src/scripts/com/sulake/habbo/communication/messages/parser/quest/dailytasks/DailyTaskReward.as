package com.sulake.habbo.communication.messages.parser.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class DailyTaskReward
   {
      private var _productItemTypeId:int;
      
      private var _rewardTypeId:String;
      
      private var _extraParams:String;
      
      private var _amount:int;
      
      public function DailyTaskReward(param1:IMessageDataWrapper)
      {
         super();
         _productItemTypeId = param1.readShort();
         _rewardTypeId = param1.readString();
         _extraParams = param1.readString();
         _amount = param1.readInteger();
      }
      
      public function get productItemTypeId() : int
      {
         return _productItemTypeId;
      }
      
      public function get rewardTypeId() : String
      {
         return _rewardTypeId;
      }
      
      public function get extraParams() : String
      {
         return _extraParams;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

