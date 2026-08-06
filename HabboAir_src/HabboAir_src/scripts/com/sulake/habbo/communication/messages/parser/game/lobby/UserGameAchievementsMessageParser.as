package com.sulake.habbo.communication.messages.parser.game.lobby
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;
   
   public class UserGameAchievementsMessageParser implements IMessageParser
   {
      private var _gameTypeId:int;
      
      private var UnknownVarFromUserGameAchievementsMessageParser_AchievementsMessageParser_1:AchievementsMessageParser;
      
      public function UserGameAchievementsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _gameTypeId = param1.readInteger();
         UnknownVarFromUserGameAchievementsMessageParser_AchievementsMessageParser_1 = new AchievementsMessageParser();
         UnknownVarFromUserGameAchievementsMessageParser_AchievementsMessageParser_1.parse(param1);
         return true;
      }
      
      public function get gameTypeId() : int
      {
         return _gameTypeId;
      }
      
      public function get achievements() : Array
      {
         return UnknownVarFromUserGameAchievementsMessageParser_AchievementsMessageParser_1.achievements;
      }
      
      public function get defaultCategory() : String
      {
         return UnknownVarFromUserGameAchievementsMessageParser_AchievementsMessageParser_1.defaultCategory;
      }
   }
}

