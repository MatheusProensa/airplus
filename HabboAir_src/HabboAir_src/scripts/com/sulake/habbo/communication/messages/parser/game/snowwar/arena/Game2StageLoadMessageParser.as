package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageLoadMessageParser implements IMessageParser
   {
      private var _gameType:int;
      
      public function Game2StageLoadMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _gameType = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _gameType = param1.readInteger();
         return true;
      }
      
      public function get gameType() : int
      {
         return _gameType;
      }
   }
}

