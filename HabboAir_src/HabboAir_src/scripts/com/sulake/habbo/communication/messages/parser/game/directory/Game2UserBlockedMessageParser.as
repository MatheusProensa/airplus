package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2UserBlockedMessageParser implements IMessageParser
   {
      private var _playerBlockLength:int;
      
      public function Game2UserBlockedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _playerBlockLength = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _playerBlockLength = param1.readInteger();
         return true;
      }
      
      public function get playerBlockLength() : int
      {
         return _playerBlockLength;
      }
   }
}

