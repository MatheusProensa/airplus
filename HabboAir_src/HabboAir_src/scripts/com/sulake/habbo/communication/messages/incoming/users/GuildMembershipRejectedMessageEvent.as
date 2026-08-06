package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMembershipRejectedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipRejectedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildMembershipRejectedMessageEvent(param1:Function)
      {
         super(param1,GuildMembershipRejectedMessageParser);
      }
      
      public function getParser() : GuildMembershipRejectedMessageParser
      {
         return GuildMembershipRejectedMessageParser(_parser);
      }
   }
}

