package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2StartingGameFailedMessageParser implements IMessageParser
   {
      public static const UnknownConstFromGame2StartingGameFailedMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromGame2StartingGameFailedMessageParser_Int_2:int = 2;
      
      private var _reason:int;
      
      public function Game2StartingGameFailedMessageParser()
      {
         super();
      }
      
      public function get reason() : int
      {
         return _reason;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _reason = param1.readInteger();
         return true;
      }
   }
}

