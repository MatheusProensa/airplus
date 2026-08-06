package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipsMessageParser implements IMessageParser
   {
      private var _guilds:Array = [];
      
      public function GuildMembershipsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _guilds = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _guilds.push(new HabboGroupEntryData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get guilds() : Array
      {
         return _guilds;
      }
   }
}

