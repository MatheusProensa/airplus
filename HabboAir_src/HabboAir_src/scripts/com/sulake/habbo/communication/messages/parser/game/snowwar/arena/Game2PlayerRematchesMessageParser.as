package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2PlayerRematchesMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      public function Game2PlayerRematchesMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         return true;
      }
   }
}

