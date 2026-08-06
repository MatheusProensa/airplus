package com.sulake.habbo.communication.messages.parser.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RewardTrackPrizeData
   {
      private var _id:String;
      
      private var _requiredPoints:int;
      
      private var _productItemTypeId:int;
      
      private var _rewardTypeId:String;
      
      private var _extraParams:String;
      
      private var _rewardAmount:int;
      
      private var _premium:Boolean;
      
      private var _available:Boolean;
      
      private var _claimed:Boolean;
      
      public function RewardTrackPrizeData(param1:IMessageDataWrapper)
      {
         super();
         _id = param1.readString();
         _requiredPoints = param1.readInteger();
         _productItemTypeId = param1.readShort();
         _rewardTypeId = param1.readString();
         _extraParams = param1.readString();
         _rewardAmount = param1.readInteger();
         _premium = param1.readBoolean();
         _available = param1.readBoolean();
         _claimed = param1.readBoolean();
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get requiredPoints() : int
      {
         return _requiredPoints;
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
      
      public function get rewardAmount() : int
      {
         return _rewardAmount;
      }
      
      public function get premium() : Boolean
      {
         return _premium;
      }
      
      public function get available() : Boolean
      {
         return _available;
      }
      
      public function get claimed() : Boolean
      {
         return _claimed;
      }
   }
}

