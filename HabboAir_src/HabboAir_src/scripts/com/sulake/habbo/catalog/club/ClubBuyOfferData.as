package com.sulake.habbo.catalog.club
{
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   
   public class ClubBuyOfferData implements UnknownIHabboCatalog1
   {
      private var _offerId:int;
      
      private var _productCode:String;
      
      private var _priceCredits:int;
      
      private var _priceInActivityPoints:int;
      
      private var _activityPointType:int;
      
      private var _vip:Boolean;
      
      private var _months:int;
      
      private var _daysLeftAfterPurchase:int;
      
      private var _page:ICatalogPage;
      
      private var _year:int;
      
      private var _month:int;
      
      private var _day:int;
      
      private var _extraParameter:String;
      
      private var _upgradeHcPeriodToVip:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var _extraDays:int;
      
      private var _isGiftable:Boolean;
      
      public function ClubBuyOfferData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:Boolean = false)
      {
         super();
         _offerId = param1;
         _productCode = param2;
         _priceCredits = param3;
         _priceInActivityPoints = param4;
         _activityPointType = param5;
         _vip = param6;
         _months = param7;
         _extraDays = param8;
         _daysLeftAfterPurchase = param9;
         _year = param10;
         _month = param11;
         _day = param12;
         _isGiftable = param13;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         _page = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get extraParameter() : String
      {
         return _extraParameter;
      }
      
      public function set extraParameter(param1:String) : void
      {
         _extraParameter = param1;
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
      
      public function get isGiftable() : Boolean
      {
         return _isGiftable;
      }
      
      public function get priceInActivityPoints() : int
      {
         return _priceInActivityPoints;
      }
      
      public function get activityPointType() : int
      {
         return _activityPointType;
      }
      
      public function get priceInCredits() : int
      {
         return _priceCredits;
      }
      
      public function get page() : ICatalogPage
      {
         return _page;
      }
      
      public function get priceType() : String
      {
         return "price_type_credits";
      }
      
      public function get productContainer() : IProductContainer
      {
         return null;
      }
      
      public function get product() : IProduct
      {
         return !!productContainer ? productContainer.firstProduct : null;
      }
      
      public function get gridItem() : IProductGridItem
      {
         return null;
      }
      
      public function get localizationId() : String
      {
         return _productCode;
      }
      
      public function set page(param1:ICatalogPage) : void
      {
         _page = param1;
      }
      
      public function get upgradeHcPeriodToVip() : Boolean
      {
         return _upgradeHcPeriodToVip;
      }
      
      public function set upgradeHcPeriodToVip(param1:Boolean) : void
      {
         _upgradeHcPeriodToVip = param1;
      }
      
      public function get extraDays() : int
      {
         return _extraDays;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return false;
      }
      
      public function get isRentOffer() : Boolean
      {
         return false;
      }
      
      public function get giftable() : Boolean
      {
         return _isGiftable;
      }
      
      public function get pricingModel() : String
      {
         return "";
      }
      
      public function set previewCallbackId(param1:int) : void
      {
      }
      
      public function get previewCallbackId() : int
      {
         return 0;
      }
      
      public function get clubLevel() : int
      {
         return 0;
      }
      
      public function get badgeCode() : String
      {
         return "";
      }
      
      public function get extraChatStyleCode() : String
      {
         return "";
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return false;
      }
      
      public function get localizationName() : String
      {
         return "${" + localizationId + "}";
      }
      
      public function get localizationDescription() : String
      {
         return "${" + localizationId + "}";
      }
      
      public function get priceInSilver() : int
      {
         return -1;
      }
      
      public function get priceInEmerald() : int
      {
         return 0;
      }
   }
}

