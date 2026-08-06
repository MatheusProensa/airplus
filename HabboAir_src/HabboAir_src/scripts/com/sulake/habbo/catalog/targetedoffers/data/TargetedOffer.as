package com.sulake.habbo.catalog.targetedoffers.data
{
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferData;
   import com.sulake.habbo.session.product.IProductData;
   import flash.utils.getTimer;
   
   public class TargetedOffer extends TargetedOfferData implements UnknownIHabboCatalog1
   {
      public static const UnknownConstFromTargetedOffer_Int_1:int = 10;
      
      public function TargetedOffer(param1:TargetedOfferData = null)
      {
         super(param1);
      }
      
      public function get offerId() : int
      {
         return 0;
      }
      
      public function get page() : ICatalogPage
      {
         return null;
      }
      
      public function set page(param1:ICatalogPage) : void
      {
      }
      
      public function get priceType() : String
      {
         return "";
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
         return "";
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
      
      public function get previewCallbackId() : int
      {
         return 0;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
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
         return "";
      }
      
      public function get localizationDescription() : String
      {
         return "";
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function isExpired() : Boolean
      {
         return _expirationTime > 0 && getSecondsRemaining() <= 0;
      }
      
      public function getSecondsRemaining() : int
      {
         var _loc1_:uint = (_expirationTime - getTimer()) / 1000 - 10;
         return Math.max(0,_loc1_);
      }
      
      public function checkPurseBalance(param1:IPurse, param2:int) : Boolean
      {
         if(!param1 || param1.credits < _priceInCredits * param2)
         {
            return false;
         }
         if(param1.getActivityPointsForType(_activityPointType) < _priceInActivityPoints * param2)
         {
            return false;
         }
         return true;
      }
      
      public function getLocalizedSubProductNames(param1:IHabboCatalog) : Vector.<String>
      {
         var _loc4_:IProductData = null;
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         for each(var _loc3_ in _subProductCodes)
         {
            _loc4_ = param1.getProductData(_loc3_);
            _loc2_.push(!!_loc4_ ? _loc4_.name : _loc3_);
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
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

