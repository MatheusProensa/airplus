package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.utils.UnknownHabboUtils1;
   
   [SecureSWF(rename="true")]
   public class TalentTrackLevel
   {
      private var _level:int;
      
      private var _state:int;
      
      private var _tasks:Vector.<TalentTrackTask> = new Vector.<TalentTrackTask>();
      
      private var _rewardPerks:Vector.<TalentTrackRewardPerk> = new Vector.<TalentTrackRewardPerk>();
      
      private var _rewardProducts:Vector.<TalentTrackRewardProduct> = new Vector.<TalentTrackRewardProduct>();
      
      public function TalentTrackLevel()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _level = param1.readInteger();
         _state = param1.readInteger();
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _tasks.push(new TalentTrackTask(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _rewardPerks.push(new TalentTrackRewardPerk(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _rewardProducts.push(new TalentTrackRewardProduct(param1));
            _loc3_++;
         }
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get tasks() : Vector.<TalentTrackTask>
      {
         return _tasks;
      }
      
      public function get rewardPerks() : Vector.<TalentTrackRewardPerk>
      {
         return _rewardPerks;
      }
      
      public function get rewardProducts() : Vector.<TalentTrackRewardProduct>
      {
         return _rewardProducts;
      }
      
      public function get rewardCount() : int
      {
         return _rewardPerks.length + _rewardProducts.length;
      }
      
      public function get levelProgress() : Number
      {
         var _loc2_:Number = 1 / _tasks.length;
         var _loc3_:Number = 0;
         for each(var _loc1_ in _tasks)
         {
            if(_loc1_.state == 2)
            {
               _loc3_ += _loc2_;
            }
         }
         return UnknownHabboUtils1.clamp(_loc3_);
      }
      
      public function findTaskByAchievementId(param1:int) : TalentTrackTask
      {
         for each(var _loc2_ in _tasks)
         {
            if(_loc2_.achievementId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

