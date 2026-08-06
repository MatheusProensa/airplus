package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IsOfferGiftableMessageParser implements IMessageParser
   {
      private var _offerId:int;
      
      private var _isGiftable:Boolean;
      
      public function IsOfferGiftableMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offerId = param1.readInteger();
         _isGiftable = param1.readBoolean();
         return true;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get isGiftable() : Boolean
      {
         return _isGiftable;
      }
   }
}

