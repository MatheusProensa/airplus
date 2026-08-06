package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionData
   {
      public static const UnknownConstFromAchievementResolutionData_Int_1:int = 0;
      
      private var _achievementId:int;
      
      private var _level:int;
      
      private var _badgeId:String;
      
      private var _requiredLevel:int;
      
      private var _state:int;
      
      public function AchievementResolutionData(param1:IMessageDataWrapper)
      {
         super();
         _achievementId = param1.readInteger();
         _level = param1.readInteger();
         _badgeId = param1.readString();
         _requiredLevel = param1.readInteger();
         _state = param1.readInteger();
      }
      
      public function dispose() : void
      {
         _achievementId = 0;
         _level = 0;
         _badgeId = "";
         _requiredLevel = 0;
      }
      
      public function get achievementId() : int
      {
         return _achievementId;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function get requiredLevel() : int
      {
         return _requiredLevel;
      }
      
      public function get enabled() : Boolean
      {
         return _state == 0;
      }
      
      public function get state() : int
      {
         return _state;
      }
   }
}

