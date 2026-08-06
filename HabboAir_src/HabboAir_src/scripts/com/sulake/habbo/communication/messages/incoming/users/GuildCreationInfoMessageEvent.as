package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildCreationInfoMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildCreationInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildCreationInfoMessageEvent(param1:Function)
      {
         super(param1,GuildCreationInfoMessageParser);
      }
      
      public function get data() : GuildCreationData
      {
         return GuildCreationInfoMessageParser(_parser).data;
      }
   }
}

