package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildEditFailedMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildEditFailedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildEditFailedMessageEvent(param1:Function)
      {
         super(param1,GuildEditFailedMessageParser);
      }
      
      public function get reason() : int
      {
         return GuildEditFailedMessageParser(_parser).reason;
      }
   }
}

