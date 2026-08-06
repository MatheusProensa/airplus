package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BlockUserUpdateMessageParser implements IMessageParser
   {
      private var _result:int;
      
      private var _userId:int;
      
      public function BlockUserUpdateMessageParser()
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
         _userId = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}

