package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   
   public class GameTokensOffer implements UnknownIHabboCatalog1, IComponentInterfaceQueue
   {
      private var _offerId:int;
      
      private var _localizationId:String;
      
      private var _priceInCredits:int;
      
      private var _priceInActivityPoints:int;
      
      private var _activityPointType:int;
      
      public function GameTokensOffer(param1:int, param2:String, param3:int, param4:int, param5:int)
      {
         super();
         _offerId = param1;
         _localizationId = param2;
         _priceInCredits = param3;
         _priceInActivityPoints = param4;
         _activityPointType = param5;
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get offerId() : int
      {
         return _offerId;
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
         return _priceInCredits;
      }
      
      public function get page() : ICatalogPage
      {
         return null;
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
         return _localizationId;
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
         return false;
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
      
      public function set page(param1:ICatalogPage) : void
      {
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

