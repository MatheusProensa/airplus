package com.sulake.habbo.communication.messages.incoming.marketplace
{
   import com.sulake.habbo.room.IStuffData;
   
   [SecureSWF(rename="true")]
   public class MarketPlaceOffer
   {
      private var _offerId:int;
      
      private var _furniId:int;
      
      private var _furniType:int;
      
      private var _extraData:String;
      
      private var _stuffData:IStuffData;
      
      private var _price:int;
      
      private var _status:int;
      
      private var _timeLeftMinutes:int = -1;
      
      private var _averagePrice:int;
      
      private var _offerCount:int;
      
      private var _statusTime:Number;
      
      private var _isUsable:Boolean;
      
      private var _isUsed:Boolean;
      
      public function MarketPlaceOffer(param1:int, param2:int, param3:int, param4:String, param5:IStuffData, param6:int, param7:int, param8:int, param9:int, param10:int = -1, param11:Number = NaN, param12:Boolean = false, param13:Boolean = false)
      {
         super();
         _offerId = param1;
         _furniId = param2;
         _furniType = param3;
         _extraData = param4;
         _stuffData = param5;
         _price = param6;
         _status = param7;
         _timeLeftMinutes = param8;
         _averagePrice = param9;
         _offerCount = param10;
         _statusTime = param11;
         _isUsable = param12;
         _isUsed = param13;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get furniType() : int
      {
         return _furniType;
      }
      
      public function get extraData() : String
      {
         return _extraData;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get timeLeftMinutes() : int
      {
         return _timeLeftMinutes;
      }
      
      public function get averagePrice() : int
      {
         return _averagePrice;
      }
      
      public function get offerCount() : int
      {
         return _offerCount;
      }
      
      public function get statusTime() : Number
      {
         return _statusTime;
      }
      
      public function get isUsable() : Boolean
      {
         return _isUsable;
      }
      
      public function get isUsed() : Boolean
      {
         return _isUsed;
      }
   }
}

