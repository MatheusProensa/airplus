package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildEditorDataMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildEditorDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function GuildEditorDataMessageEvent(param1:Function)
      {
         super(param1,GuildEditorDataMessageParser);
      }
      
      public function get data() : GuildEditorData
      {
         return GuildEditorDataMessageParser(_parser).data;
      }
   }
}

