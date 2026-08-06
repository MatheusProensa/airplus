package com.sulake.habbo.quest.rewardtrack.data
{
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackPrizeData;
   
   public class RewardTrackPrize
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
      
      public function RewardTrackPrize(param1:RewardTrackPrizeData)
      {
         super();
         _id = param1.id;
         _requiredPoints = param1.requiredPoints;
         _productItemTypeId = param1.productItemTypeId;
         _rewardTypeId = param1.rewardTypeId;
         _extraParams = param1.extraParams;
         _rewardAmount = param1.rewardAmount;
         _premium = param1.premium;
         _available = param1.available;
         _claimed = param1.claimed;
      }
      
      public function isPremiumLocked(param1:RewardTrack) : Boolean
      {
         return _premium && !param1.premium;
      }
      
      public function isAvailable(param1:RewardTrack) : Boolean
      {
         return !isPremiumLocked(param1) && hasEnoughPoints(param1);
      }
      
      public function hasEnoughPoints(param1:RewardTrack) : Boolean
      {
         return param1.points >= _requiredPoints;
      }
      
      public function isClaimable(param1:RewardTrack) : Boolean
      {
         return isAvailable(param1) && !_claimed;
      }
      
      public function refreshAvailability(param1:RewardTrack) : void
      {
         _available = isAvailable(param1);
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
      
      public function set claimed(param1:Boolean) : void
      {
         _claimed = param1;
      }
   }
}

