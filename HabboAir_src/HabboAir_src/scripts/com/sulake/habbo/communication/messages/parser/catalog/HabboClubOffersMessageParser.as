package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferData;
   
   [SecureSWF(rename="true")]
   public class HabboClubOffersMessageParser implements IMessageParser
   {
      private var _offers:Array;
      
      private var _source:int;
      
      public function HabboClubOffersMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offers = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _offers = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _offers.push(new ClubOfferData(param1));
            _loc3_++;
         }
         _source = param1.readInteger();
         return true;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get source() : int
      {
         return _source;
      }
   }
}

