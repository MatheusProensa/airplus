package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameChatFromPlayerMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      private var _chatMessage:String;
      
      public function Game2GameChatFromPlayerMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _userId = -1;
         _chatMessage = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         _chatMessage = param1.readString();
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get chatMessage() : String
      {
         return _chatMessage;
      }
   }
}

