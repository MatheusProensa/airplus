package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InClientLinkMessageParser implements IMessageParser
   {
      private var _link:String;
      
      public function InClientLinkMessageParser()
      {
         super();
      }
      
      public function get link() : String
      {
         return _link;
      }
      
      public function flush() : Boolean
      {
         _link = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _link = param1.readString();
         return true;
      }
   }
}

