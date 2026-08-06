package com.sulake.habbo.communication.messages.parser.inventory.purse
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CreditBalanceParser implements IMessageParser
   {
      private var _balance:int;
      
      public function CreditBalanceParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _balance = int(param1.readString());
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get balance() : int
      {
         return _balance;
      }
   }
}

