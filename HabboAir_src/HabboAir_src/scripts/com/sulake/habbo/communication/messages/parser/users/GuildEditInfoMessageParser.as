package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditData;
   
   [SecureSWF(rename="true")]
   public class GuildEditInfoMessageParser implements IMessageParser
   {
      private var _data:GuildEditData;
      
      public function GuildEditInfoMessageParser()
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
         _data = new GuildEditData(param1);
         return true;
      }
      
      public function get data() : GuildEditData
      {
         return _data;
      }
   }
}

