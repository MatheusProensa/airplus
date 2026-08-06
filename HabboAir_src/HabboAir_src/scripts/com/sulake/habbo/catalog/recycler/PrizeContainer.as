package com.sulake.habbo.catalog.recycler
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class PrizeContainer extends PrizeGridItem
   {
      private var _productItemType:String;
      
      private var _productItemTypeId:int;
      
      private var _oddsLevelId:int;
      
      private var UnknownVarFromPrizeContainer_IFurnitureData_1:IFurnitureData;
      
      private var _gridItem:PrizeGridItem;
      
      public function PrizeContainer(param1:String, param2:int, param3:IFurnitureData, param4:int, param5:HabboCatalog)
      {
         super(param5);
         _productItemType = param1;
         _productItemTypeId = param2;
         UnknownVarFromPrizeContainer_IFurnitureData_1 = param3;
         _oddsLevelId = param4;
      }
      
      public function setIcon(param1:IRoomEngine) : void
      {
         if(param1 == null)
         {
            return;
         }
         initProductIcon(param1,_productItemType,_productItemTypeId);
      }
      
      public function get productItemType() : String
      {
         return _productItemType;
      }
      
      public function get productItemTypeId() : int
      {
         return _productItemTypeId;
      }
      
      public function get gridItem() : PrizeGridItem
      {
         return _gridItem;
      }
      
      public function get oddsLevelId() : int
      {
         return _oddsLevelId;
      }
      
      public function get title() : String
      {
         var _loc1_:IProductData = null;
         if(UnknownVarFromPrizeContainer_IFurnitureData_1 == null)
         {
            _loc1_ = null;
            if(_productItemType == "chat_style")
            {
               _loc1_ = catalog.getProductData("chat_bubble_" + productItemTypeId);
            }
            return _loc1_ != null ? _loc1_.name : "";
         }
         return UnknownVarFromPrizeContainer_IFurnitureData_1.localizedName;
      }
   }
}

