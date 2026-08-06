package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CatalogPageMessageProductData
   {
      public static const PRODUCT_TYPE_ITEM:String = "i";
      
      public static const PRODUCT_TYPE_STUFF:String = "s";
      
      public static const PRODUCT_TYPE_EFFECT:String = "e";
      
      public static const PRODUCT_TYPE_BADGE:String = "b";
      
      public static const UnknownConstFromCatalogPageMessageProductData_String_1:String = "cl";
      
      private var _productType:String;
      
      private var _furniClassId:int;
      
      private var _extraParam:String;
      
      private var _productCount:int;
      
      private var _uniqueLimitedItem:Boolean;
      
      private var _uniqueLimitedItemSeriesSize:int;
      
      private var _uniqueLimitedItemsLeft:int;
      
      public function CatalogPageMessageProductData(param1:IMessageDataWrapper)
      {
         super();
         _productType = param1.readString();
         var _loc2_:String = _productType;
         if("b" !== _loc2_)
         {
            _furniClassId = param1.readInteger();
            _extraParam = param1.readString();
            _productCount = param1.readInteger();
            _uniqueLimitedItem = param1.readBoolean();
            if(_uniqueLimitedItem)
            {
               _uniqueLimitedItemSeriesSize = param1.readInteger();
               _uniqueLimitedItemsLeft = param1.readInteger();
            }
         }
         else
         {
            _extraParam = param1.readString();
            _productCount = 1;
         }
      }
      
      public function get productType() : String
      {
         return _productType;
      }
      
      public function get furniClassId() : int
      {
         return _furniClassId;
      }
      
      public function get extraParam() : String
      {
         return _extraParam;
      }
      
      public function get productCount() : int
      {
         return _productCount;
      }
      
      public function get uniqueLimitedItem() : Boolean
      {
         return _uniqueLimitedItem;
      }
      
      public function get uniqueLimitedItemSeriesSize() : int
      {
         return _uniqueLimitedItemSeriesSize;
      }
      
      public function get uniqueLimitedItemsLeft() : int
      {
         return _uniqueLimitedItemsLeft;
      }
   }
}

