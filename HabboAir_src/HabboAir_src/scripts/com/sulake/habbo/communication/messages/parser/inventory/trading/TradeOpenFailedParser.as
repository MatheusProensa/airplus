package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TradeOpenFailedParser implements IMessageParser
   {
      public static const UnknownConstFromTradeOpenFailedParser_Int_1:int = 7;
      
      public static const UnknownConstFromTradeOpenFailedParser_Int_2:int = 8;
      
      private var _reason:int;
      
      private var _otherUserName:String;
      
      public function TradeOpenFailedParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _reason = param1.readInteger();
         _otherUserName = param1.readString();
         return true;
      }
      
      public function get reason() : int
      {
         return _reason;
      }
      
      public function get otherUserName() : String
      {
         return _otherUserName;
      }
   }
}

