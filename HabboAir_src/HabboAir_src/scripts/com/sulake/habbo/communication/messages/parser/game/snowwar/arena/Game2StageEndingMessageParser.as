package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageEndingMessageParser implements IMessageParser
   {
      private var _timeToNextState:int;
      
      public function Game2StageEndingMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _timeToNextState = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _timeToNextState = param1.readInteger();
         return true;
      }
      
      public function get timeToNextState() : int
      {
         return _timeToNextState;
      }
   }
}

