package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MarketplaceCancelOfferResultParser implements IMessageParser
   {
      private var _offerId:int;
      
      private var _success:Boolean;
      
      public function MarketplaceCancelOfferResultParser()
      {
         super();
      }
      
      public function get success() : Boolean
      {
         return _success;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offerId = param1.readInteger();
         _success = param1.readBoolean();
         return true;
      }
   }
}

