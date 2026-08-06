package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMemberFurniCountInHQMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      private var _furniCount:int;
      
      public function GuildMemberFurniCountInHQMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         _furniCount = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get furniCount() : int
      {
         return _furniCount;
      }
   }
}

