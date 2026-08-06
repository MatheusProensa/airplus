package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ClubOfferData
   {
      private var _offerId:int;
      
      private var _productCode:String;
      
      private var _priceCredits:int;
      
      private var _priceActivityPoints:int;
      
      private var _priceActivityPointType:int;
      
      private var _vip:Boolean;
      
      private var _months:int;
      
      private var _extraDays:int;
      
      private var _daysLeftAfterPurchase:int;
      
      private var _year:int;
      
      private var _month:int;
      
      private var _day:int;
      
      private var _isGiftable:Boolean;
      
      public function ClubOfferData(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         _productCode = param1.readString();
         param1.readBoolean();
         _priceCredits = param1.readInteger();
         _priceActivityPoints = param1.readInteger();
         _priceActivityPointType = param1.readInteger();
         _vip = param1.readBoolean();
         _months = param1.readInteger();
         _extraDays = param1.readInteger();
         _isGiftable = param1.readBoolean();
         _daysLeftAfterPurchase = param1.readInteger();
         _year = param1.readInteger();
         _month = param1.readInteger();
         _day = param1.readInteger();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get priceCredits() : int
      {
         return _priceCredits;
      }
      
      public function get vip() : Boolean
      {
         return _vip;
      }
      
      public function get months() : int
      {
         return _months;
      }
      
      public function get extraDays() : int
      {
         return _extraDays;
      }
      
      public function get daysLeftAfterPurchase() : int
      {
         return _daysLeftAfterPurchase;
      }
      
      public function get year() : int
      {
         return _year;
      }
      
      public function get month() : int
      {
         return _month;
      }
      
      public function get day() : int
      {
         return _day;
      }
      
      public function get priceActivityPoints() : int
      {
         return _priceActivityPoints;
      }
      
      public function get priceActivityPointType() : int
      {
         return _priceActivityPointType;
      }
      
      public function get isGiftable() : Boolean
      {
         return _isGiftable;
      }
   }
}

