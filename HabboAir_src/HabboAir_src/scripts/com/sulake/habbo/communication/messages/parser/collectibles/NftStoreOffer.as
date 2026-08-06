package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class NftStoreOffer
   {
      private var _productCode:String;
      
      private var _emeraldPrice:int;
      
      private var _isFeatured:Boolean;
      
      private var _isLimited:Boolean;
      
      private var _mintLimit:int;
      
      private var _mintedCount:int;
      
      private var _productInfo:CollectibleBaseItem;
      
      public function NftStoreOffer(param1:IMessageDataWrapper)
      {
         super();
         _productCode = param1.readString();
         _emeraldPrice = param1.readInteger();
         _isFeatured = param1.readBoolean();
         _isLimited = param1.readBoolean();
         _mintLimit = param1.readInteger();
         _mintedCount = param1.readInteger();
         _productInfo = new CollectibleBaseItem(param1);
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get emeraldPrice() : int
      {
         return _emeraldPrice;
      }
      
      public function get isFeatured() : Boolean
      {
         return _isFeatured;
      }
      
      public function get isLimited() : Boolean
      {
         return _isLimited;
      }
      
      public function get mintLimit() : int
      {
         return _mintLimit;
      }
      
      public function get mintedCount() : int
      {
         return _mintedCount;
      }
      
      public function get productInfo() : CollectibleBaseItem
      {
         return _productInfo;
      }
   }
}

