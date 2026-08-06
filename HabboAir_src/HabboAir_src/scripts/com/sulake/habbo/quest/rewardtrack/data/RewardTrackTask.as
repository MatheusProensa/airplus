package com.sulake.habbo.quest.rewardtrack.data
{
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackTaskData;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackTaskLevelData;
   
   public class RewardTrackTask
   {
      private var _track:RewardTrack;
      
      private var _id:String;
      
      private var _actionType:String;
      
      private var _parameter:String;
      
      private var _progressCount:int;
      
      private var _premium:Boolean;
      
      private var _levels:Vector.<RewardTrackTaskLevel>;
      
      public function RewardTrackTask(param1:RewardTrack, param2:RewardTrackTaskData)
      {
         super();
         _track = param1;
         _id = param2.id;
         _actionType = param2.actionType;
         _parameter = param2.parameter;
         _progressCount = param2.progressCount;
         _premium = param2.premium;
         _levels = new Vector.<RewardTrackTaskLevel>();
         for each(var _loc3_ in param2.taskRewards)
         {
            _levels.push(new RewardTrackTaskLevel(_loc3_));
         }
      }
      
      public function get isComplete() : Boolean
      {
         for each(var _loc1_ in _levels)
         {
            if(_progressCount < _loc1_.requiredCount)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get hasProgress() : Boolean
      {
         return _progressCount > 0;
      }
      
      public function get activeLevelIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _levels.length)
         {
            if(_progressCount < _levels[_loc1_].requiredCount)
            {
               return _loc1_;
            }
            _loc1_ += 1;
         }
         return _levels.length - 1;
      }
      
      public function get activeLevel() : RewardTrackTaskLevel
      {
         return _levels[activeLevelIndex];
      }
      
      public function progressRatioFor(param1:RewardTrackTaskLevel) : Number
      {
         if(param1.requiredCount <= 0)
         {
            return 1;
         }
         return Math.max(0,Math.min(1,_progressCount / param1.requiredCount));
      }
      
      public function get hasPremiumLevels() : Boolean
      {
         for each(var _loc1_ in _levels)
         {
            if(_loc1_.premium)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get track() : RewardTrack
      {
         return _track;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get actionType() : String
      {
         return _actionType;
      }
      
      public function get parameter() : String
      {
         return _parameter;
      }
      
      public function get progressCount() : int
      {
         return _progressCount;
      }
      
      public function set progressCount(param1:int) : void
      {
         _progressCount = param1;
      }
      
      public function get premium() : Boolean
      {
         return _premium;
      }
      
      public function get levels() : Vector.<RewardTrackTaskLevel>
      {
         return _levels;
      }
   }
}

