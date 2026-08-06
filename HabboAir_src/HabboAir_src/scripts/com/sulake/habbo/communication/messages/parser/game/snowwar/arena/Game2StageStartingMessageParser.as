package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameObjectsData;
   
   [SecureSWF(rename="true")]
   public class Game2StageStartingMessageParser implements IMessageParser
   {
      private var _gameObjects:GameObjectsData;
      
      private var _gameType:int;
      
      private var _roomType:String;
      
      private var _countDown:int;
      
      public function Game2StageStartingMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _gameType = param1.readInteger();
         _roomType = param1.readString();
         _countDown = param1.readInteger();
         _gameObjects = new GameObjectsData(param1);
         return true;
      }
      
      public function get gameObjects() : GameObjectsData
      {
         return _gameObjects;
      }
      
      public function get gameType() : int
      {
         return _gameType;
      }
      
      public function get roomType() : String
      {
         return _roomType;
      }
      
      public function get countDown() : int
      {
         return _countDown;
      }
   }
}

