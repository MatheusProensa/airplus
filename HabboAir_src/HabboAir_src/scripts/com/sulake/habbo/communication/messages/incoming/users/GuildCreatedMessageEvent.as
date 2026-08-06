package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildCreatedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildCreatedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildCreatedMessageEvent(param1:Function)
      {
         super(param1,GuildCreatedMessageParser);
      }
      
      public function get baseRoomId() : int
      {
         return GuildCreatedMessageParser(_parser).baseRoomId;
      }
      
      public function get groupId() : int
      {
         return GuildCreatedMessageParser(_parser).groupId;
      }
   }
}

