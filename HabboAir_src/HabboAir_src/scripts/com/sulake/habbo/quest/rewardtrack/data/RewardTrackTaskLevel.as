package com.sulake.habbo.quest.rewardtrack.data
{
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackTaskLevelData;
   
   public class RewardTrackTaskLevel
   {
      private var _requiredCount:int;
      
      private var _pointsReward:int;
      
      private var _premium:Boolean;
      
      public function RewardTrackTaskLevel(param1:RewardTrackTaskLevelData)
      {
         super();
         _requiredCount = param1.requiredCount;
         _pointsReward = param1.pointsReward;
         _premium = param1.premium;
      }
      
      public function get requiredCount() : int
      {
         return _requiredCount;
      }
      
      public function get pointsReward() : int
      {
         return _pointsReward;
      }
      
      public function get premium() : Boolean
      {
         return _premium;
      }
   }
}

