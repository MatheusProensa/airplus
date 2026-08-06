package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMemberMgmtFailedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMemberMgmtFailedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildMemberMgmtFailedMessageEvent(param1:Function)
      {
         super(param1,GuildMemberMgmtFailedMessageParser);
      }
      
      public function get reason() : int
      {
         return GuildMemberMgmtFailedMessageParser(_parser).reason;
      }
      
      public function get guildId() : int
      {
         return GuildMemberMgmtFailedMessageParser(_parser).guildId;
      }
   }
}

