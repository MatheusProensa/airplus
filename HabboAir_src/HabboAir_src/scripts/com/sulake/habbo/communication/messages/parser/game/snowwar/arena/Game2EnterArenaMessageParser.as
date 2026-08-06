package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaMessageParser implements IMessageParser
   {
      private var _gameType:int;
      
      private var _fieldType:int;
      
      private var _numberOfTeams:int;
      
      private var _players:Array;
      
      private var _gameLevel:GameLevelData;
      
      public function Game2EnterArenaMessageParser()
      {
         super();
         _players = [];
      }
      
      public function flush() : Boolean
      {
         _gameType = -1;
         _fieldType = -1;
         _numberOfTeams = -1;
         for each(var _loc1_ in _players)
         {
            _loc1_.dispose();
         }
         _players = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Game2PlayerData = null;
         _gameType = param1.readInteger();
         _fieldType = param1.readInteger();
         _numberOfTeams = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new Game2PlayerData();
            _loc4_.parse(param1);
            _players.push(_loc4_);
            _loc3_++;
         }
         _gameLevel = new GameLevelData(param1);
         return true;
      }
      
      public function get gameType() : int
      {
         return _gameType;
      }
      
      public function get fieldType() : int
      {
         return _fieldType;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      public function get players() : Array
      {
         return _players;
      }
      
      public function get gameLevel() : GameLevelData
      {
         return _gameLevel;
      }
   }
}

