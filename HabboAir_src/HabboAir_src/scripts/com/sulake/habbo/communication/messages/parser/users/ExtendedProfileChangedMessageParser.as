package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ExtendedProfileChangedMessageParser implements IMessageParser
   {
      private var _userId:int;
      
      public function ExtendedProfileChangedMessageParser()
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
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
   }
}

