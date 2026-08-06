package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2GameResult;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2SnowWarGameStats;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamScoreData;
   
   [SecureSWF(rename="true")]
   public class Game2GameEndingMessageParser implements IMessageParser
   {
      private var _timeToNextState:int;
      
      private var _teams:Array;
      
      private var _teamScores:Array;
      
      private var _generalStats:Game2SnowWarGameStats;
      
      private var _gameResult:Game2GameResult;
      
      public function Game2GameEndingMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _timeToNextState = -1;
         _teams = [];
         _teamScores = [];
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _timeToNextState = param1.readInteger();
         _gameResult = new Game2GameResult(param1);
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _teams.push(new Game2TeamScoreData(param1));
            _loc3_++;
         }
         _generalStats = new Game2SnowWarGameStats(param1);
         return true;
      }
      
      public function get timeToNextState() : int
      {
         return _timeToNextState;
      }
      
      public function get teams() : Array
      {
         return _teams;
      }
      
      public function get teamScores() : Array
      {
         return _teamScores;
      }
      
      public function get gameResult() : Game2GameResult
      {
         return _gameResult;
      }
      
      public function get generalStats() : Game2SnowWarGameStats
      {
         return _generalStats;
      }
   }
}

