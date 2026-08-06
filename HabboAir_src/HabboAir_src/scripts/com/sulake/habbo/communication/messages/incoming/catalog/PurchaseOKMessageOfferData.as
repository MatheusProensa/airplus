package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class PurchaseOKMessageOfferData
   {
      private var _offerId:int;
      
      private var _localizationId:String;
      
      private var _isRent:Boolean;
      
      private var _priceInCredits:int;
      
      private var _priceInActivityPoints:int;
      
      private var _activityPointType:int;
      
      private var _clubLevel:int;
      
      private var _giftable:Boolean;
      
      private var _bundlePurchaseAllowed:Boolean;
      
      private var _products:Vector.<CatalogPageMessageProductData>;
      
      public function PurchaseOKMessageOfferData(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         super();
         _offerId = param1.readInteger();
         _localizationId = param1.readString();
         _isRent = param1.readBoolean();
         _priceInCredits = param1.readInteger();
         _priceInActivityPoints = param1.readInteger();
         _activityPointType = param1.readInteger();
         _giftable = param1.readBoolean();
         var _loc3_:int = param1.readInteger();
         _products = new Vector.<CatalogPageMessageProductData>(0);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _products.push(new CatalogPageMessageProductData(param1));
            _loc2_++;
         }
         _clubLevel = param1.readInteger();
         _bundlePurchaseAllowed = param1.readBoolean();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get localizationId() : String
      {
         return _localizationId;
      }
      
      public function get isRent() : Boolean
      {
         return _isRent;
      }
      
      public function get priceInCredits() : int
      {
         return _priceInCredits;
      }
      
      public function get priceInActivityPoints() : int
      {
         return _priceInActivityPoints;
      }
      
      public function get products() : Vector.<CatalogPageMessageProductData>
      {
         return _products;
      }
      
      public function get activityPointType() : int
      {
         return _activityPointType;
      }
      
      public function get clubLevel() : int
      {
         return _clubLevel;
      }
      
      public function get giftable() : Boolean
      {
         return _giftable;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return _bundlePurchaseAllowed;
      }
   }
}

