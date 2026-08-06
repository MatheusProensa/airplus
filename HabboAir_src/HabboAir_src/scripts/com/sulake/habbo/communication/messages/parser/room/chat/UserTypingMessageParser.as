package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserTypingMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _isTyping:Boolean = false;
      
      public function UserTypingMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get isTyping() : Boolean
      {
         return _isTyping;
      }
      
      public function flush() : Boolean
      {
         _userId = 0;
         _isTyping = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         _isTyping = param1.readInteger() == 1;
         return true;
      }
   }
}

