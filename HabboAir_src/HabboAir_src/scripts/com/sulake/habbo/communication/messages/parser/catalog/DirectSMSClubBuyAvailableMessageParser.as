package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DirectSMSClubBuyAvailableMessageParser implements IMessageParser
   {
      private var _available:Boolean;
      
      private var _pricePointUrl:String;
      
      private var _market:String;
      
      private var _lengthInDays:int;
      
      public function DirectSMSClubBuyAvailableMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _available = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _pricePointUrl = param1.readString();
         if(_pricePointUrl != "")
         {
            _available = true;
         }
         _market = param1.readString();
         _lengthInDays = param1.readInteger();
         return true;
      }
      
      public function get available() : Boolean
      {
         return _available;
      }
      
      public function get pricePointUrl() : String
      {
         return _pricePointUrl;
      }
      
      public function get market() : String
      {
         return _market;
      }
      
      public function get lengthInDays() : int
      {
         return _lengthInDays;
      }
   }
}

