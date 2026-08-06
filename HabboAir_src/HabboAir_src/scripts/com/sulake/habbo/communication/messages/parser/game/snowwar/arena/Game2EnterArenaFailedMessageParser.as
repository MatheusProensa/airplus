package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaFailedMessageParser implements IMessageParser
   {
      public static const UnknownConstFromGame2EnterArenaFailedMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromGame2EnterArenaFailedMessageParser_Int_2:int = 2;
      
      public static const UnknownConstFromGame2EnterArenaFailedMessageParser_Int_3:int = 3;
      
      public static const UnknownConstFromGame2EnterArenaFailedMessageParser_Int_4:int = 4;
      
      private var _reason:int;
      
      public function Game2EnterArenaFailedMessageParser()
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

