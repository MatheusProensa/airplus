package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class EmeraldBalanceMessageEventParser implements IMessageParser
   {
      private var _emeraldBalance:int = 0;
      
      public function EmeraldBalanceMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _emeraldBalance = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _emeraldBalance = param1.readInteger();
         return true;
      }
      
      public function get emeraldBalance() : int
      {
         return _emeraldBalance;
      }
   }
}

