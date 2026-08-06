package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageRunningMessageParser implements IMessageParser
   {
      private var _timeToStageEnd:int;
      
      public function Game2StageRunningMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _timeToStageEnd = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _timeToStageEnd = param1.readInteger();
         return true;
      }
      
      public function get timeToStageEnd() : int
      {
         return _timeToStageEnd;
      }
   }
}

