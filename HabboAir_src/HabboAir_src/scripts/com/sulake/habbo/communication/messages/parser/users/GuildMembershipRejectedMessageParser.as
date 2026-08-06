package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipRejectedMessageParser implements IMessageParser
   {
      private var _guildId:int;
      
      private var _userId:int;
      
      public function GuildMembershipRejectedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _guildId = param1.readInteger();
         _userId = param1.readInteger();
         return true;
      }
      
      public function get guildId() : int
      {
         return _guildId;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}

