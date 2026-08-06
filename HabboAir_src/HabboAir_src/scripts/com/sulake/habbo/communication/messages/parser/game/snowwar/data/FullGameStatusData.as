package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FullGameStatusData
   {
      private var _remainingTimeSeconds:int;
      
      private var _durationInSeconds:int;
      
      private var _gameObjects:GameObjectsData;
      
      private var _numberOfTeams:int;
      
      private var _gameStatus:GameStatusData;
      
      public function FullGameStatusData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function get remainingTimeSeconds() : int
      {
         return _remainingTimeSeconds;
      }
      
      public function get durationInSeconds() : int
      {
         return _durationInSeconds;
      }
      
      public function get gameObjects() : GameObjectsData
      {
         return _gameObjects;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      public function get gameStatus() : GameStatusData
      {
         return _gameStatus;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         param1.readInteger();
         _remainingTimeSeconds = param1.readInteger();
         _durationInSeconds = param1.readInteger();
         _gameObjects = new GameObjectsData(param1);
         param1.readInteger();
         _numberOfTeams = param1.readInteger();
         _gameStatus = new GameStatusData(param1);
      }
   }
}

