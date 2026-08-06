package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class AchievementData
   {
      public static const UnknownConstFromAchievementData_Int_1:int = -1;
      
      public static const UnknownConstFromAchievementData_Int_2:int = 0;
      
      public static const UnknownConstFromAchievementData_Int_3:int = 1;
      
      public static const UnknownConstFromAchievementData_Int_4:int = 2;
      
      private var _achievementId:int;
      
      private var _level:int;
      
      private var _badgeId:String;
      
      private var _scoreAtStartOfLevel:int;
      
      private var UnknownVarFromAchievementData_Int_1:int;
      
      private var _levelRewardPoints:int;
      
      private var _levelRewardPointType:int;
      
      private var UnknownVarFromAchievementData_Int_2:int;
      
      private var _finalLevel:Boolean;
      
      private var _category:String;
      
      private var _subCategory:String;
      
      private var _levelCount:int;
      
      private var _displayMethod:int;
      
      private var _state:int;
      
      private var _code:String;
      
      public function AchievementData(param1:IMessageDataWrapper)
      {
         super();
         _achievementId = param1.readInteger();
         _level = param1.readInteger();
         _badgeId = param1.readString();
         _scoreAtStartOfLevel = param1.readInteger();
         UnknownVarFromAchievementData_Int_1 = Math.max(1,param1.readInteger());
         _levelRewardPoints = param1.readInteger();
         _levelRewardPointType = param1.readInteger();
         UnknownVarFromAchievementData_Int_2 = param1.readInteger();
         _finalLevel = param1.readBoolean();
         _category = param1.readString();
         _subCategory = param1.readString();
         _levelCount = param1.readInteger();
         _displayMethod = param1.readInteger();
         _state = param1.readShort();
         var _loc2_:String = _badgeId;
         if(_loc2_.indexOf("ACH_") == 0)
         {
            _loc2_ = _loc2_.substr(4);
         }
         var _loc3_:String = "0123456789";
         while(_loc2_.length > 0 && _loc3_.indexOf(_loc2_.charAt(_loc2_.length - 1)) != -1)
         {
            _loc2_ = _loc2_.substr(0,_loc2_.length - 1);
         }
         _code = _loc2_;
      }
      
      public function get achievementId() : int
      {
         return _achievementId;
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get scoreAtStartOfLevel() : int
      {
         return _scoreAtStartOfLevel;
      }
      
      public function get scoreLimit() : int
      {
         return UnknownVarFromAchievementData_Int_1 - _scoreAtStartOfLevel;
      }
      
      public function get levelRewardPoints() : int
      {
         return _levelRewardPoints;
      }
      
      public function get levelRewardPointType() : int
      {
         return _levelRewardPointType;
      }
      
      public function get currentPoints() : int
      {
         return UnknownVarFromAchievementData_Int_2 - _scoreAtStartOfLevel;
      }
      
      public function get finalLevel() : Boolean
      {
         return _finalLevel;
      }
      
      public function get category() : String
      {
         return _category;
      }
      
      public function get subCategory() : String
      {
         return _subCategory;
      }
      
      public function get levelCount() : int
      {
         return _levelCount;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get code() : String
      {
         return _code;
      }
      
      public function set category(param1:String) : void
      {
         _category = param1;
      }
      
      public function get firstLevelAchieved() : Boolean
      {
         return _level > 1 || _finalLevel;
      }
      
      public function setMaxProgress() : void
      {
         UnknownVarFromAchievementData_Int_2 = UnknownVarFromAchievementData_Int_1;
      }
      
      public function get displayMethod() : int
      {
         return _displayMethod;
      }
   }
}

