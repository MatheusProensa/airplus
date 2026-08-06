package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2StartCounterMessageParser implements IMessageParser
   {
      private var _countDownLength:int;
      
      public function Game2StartCounterMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _countDownLength = param1.readInteger();
         return true;
      }
      
      public function get countDownLength() : int
      {
         return _countDownLength;
      }
   }
}

