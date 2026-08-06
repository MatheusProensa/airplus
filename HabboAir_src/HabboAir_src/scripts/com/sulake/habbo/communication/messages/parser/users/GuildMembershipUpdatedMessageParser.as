package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.MemberData;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipUpdatedMessageParser implements IMessageParser
   {
      private var _guildId:int;
      
      private var _data:MemberData;
      
      public function GuildMembershipUpdatedMessageParser()
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
         _guildId = param1.readInteger();
         _data = new MemberData(param1);
         return true;
      }
      
      public function get guildId() : int
      {
         return _guildId;
      }
      
      public function get data() : MemberData
      {
         return _data;
      }
   }
}

