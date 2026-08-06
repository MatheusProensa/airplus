package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2AccountGameStatusMessageParser implements IMessageParser
   {
      private var _gameTypeId:int;
      
      private var _freeGamesLeft:int;
      
      private var _gamesPlayedTotal:int;
      
      public function Game2AccountGameStatusMessageParser()
      {
         super();
      }
      
      public function get gameTypeId() : int
      {
         return _gameTypeId;
      }
      
      public function get freeGamesLeft() : int
      {
         return _freeGamesLeft;
      }
      
      public function get gamesPlayedTotal() : int
      {
         return _gamesPlayedTotal;
      }
      
      public function get hasUnlimitedGames() : Boolean
      {
         return _freeGamesLeft == -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _gameTypeId = param1.readInteger();
         _freeGamesLeft = param1.readInteger();
         _gamesPlayedTotal = param1.readInteger();
         return true;
      }
   }
}

