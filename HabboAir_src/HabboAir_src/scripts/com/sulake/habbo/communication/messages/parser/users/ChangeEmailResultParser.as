package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChangeEmailResultParser implements IMessageParser
   {
      public static const UnknownConstFromChangeEmailResultParser_Int_1:int = 0;
      
      private var _result:int;
      
      public function ChangeEmailResultParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _result = param1.readInteger();
         return true;
      }
      
      public function get result() : int
      {
         return _result;
      }
   }
}

