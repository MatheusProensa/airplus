package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LimitedOfferAppearingNextMessageParser implements IMessageParser
   {
      private var _appearsInSeconds:int;
      
      private var _pageId:int;
      
      private var _offerId:int;
      
      private var _productType:String;
      
      public function LimitedOfferAppearingNextMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _appearsInSeconds = -1;
         _pageId = -1;
         _offerId = -1;
         _productType = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _appearsInSeconds = param1.readInteger();
         _pageId = param1.readInteger();
         _offerId = param1.readInteger();
         _productType = param1.readString();
         return true;
      }
      
      public function get appearsInSeconds() : int
      {
         return _appearsInSeconds;
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productType() : String
      {
         return _productType;
      }
   }
}

