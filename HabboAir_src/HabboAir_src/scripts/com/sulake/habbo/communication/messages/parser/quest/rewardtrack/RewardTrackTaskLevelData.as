package com.sulake.habbo.communication.messages.parser.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RewardTrackTaskLevelData
   {
      private var _requiredCount:int;
      
      private var _pointsReward:int;
      
      private var _premium:Boolean;
      
      public function RewardTrackTaskLevelData(param1:IMessageDataWrapper)
      {
         super();
         _requiredCount = param1.readInteger();
         _pointsReward = param1.readInteger();
         _premium = param1.readBoolean();
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

