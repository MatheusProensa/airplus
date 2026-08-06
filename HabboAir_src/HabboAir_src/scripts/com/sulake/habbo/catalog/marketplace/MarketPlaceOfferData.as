package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class MarketPlaceOfferData implements IMarketPlaceOfferData
   {
      public static const UnknownConstFromPresentFurniWidget_String_1:int = 1;
      
      public static const UnknownConstFromRoomPlane_Int_2:int = 2;
      
      private var _offerId:int;
      
      private var _furniId:int;
      
      private var _furniType:int;
      
      private var _extraData:String;
      
      private var _stuffData:IStuffData;
      
      private var _price:int;
      
      private var _averagePrice:int;
      
      private var _imageCallback:int;
      
      private var _status:int;
      
      private var _timeLeftMinutes:int = -1;
      
      private var _offerCount:int;
      
      private var _image:BitmapData;
      
      private var _statusTime:Number = NaN;
      
      private var _isUsable:Boolean;
      
      private var _isUsed:Boolean;
      
      public function MarketPlaceOfferData(param1:int, param2:int, param3:int, param4:String, param5:IStuffData, param6:int, param7:int, param8:int, param9:int = -1, param10:Boolean = false, param11:Boolean = false)
      {
         super();
         _offerId = param1;
         _furniId = param2;
         _furniType = param3;
         _extraData = param4;
         _stuffData = param5;
         _price = param6;
         _status = param7;
         _averagePrice = param8;
         _offerCount = param9;
         _isUsable = param10;
         _isUsed = param11;
      }
      
      public function dispose() : void
      {
         if(_image)
         {
            _image.dispose();
            _image = null;
         }
         if(_stuffData)
         {
            _stuffData = null;
         }
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
      
      public function get averagePrice() : int
      {
         return _averagePrice;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function set image(param1:BitmapData) : void
      {
         if(_image != null)
         {
            _image.dispose();
         }
         _image = param1;
      }
      
      public function set imageCallback(param1:int) : void
      {
         _imageCallback = param1;
      }
      
      public function get imageCallback() : int
      {
         return _imageCallback;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get timeLeftMinutes() : int
      {
         return _timeLeftMinutes;
      }
      
      public function set timeLeftMinutes(param1:int) : void
      {
         _timeLeftMinutes = param1;
      }
      
      public function get statusTime() : Number
      {
         return _statusTime;
      }
      
      public function set statusTime(param1:Number) : void
      {
         _statusTime = param1;
      }
      
      public function set price(param1:int) : void
      {
         _price = param1;
      }
      
      public function set offerId(param1:int) : void
      {
         _offerId = param1;
      }
      
      public function get offerCount() : int
      {
         return _offerCount;
      }
      
      public function set offerCount(param1:int) : void
      {
         _offerCount = param1;
      }
      
      public function get isUniqueLimitedItem() : Boolean
      {
         return stuffData != null && stuffData.uniqueSerialNumber > 0;
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

