package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class PlacedObjectPurchaseData implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var _objectId:int;
      
      private var _category:int;
      
      private var _roomId:int;
      
      private var _wallLocation:String = "";
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _direction:int = 0;
      
      private var _offerId:int;
      
      private var _productClassId:int;
      
      private var UnknownVarFromPlacedObjectPurchaseData_IProductData_1:IProductData;
      
      private var _furniData:IFurnitureData;
      
      private var _extraParameter:String;
      
      public function PlacedObjectPurchaseData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:UnknownIHabboCatalog1)
      {
         super();
         _roomId = param1;
         _objectId = param2;
         _category = param3;
         _wallLocation = param4;
         _x = param5;
         _y = param6;
         _direction = param7;
         setOfferData(param8);
      }
      
      public function dispose() : void
      {
         _disposed = true;
         UnknownVarFromPlacedObjectPurchaseData_IProductData_1 = null;
         _furniData = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function setOfferData(param1:UnknownIHabboCatalog1) : void
      {
         _offerId = param1.offerId;
         _productClassId = param1.product.productClassId;
         UnknownVarFromPlacedObjectPurchaseData_IProductData_1 = param1.product.productData;
         _furniData = param1.product.furnitureData;
         _extraParameter = param1.product.extraParam;
      }
      
      public function toString() : String
      {
         return [_roomId,_objectId,_category,_wallLocation,_x,_y,_direction,_offerId,_productClassId].toString();
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get wallLocation() : String
      {
         return _wallLocation;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productClassId() : int
      {
         return _productClassId;
      }
      
      public function get extraParameter() : String
      {
         return _extraParameter;
      }
      
      public function get furniData() : IFurnitureData
      {
         return _furniData;
      }
   }
}

