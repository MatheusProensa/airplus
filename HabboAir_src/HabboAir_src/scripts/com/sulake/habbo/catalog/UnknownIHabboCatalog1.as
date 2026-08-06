package com.sulake.habbo.catalog
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   
   public interface UnknownIHabboCatalog1 extends IComponentInterfaceQueue
   {
      function get offerId() : int;
      
      function get priceInActivityPoints() : int;
      
      function get activityPointType() : int;
      
      function get priceInCredits() : int;
      
      function get priceInSilver() : int;
      
      function get priceInEmerald() : int;
      
      function get page() : ICatalogPage;
      
      function get priceType() : String;
      
      function get product() : IProduct;
      
      function get productContainer() : IProductContainer;
      
      function get gridItem() : IProductGridItem;
      
      function get localizationId() : String;
      
      function get bundlePurchaseAllowed() : Boolean;
      
      function get isRentOffer() : Boolean;
      
      function get giftable() : Boolean;
      
      function get pricingModel() : String;
      
      function set previewCallbackId(param1:int) : void;
      
      function get previewCallbackId() : int;
      
      function get clubLevel() : int;
      
      function get badgeCode() : String;
      
      function get extraChatStyleCode() : String;
      
      function get isSingleChatStyle() : Boolean;
      
      function set page(param1:ICatalogPage) : void;
      
      function get localizationName() : String;
      
      function get localizationDescription() : String;
   }
}

