package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionProgressMessageParser implements IMessageParser
   {
      private var _stuffId:int;
      
      private var _achievementId:int;
      
      private var _requiredLevelBadgeCode:String;
      
      private var _userProgress:int;
      
      private var _totalProgress:int;
      
      private var _endTime:int;
      
      public function AchievementResolutionProgressMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _stuffId = -1;
         _achievementId = 0;
         _requiredLevelBadgeCode = "";
         _userProgress = 0;
         _totalProgress = 0;
         _endTime = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         _achievementId = param1.readInteger();
         _requiredLevelBadgeCode = param1.readString();
         _userProgress = param1.readInteger();
         _totalProgress = param1.readInteger();
         _endTime = param1.readInteger();
         return true;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get achievementId() : int
      {
         return _achievementId;
      }
      
      public function get requiredLevelBadgeCode() : String
      {
         return _requiredLevelBadgeCode;
      }
      
      public function get userProgress() : int
      {
         return _userProgress;
      }
      
      public function get totalProgress() : int
      {
         return _totalProgress;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
   }
}

