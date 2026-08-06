package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeSilverFeeParser implements IMessageParser
   {
      private var _silverFee:int;
      
      public function TradeSilverFeeParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _silverFee = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _silverFee = param1.readInteger();
         return true;
      }
      
      public function get silverFee() : int
      {
         return _silverFee;
      }
   }
}

