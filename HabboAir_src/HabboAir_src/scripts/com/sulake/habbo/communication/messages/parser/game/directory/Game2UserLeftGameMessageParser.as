package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2UserLeftGameMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      public function Game2UserLeftGameMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}

