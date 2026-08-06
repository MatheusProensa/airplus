package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditorData;
   
   [SecureSWF(rename="true")]
   public class GuildEditorDataMessageParser implements IMessageParser
   {
      private var _data:GuildEditorData;
      
      public function GuildEditorDataMessageParser()
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
         _data = new GuildEditorData(param1);
         return true;
      }
      
      public function get data() : GuildEditorData
      {
         return _data;
      }
   }
}

