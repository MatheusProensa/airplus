package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildEditInfoMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildEditInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildEditInfoMessageEvent(param1:Function)
      {
         super(param1,GuildEditInfoMessageParser);
      }
      
      public function get data() : GuildEditData
      {
         return GuildEditInfoMessageParser(_parser).data;
      }
   }
}

