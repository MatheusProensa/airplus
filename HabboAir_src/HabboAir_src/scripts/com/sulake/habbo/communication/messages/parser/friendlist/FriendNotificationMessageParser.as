package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendNotificationMessageParser implements IMessageParser
   {
      private var _typeCode:int = -1;
      
      private var _avatarId:String;
      
      private var _message:String;
      
      public function FriendNotificationMessageParser()
      {
         super();
      }
      
      public function get typeCode() : int
      {
         return _typeCode;
      }
      
      public function get avatarId() : String
      {
         return _avatarId;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _avatarId = param1.readString();
         _typeCode = param1.readInteger();
         _message = param1.readString();
         return true;
      }
   }
}

