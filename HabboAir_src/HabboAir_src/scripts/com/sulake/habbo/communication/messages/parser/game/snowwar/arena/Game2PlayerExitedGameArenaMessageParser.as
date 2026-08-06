package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2PlayerExitedGameArenaMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      private var _playerGameObjectId:int;
      
      public function Game2PlayerExitedGameArenaMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _userId = NaN;
         _playerGameObjectId = NaN;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         _playerGameObjectId = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get playerGameObjectId() : int
      {
         return _playerGameObjectId;
      }
   }
}

