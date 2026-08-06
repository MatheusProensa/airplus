package com.sulake.habbo.quest.rewardtrack.data
{
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackData;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackPrizeData;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackTaskData;
   
   public class RewardTrack
   {
      private var _id:String;
      
      private var _theme:String;
      
      private var _points:int;
      
      private var _hasPremiumConfig:Boolean;
      
      private var _taskPointsBoost:Number;
      
      private var _instantPoints:int;
      
      private var _costDiamonds:int;
      
      private var _costCredits:int;
      
      private var _premium:Boolean;
      
      private var _complete:Boolean;
      
      private var _premiumComplete:Boolean;
      
      private var _tasks:Vector.<RewardTrackTask>;
      
      private var _prizes:Vector.<RewardTrackPrize>;
      
      public function RewardTrack(param1:RewardTrackData)
      {
         super();
         _id = param1.id;
         _theme = param1.theme;
         _points = param1.points;
         _hasPremiumConfig = param1.hasPremiumConfig;
         _taskPointsBoost = param1.taskPointsBoost;
         _instantPoints = param1.instantPoints;
         _costDiamonds = param1.costDiamonds;
         _costCredits = param1.costCredits;
         _premium = param1.premium;
         _complete = param1.complete;
         _premiumComplete = param1.premiumComplete;
         _tasks = new Vector.<RewardTrackTask>();
         for each(var _loc2_ in param1.tasks)
         {
            _tasks.push(new RewardTrackTask(this,_loc2_));
         }
         _prizes = new Vector.<RewardTrackPrize>();
         for each(var _loc3_ in param1.prizes)
         {
            _prizes.push(new RewardTrackPrize(_loc3_));
         }
         refreshDerivedState();
      }
      
      public function updateProgress(param1:String, param2:int, param3:int) : RewardTrackTask
      {
         _points = param3;
         var _loc4_:RewardTrackTask = getTaskById(param1);
         if(_loc4_ != null)
         {
            _loc4_.progressCount = param2;
         }
         refreshDerivedState();
         return _loc4_;
      }
      
      public function markPrizeClaimed(param1:String) : RewardTrackPrize
      {
         var _loc2_:RewardTrackPrize = getPrizeById(param1);
         if(_loc2_ != null)
         {
            _loc2_.claimed = true;
         }
         refreshDerivedState();
         return _loc2_;
      }
      
      public function markPremiumPurchased(param1:int) : void
      {
         _premium = true;
         _points = param1;
         refreshDerivedState();
      }
      
      public function refreshDerivedState() : void
      {
         for each(var _loc3_ in _prizes)
         {
            _loc3_.refreshAvailability(this);
         }
         var _loc2_:Boolean = true;
         var _loc1_:Boolean = true;
         for each(_loc3_ in _prizes)
         {
            if(!_loc3_.premium && !_loc3_.claimed)
            {
               _loc2_ = false;
            }
            if(_loc3_.premium && !_loc3_.claimed)
            {
               _loc1_ = false;
            }
         }
         _complete = _loc2_;
         _premiumComplete = !_hasPremiumConfig || _loc2_ && _loc1_;
      }
      
      public function getTaskById(param1:String) : RewardTrackTask
      {
         for each(var _loc2_ in _tasks)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPrizeById(param1:String) : RewardTrackPrize
      {
         for each(var _loc2_ in _prizes)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get completedTaskCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in _tasks)
         {
            if(_loc1_.isComplete)
            {
               _loc2_ += 1;
            }
         }
         return _loc2_;
      }
      
      public function get totalTaskCount() : int
      {
         return _tasks.length;
      }
      
      public function get claimedPrizeCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _prizes)
         {
            if(_loc2_.claimed)
            {
               _loc1_ += 1;
            }
         }
         return _loc1_;
      }
      
      public function get totalPrizeCount() : int
      {
         return _prizes.length;
      }
      
      public function get hasPremiumPrizes() : Boolean
      {
         for each(var _loc1_ in _prizes)
         {
            if(_loc1_.premium)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get hasPremiumTasks() : Boolean
      {
         for each(var _loc1_ in _tasks)
         {
            if(_loc1_.premium)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get hasPremiumLevels() : Boolean
      {
         for each(var _loc1_ in _tasks)
         {
            if(_loc1_.hasPremiumLevels)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get theme() : String
      {
         return _theme;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function get hasPremiumConfig() : Boolean
      {
         return _hasPremiumConfig;
      }
      
      public function get taskPointsBoost() : Number
      {
         return _taskPointsBoost;
      }
      
      public function get instantPoints() : int
      {
         return _instantPoints;
      }
      
      public function get costDiamonds() : int
      {
         return _costDiamonds;
      }
      
      public function get costCredits() : int
      {
         return _costCredits;
      }
      
      public function get premium() : Boolean
      {
         return _premium;
      }
      
      public function get complete() : Boolean
      {
         return _complete;
      }
      
      public function get premiumComplete() : Boolean
      {
         return _premiumComplete;
      }
      
      public function get tasks() : Vector.<RewardTrackTask>
      {
         return _tasks;
      }
      
      public function get prizes() : Vector.<RewardTrackPrize>
      {
         return _prizes;
      }
   }
}

