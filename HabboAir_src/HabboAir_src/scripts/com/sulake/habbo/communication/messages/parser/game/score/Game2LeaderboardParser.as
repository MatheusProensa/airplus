package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2LeaderboardParser implements IMessageParser
   {
      private var _gameTypeId:int;
      
      private var _leaderboard:Array;
      
      private var _totalListSize:int;
      
      public function Game2LeaderboardParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _gameTypeId = -1;
         _leaderboard = null;
         _totalListSize = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _leaderboard = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _leaderboard.push(new LeaderboardEntry(param1));
            _loc3_++;
         }
         _totalListSize = param1.readInteger();
         _gameTypeId = param1.readInteger();
         return true;
      }
      
      public function get gameTypeId() : int
      {
         return _gameTypeId;
      }
      
      public function get leaderboard() : Array
      {
         return _leaderboard;
      }
      
      public function get totalListSize() : int
      {
         return _totalListSize;
      }
   }
}

