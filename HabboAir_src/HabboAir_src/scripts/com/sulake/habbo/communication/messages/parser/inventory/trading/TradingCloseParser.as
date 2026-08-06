package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradingCloseParser implements IMessageParser
   {
      public static const UnknownConstFromTradingCloseParser_Int_1:int = 1;
      
      private var _userID:int;
      
      private var _reason:int;
      
      public function TradingCloseParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userID = param1.readInteger();
         _reason = param1.readInteger();
         return true;
      }
      
      public function get userID() : int
      {
         return _userID;
      }
      
      public function get reason() : int
      {
         return _reason;
      }
   }
}

