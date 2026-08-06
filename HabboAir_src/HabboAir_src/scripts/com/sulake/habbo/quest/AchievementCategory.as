package com.sulake.habbo.quest
{
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   
   public class AchievementCategory
   {
      private var _code:String;
      
      private var _achievements:Vector.<AchievementData> = new Vector.<AchievementData>(0);
      
      public function AchievementCategory(param1:String)
      {
         super();
         _code = param1;
      }
      
      public function add(param1:AchievementData) : void
      {
         _achievements.push(param1);
      }
      
      public function update(param1:AchievementData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AchievementData = null;
         _loc3_ = 0;
         while(_loc3_ < _achievements.length)
         {
            _loc2_ = _achievements[_loc3_];
            if(_loc2_.achievementId == param1.achievementId)
            {
               _achievements[_loc3_] = param1;
            }
            _loc3_++;
         }
      }
      
      public function getProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _achievements)
         {
            _loc1_ += _loc2_.finalLevel ? _loc2_.level : _loc2_.level - 1;
         }
         return _loc1_;
      }
      
      public function getMaxProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _achievements)
         {
            _loc1_ += _loc2_.levelCount;
         }
         return _loc1_;
      }
      
      public function get code() : String
      {
         return _code;
      }
      
      public function get achievements() : Vector.<AchievementData>
      {
         return _achievements;
      }
      
      public function visibleInList() : Boolean
      {
         return _code != "new" && _code != "wired_games";
      }
   }
}

