package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class FrontPageItem
   {
      public static const UnknownConstFromFrontPageItem_Int_1:int = 0;
      
      public static const UnknownConstFromFrontPageItem_Int_2:int = 1;
      
      public static const UnknownConstFromFrontPageItem_Int_3:int = 2;
      
      private var _type:int;
      
      private var _position:int;
      
      private var _itemName:String;
      
      private var _itemPromoImage:String;
      
      private var _cataloguePageLocation:String;
      
      private var _productCode:String;
      
      private var _productOfferID:int;
      
      private var _expirationTime:int;
      
      public function FrontPageItem(param1:IMessageDataWrapper)
      {
         super();
         if(!param1)
         {
            return;
         }
         _position = param1.readInteger();
         _itemName = param1.readString();
         _itemPromoImage = param1.readString();
         _type = param1.readInteger();
         switch(_type)
         {
            case 0:
               _cataloguePageLocation = param1.readString();
               break;
            case 1:
               _productOfferID = param1.readInteger();
               break;
            case 2:
               _productCode = param1.readString();
         }
         var _loc2_:int = param1.readInteger();
         _expirationTime = _loc2_ > 0 ? _loc2_ * 1000 + getTimer() : 0;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function get itemName() : String
      {
         return _itemName;
      }
      
      public function get itemPromoImage() : String
      {
         return _itemPromoImage;
      }
      
      public function get cataloguePageLocation() : String
      {
         return _cataloguePageLocation;
      }
      
      public function get offerExpires() : Boolean
      {
         return _expirationTime > 0;
      }
      
      public function get secondsToExpiration() : int
      {
         return _expirationTime - getTimer();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get productOfferID() : int
      {
         return _productOfferID;
      }
   }
}

