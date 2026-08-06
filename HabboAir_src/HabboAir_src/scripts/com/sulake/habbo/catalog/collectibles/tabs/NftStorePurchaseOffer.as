package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleBaseItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftStoreOffer;
   
   public class NftStorePurchaseOffer implements UnknownIHabboCatalog1
   {
      private var UnknownVarFromNftStorePurchaseOffer_NftStoreOffer_1:NftStoreOffer;
      
      public function NftStorePurchaseOffer(param1:NftStoreOffer)
      {
         super();
         UnknownVarFromNftStorePurchaseOffer_NftStoreOffer_1 = param1;
      }
      
      public function get offerId() : int
      {
         return 0;
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
         return 0;
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
         return UnknownVarFromNftStorePurchaseOffer_NftStoreOffer_1.productCode;
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
      
      public function get productCode() : String
      {
         return UnknownVarFromNftStorePurchaseOffer_NftStoreOffer_1.productCode;
      }
      
      public function get priceInEmerald() : int
      {
         return UnknownVarFromNftStorePurchaseOffer_NftStoreOffer_1.emeraldPrice;
      }
      
      public function get productInfo() : CollectibleBaseItem
      {
         return UnknownVarFromNftStorePurchaseOffer_NftStoreOffer_1.productInfo;
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get extraChatStyleCode() : String
      {
         return "";
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return false;
      }
   }
}

