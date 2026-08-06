package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class AchievementLevelUpData
   {
      private var _type:int;
      
      private var _level:int;
      
      private var _points:int;
      
      private var _levelRewardPoints:int;
      
      private var _levelRewardPointType:int;
      
      private var _bonusPoints:int;
      
      private var _badgeId:int;
      
      private var _badgeCode:String = "";
      
      private var _removedBadgeCode:String = "";
      
      private var _achievementID:int;
      
      private var _category:String;
      
      private var _showDialogToUser:Boolean;
      
      private var _ownerCount:int;
      
      private var _badgeRarityId:int;
      
      public function AchievementLevelUpData(param1:IMessageDataWrapper)
      {
         super();
         _type = param1.readInteger();
         _level = param1.readInteger();
         _badgeId = param1.readInteger();
         _badgeCode = param1.readString();
         _points = param1.readInteger();
         _levelRewardPoints = param1.readInteger();
         _levelRewardPointType = param1.readInteger();
         _bonusPoints = param1.readInteger();
         _achievementID = param1.readInteger();
         _removedBadgeCode = param1.readString();
         _category = param1.readString();
         _showDialogToUser = param1.readBoolean();
         _ownerCount = param1.readInteger();
         _badgeRarityId = param1.readInteger();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function get levelRewardPoints() : int
      {
         return _levelRewardPoints;
      }
      
      public function get levelRewardPointType() : int
      {
         return _levelRewardPointType;
      }
      
      public function get bonusPoints() : int
      {
         return _bonusPoints;
      }
      
      public function get badgeId() : int
      {
         return _badgeId;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get removedBadgeCode() : String
      {
         return _removedBadgeCode;
      }
      
      public function get achievementID() : int
      {
         return _achievementID;
      }
      
      public function get category() : String
      {
         return _category;
      }
      
      public function get showDialogToUser() : Boolean
      {
         return _showDialogToUser;
      }
      
      public function get ownerCount() : int
      {
         return _ownerCount;
      }
      
      public function get badgeRarityId() : int
      {
         return _badgeRarityId;
      }
   }
}

