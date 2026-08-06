package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.MintTokenOffer;
   
   public class MintTokenPurchaseOffer implements UnknownIHabboCatalog1
   {
      internal var UnknownVarFromMintTokenPurchaseOffer_MintTokenOffer_1:MintTokenOffer;
      
      public function MintTokenPurchaseOffer(param1:MintTokenOffer)
      {
         super();
         §_-H2y§ = param1;
      }
      
      public function get offerId() : int
      {
         return §_-H2y§.offerId;
      }
      
      public function get priceInActivityPoints() : int
      {
         return 0;
      }
      
      public function get activityPointType() : int
      {
         return 0;
      }
      
      public function get priceInCredits() : int
      {
         return 0;
      }
      
      public function get priceInSilver() : int
      {
         return §_-H2y§.silverPrice;
      }
      
      public function get page() : ICatalogPage
      {
         return null;
      }
      
      public function get priceType() : String
      {
         return "price_type_silver";
      }
      
      public function get product() : IProduct
      {
         return null;
      }
      
      public function get productContainer() : IProductContainer
      {
         return null;
      }
      
      public function get gridItem() : IProductGridItem
      {
         return null;
      }
      
      public function get localizationId() : String
      {
         return §_-H2y§.productCode;
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
         return "";
      }
      
      public function get localizationDescription() : String
      {
         return "";
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get priceInEmerald() : int
      {
         return 0;
      }
   }
}

