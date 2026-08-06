package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AccountSafetyLockStatusChangeMessageParser implements IMessageParser
   {
      public static const UnknownConstFromAccountSafetyLockStatusChangeMessageParser_Int_1:int = 0;
      
      public static const UnknownConstFromAccountSafetyLockStatusChangeMessageParser_Int_2:int = 1;
      
      private var _status:int;
      
      public function AccountSafetyLockStatusChangeMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _status = param1.readInteger();
         return true;
      }
      
      public function get status() : int
      {
         return _status;
      }
   }
}

