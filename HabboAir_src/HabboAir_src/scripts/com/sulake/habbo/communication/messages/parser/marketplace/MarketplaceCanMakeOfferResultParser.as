package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceCanMakeOfferResultParser implements IMessageParser
   {
      private var _tokenCount:int;
      
      private var _resultCode:int;
      
      public function MarketplaceCanMakeOfferResultParser()
      {
         super();
      }
      
      public function get tokenCount() : int
      {
         return _tokenCount;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _resultCode = param1.readInteger();
         _tokenCount = param1.readInteger();
         return true;
      }
   }
}

