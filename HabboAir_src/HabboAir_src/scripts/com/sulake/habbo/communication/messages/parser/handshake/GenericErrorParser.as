package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GenericErrorParser implements IMessageParser
   {
      private var _errorCode:int;
      
      public function GenericErrorParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _errorCode = param1.readInteger();
         return true;
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
   }
}

