package com.sulake.habbo.communication.messages.parser.gifts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TryPhoneNumberResultParser implements IMessageParser
   {
      private var _resultCode:int;
      
      private var _millisToAllowProcessReset:int;
      
      public function TryPhoneNumberResultParser()
      {
         super();
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get millisToAllowProcessReset() : int
      {
         return _millisToAllowProcessReset;
      }
      
      public function flush() : Boolean
      {
         _resultCode = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _resultCode = param1.readInteger();
         _millisToAllowProcessReset = param1.readInteger();
         return true;
      }
   }
}

