package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class GameLobbyPlayerData
   {
      public static var UnknownVarFromGameLobbyPlayerData_Function_1:Function = comparePlayersByTotalScore;
      
      public static var UnknownVarFromGameLobbyPlayerData_Function_2:Function = comparePlayersBySkillLevel;
      
      private var _userId:int;
      
      private var _name:String;
      
      private var _figure:String;
      
      private var _gender:String;
      
      private var _teamId:int;
      
      private var _skillLevel:int;
      
      private var _totalScore:int;
      
      private var _scoreToNextLevel:int;
      
      public function GameLobbyPlayerData(param1:IMessageDataWrapper)
      {
         super();
         _userId = param1.readInteger();
         _name = param1.readString();
         _figure = param1.readString();
         _gender = param1.readString();
         _teamId = param1.readInteger();
         _skillLevel = param1.readInteger();
         _totalScore = param1.readInteger();
         _scoreToNextLevel = param1.readInteger();
      }
      
      private static function comparePlayersByTotalScore(param1:GameLobbyPlayerData, param2:GameLobbyPlayerData) : Number
      {
         var _loc3_:int = param1.totalScore;
         var _loc4_:int = param2.totalScore;
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         if(_loc3_ == _loc4_)
         {
            return 0;
         }
         return -1;
      }
      
      private static function comparePlayersBySkillLevel(param1:GameLobbyPlayerData, param2:GameLobbyPlayerData) : Number
      {
         var _loc4_:int = param1.skillLevel;
         var _loc3_:int = param2.skillLevel;
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         if(_loc4_ == _loc3_)
         {
            return 0;
         }
         return -1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get teamId() : int
      {
         return _teamId;
      }
      
      public function get skillLevel() : int
      {
         return _skillLevel;
      }
      
      public function get totalScore() : int
      {
         return _totalScore;
      }
      
      public function get scoreToNextLevel() : int
      {
         return _scoreToNextLevel;
      }
   }
}

