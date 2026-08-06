package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class Game2JoiningGameFailedMessageParser implements IMessageParser
   {
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_2:int = 2;
      
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_3:int = 3;
      
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_4:int = 4;
      
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_5:int = 5;
      
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_6:int = 6;
      
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_7:int = 7;
      
      public static const UnknownConstFromGame2JoiningGameFailedMessageParser_Int_8:int = 8;
      
      private var _reason:int;
      
      public function Game2JoiningGameFailedMessageParser()
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

