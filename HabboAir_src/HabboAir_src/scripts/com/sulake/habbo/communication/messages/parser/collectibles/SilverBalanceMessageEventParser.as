package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SilverBalanceMessageEventParser implements IMessageParser
   {
      private var _silverBalance:int = 0;
      
      public function SilverBalanceMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _silverBalance = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _silverBalance = param1.readInteger();
         return true;
      }
      
      public function get silverBalance() : int
      {
         return _silverBalance;
      }
   }
}

