package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberData;
   
   [SecureSWF(rename="true")]
   public class GuildMembersMessageParser implements IMessageParser
   {
      private var _data:GuildMemberData;
      
      public function GuildMembersMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new GuildMemberData(param1);
         return true;
      }
      
      public function get data() : GuildMemberData
      {
         return _data;
      }
   }
}

