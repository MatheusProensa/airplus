package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalData implements IComponentInterfaceQueue
   {
      private var _hasGoalExpired:Boolean;
      
      private var _personalContributionScore:int;
      
      private var _personalContributionRank:int;
      
      private var _communityTotalScore:int;
      
      private var _communityHighestAchievedLevel:int;
      
      private var _scoreRemainingUntilNextLevel:int;
      
      private var _percentCompletionTowardsNextLevel:int;
      
      private var _goalCode:String;
      
      private var _timeRemainingInSeconds:int;
      
      private var _rewardUserLimits:Array;
      
      public function CommunityGoalData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _rewardUserLimits = [];
         super();
         _hasGoalExpired = param1.readBoolean();
         _personalContributionScore = param1.readInteger();
         _personalContributionRank = param1.readInteger();
         _communityTotalScore = param1.readInteger();
         _communityHighestAchievedLevel = param1.readInteger();
         _scoreRemainingUntilNextLevel = param1.readInteger();
         _percentCompletionTowardsNextLevel = param1.readInteger();
         _goalCode = param1.readString();
         _timeRemainingInSeconds = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _rewardUserLimits.push(param1.readInteger());
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         _rewardUserLimits = null;
      }
      
      public function get disposed() : Boolean
      {
         return _rewardUserLimits == null;
      }
      
      public function get hasGoalExpired() : Boolean
      {
         return _hasGoalExpired;
      }
      
      public function get personalContributionScore() : int
      {
         return _personalContributionScore;
      }
      
      public function get personalContributionRank() : int
      {
         return _personalContributionRank;
      }
      
      public function get communityTotalScore() : int
      {
         return _communityTotalScore;
      }
      
      public function get communityHighestAchievedLevel() : int
      {
         return _communityHighestAchievedLevel;
      }
      
      public function get scoreRemainingUntilNextLevel() : int
      {
         return _scoreRemainingUntilNextLevel;
      }
      
      public function get percentCompletionTowardsNextLevel() : int
      {
         return _percentCompletionTowardsNextLevel;
      }
      
      public function get timeRemainingInSeconds() : int
      {
         return _timeRemainingInSeconds;
      }
      
      public function get rewardUserLimits() : Array
      {
         return _rewardUserLimits;
      }
      
      public function get goalCode() : String
      {
         return _goalCode;
      }
   }
}

