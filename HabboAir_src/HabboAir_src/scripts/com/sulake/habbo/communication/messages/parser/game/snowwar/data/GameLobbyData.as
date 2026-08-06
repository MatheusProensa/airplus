package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class GameLobbyData
   {
      private var _gameId:int;
      
      private var _levelName:String;
      
      private var _gameType:int;
      
      private var _fieldType:int;
      
      private var _numberOfTeams:int;
      
      private var _maximumPlayers:int;
      
      private var _owningPlayerName:String;
      
      private var _levelEntryId:int;
      
      private var _players:Array;
      
      public function GameLobbyData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _players = [];
         super();
         _gameId = param1.readInteger();
         _levelName = param1.readString();
         _gameType = param1.readInteger();
         _fieldType = param1.readInteger();
         _numberOfTeams = param1.readInteger();
         _maximumPlayers = param1.readInteger();
         _owningPlayerName = param1.readString();
         _levelEntryId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _players.push(new GameLobbyPlayerData(param1));
            _loc3_++;
         }
      }
      
      public function get gameId() : int
      {
         return _gameId;
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
      
      public function get maximumPlayers() : int
      {
         return _maximumPlayers;
      }
      
      public function get owningPlayerName() : String
      {
         return _owningPlayerName;
      }
      
      public function get levelEntryId() : int
      {
         return _levelEntryId;
      }
      
      public function get players() : Array
      {
         return _players;
      }
   }
}

