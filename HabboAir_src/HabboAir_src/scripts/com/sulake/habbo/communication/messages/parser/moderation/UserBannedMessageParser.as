package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserBannedMessageParser implements IMessageParser
   {
      private var _message:String;
      
      public function UserBannedMessageParser()
      {
         super();
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function flush() : Boolean
      {
         _message = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _message = param1.readString();
         return true;
      }
   }
}

