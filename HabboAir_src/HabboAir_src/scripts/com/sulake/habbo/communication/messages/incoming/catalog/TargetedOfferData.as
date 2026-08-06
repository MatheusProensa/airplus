package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class TargetedOfferData
   {
      protected var _id:int;
      
      protected var _identifier:String;
      
      protected var _type:int;
      
      protected var _title:String;
      
      protected var _description:String;
      
      protected var _imageUrl:String;
      
      protected var _iconImageUrl:String;
      
      protected var _productCode:String;
      
      protected var _purchaseLimit:int;
      
      protected var _expirationTime:uint;
      
      protected var _priceInCredits:int;
      
      protected var _priceInActivityPoints:int;
      
      protected var _activityPointType:int;
      
      protected var _subProductCodes:Vector.<String>;
      
      protected var _trackingState:int;
      
      public function TargetedOfferData(param1:TargetedOfferData = null)
      {
         super();
         if(param1 != null)
         {
            _id = param1.id;
            _identifier = param1.identifier;
            _type = param1.type;
            _title = param1.title;
            _description = param1.description;
            _imageUrl = param1.imageUrl;
            _iconImageUrl = param1.iconImageUrl;
            _productCode = param1.productCode;
            _purchaseLimit = param1.purchaseLimit;
            _expirationTime = param1.expirationTime;
            _priceInCredits = param1.priceInCredits;
            _priceInActivityPoints = param1.priceInActivityPoints;
            _activityPointType = param1.activityPointType;
            _subProductCodes = param1.subProductCodes;
            _trackingState = param1.trackingState;
         }
      }
      
      public function parse(param1:IMessageDataWrapper) : TargetedOfferData
      {
         var _loc3_:int = 0;
         _trackingState = param1.readInteger();
         _id = param1.readInteger();
         _identifier = param1.readString();
         _productCode = param1.readString();
         _priceInCredits = param1.readInteger();
         _priceInActivityPoints = param1.readInteger();
         _activityPointType = param1.readInteger();
         _purchaseLimit = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _expirationTime = _loc2_ > 0 ? _loc2_ * 1000 + getTimer() : 0;
         _title = param1.readString();
         _description = param1.readString();
         _imageUrl = param1.readString();
         _iconImageUrl = param1.readString();
         _type = param1.readInteger();
         _subProductCodes = new Vector.<String>(0);
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _subProductCodes.push(param1.readString());
            _loc3_++;
         }
         return this;
      }
      
      public function purchased(param1:int) : void
      {
         _purchaseLimit -= param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get identifier() : String
      {
         return _identifier;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get imageUrl() : String
      {
         return _imageUrl;
      }
      
      public function get iconImageUrl() : String
      {
         return _iconImageUrl;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get purchaseLimit() : int
      {
         return _purchaseLimit;
      }
      
      public function get expirationTime() : int
      {
         return _expirationTime;
      }
      
      public function get priceInCredits() : int
      {
         return _priceInCredits;
      }
      
      public function get priceInActivityPoints() : int
      {
         return _priceInActivityPoints;
      }
      
      public function get activityPointType() : int
      {
         return _activityPointType;
      }
      
      public function get subProductCodes() : Vector.<String>
      {
         return _subProductCodes;
      }
      
      public function get trackingState() : int
      {
         return _trackingState;
      }
   }
}

