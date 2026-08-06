package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2SnowWarGameStats
   {
      private var _playerWithMostKills:int;
      
      private var _playerWithMostHits:int;
      
      public function Game2SnowWarGameStats(param1:IMessageDataWrapper)
      {
         super();
         _playerWithMostKills = param1.readInteger();
         _playerWithMostHits = param1.readInteger();
      }
      
      public function get playerWithMostKills() : int
      {
         return _playerWithMostKills;
      }
      
      public function get playerWithMostHits() : int
      {
         return _playerWithMostHits;
      }
   }
}

