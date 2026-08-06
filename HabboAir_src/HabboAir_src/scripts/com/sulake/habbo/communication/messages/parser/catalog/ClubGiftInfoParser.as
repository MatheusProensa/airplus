package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
   
   [SecureSWF(rename="true")]
   public class ClubGiftInfoParser implements IMessageParser
   {
      private var _daysUntilNextGift:int;
      
      private var _giftsAvailable:int;
      
      private var _offers:Array;
      
      private var _giftData:Map;
      
      public function ClubGiftInfoParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_giftData)
         {
            _giftData.dispose();
            _giftData = null;
         }
         _offers = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:ClubGiftData = null;
         _daysUntilNextGift = param1.readInteger();
         _giftsAvailable = param1.readInteger();
         _offers = [];
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _offers.push(new CatalogPageMessageOfferData(param1));
            _loc4_++;
         }
         _giftData = new Map();
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new ClubGiftData(param1);
            _giftData.add(_loc2_.offerId,_loc2_);
            _loc4_++;
         }
         return true;
      }
      
      public function get daysUntilNextGift() : int
      {
         return _daysUntilNextGift;
      }
      
      public function get giftsAvailable() : int
      {
         return _giftsAvailable;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get giftData() : Map
      {
         return _giftData;
      }
   }
}

