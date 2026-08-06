package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IgnoreResultMessageParser implements IMessageParser
   {
      private var _result:int;
      
      private var _ignoredUserId:int;
      
      public function IgnoreResultMessageParser()
      {
         super();
         _result = -1;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _result = param1.readInteger();
         _ignoredUserId = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function get ignoredUserId() : int
      {
         return _ignoredUserId;
      }
   }
}

