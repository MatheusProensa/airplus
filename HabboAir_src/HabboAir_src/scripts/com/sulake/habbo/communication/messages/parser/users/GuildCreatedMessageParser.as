package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildCreatedMessageParser implements IMessageParser
   {
      private var _baseRoomId:int;
      
      private var _groupId:int;
      
      public function GuildCreatedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _baseRoomId = param1.readInteger();
         _groupId = param1.readInteger();
         return true;
      }
      
      public function get baseRoomId() : int
      {
         return _baseRoomId;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
   }
}

