package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2TeamScoreData
   {
      private var _score:int;
      
      private var _teamReference:int;
      
      private var _players:Array;
      
      public function Game2TeamScoreData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _teamReference = param1.readInteger();
         _score = param1.readInteger();
         _players = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _players.push(new Game2TeamPlayerData(_teamReference,param1));
            _loc3_++;
         }
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get teamReference() : int
      {
         return _teamReference;
      }
      
      public function get players() : Array
      {
         return _players;
      }
   }
}

