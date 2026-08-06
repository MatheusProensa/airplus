package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMembersMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembersMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildMembersMessageEvent(param1:Function)
      {
         super(param1,GuildMembersMessageParser);
      }
      
      public function get data() : GuildMemberData
      {
         return GuildMembersMessageParser(_parser).data;
      }
   }
}

