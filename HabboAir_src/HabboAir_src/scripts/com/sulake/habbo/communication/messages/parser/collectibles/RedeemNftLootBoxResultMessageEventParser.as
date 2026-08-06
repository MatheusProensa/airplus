package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RedeemNftLootBoxResultMessageEventParser implements IMessageParser
   {
      private var _resultCode:*;
      
      public function RedeemNftLootBoxResultMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _resultCode = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _resultCode = param1.readShort();
         return true;
      }
      
      public function get success() : Boolean
      {
         return _resultCode == 0;
      }
      
      public function get fail() : Boolean
      {
         return _resultCode == 1;
      }
      
      public function get notInStarDustWallet() : Boolean
      {
         return _resultCode == 2;
      }
      
      public function get resultCode() : *
      {
         return _resultCode;
      }
   }
}

