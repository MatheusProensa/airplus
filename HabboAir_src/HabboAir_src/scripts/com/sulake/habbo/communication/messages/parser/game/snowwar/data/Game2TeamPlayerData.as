package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2TeamPlayerData
   {
      private var _userId:int;
      
      private var _userName:String;
      
      private var _score:int;
      
      private var _figure:String;
      
      private var _gender:String;
      
      private var _playerStats:Game2PlayerStatsData;
      
      private var _teamId:int;
      
      private var _willRejoin:Boolean;
      
      public function Game2TeamPlayerData(param1:int, param2:IMessageDataWrapper)
      {
         super();
         _teamId = param1;
         _userName = param2.readString();
         _userId = param2.readInteger();
         _figure = param2.readString();
         _gender = param2.readString();
         _score = param2.readInteger();
         _playerStats = new Game2PlayerStatsData(param2);
         _willRejoin = false;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get playerStats() : Game2PlayerStatsData
      {
         return _playerStats;
      }
      
      public function get teamId() : int
      {
         return _teamId;
      }
      
      public function get willRejoin() : Boolean
      {
         return _willRejoin;
      }
      
      public function set willRejoin(param1:Boolean) : void
      {
         _willRejoin = param1;
      }
   }
}

