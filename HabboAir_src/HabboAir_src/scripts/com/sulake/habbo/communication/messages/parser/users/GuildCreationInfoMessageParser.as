package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.GuildCreationData;
   
   [SecureSWF(rename="true")]
   public class GuildCreationInfoMessageParser implements IMessageParser
   {
      private var _data:GuildCreationData;
      
      public function GuildCreationInfoMessageParser()
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
         _data = new GuildCreationData(param1);
         return true;
      }
      
      public function get data() : GuildCreationData
      {
         return _data;
      }
   }
}

