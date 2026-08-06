package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class FurniProductContainer extends ProductContainer
   {
      private var UnknownVarFromFurniProductContainer_IFurnitureData_1:IFurnitureData;
      
      public function FurniProductContainer(param1:UnknownIHabboCatalog1, param2:Vector.<IProduct>, param3:HabboCatalog, param4:IFurnitureData)
      {
         super(param1,param2,param3);
         UnknownVarFromFurniProductContainer_IFurnitureData_1 = param4;
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         var _loc3_:UnknownHabboRoom1 = null;
         switch(UnknownVarFromFurniProductContainer_IFurnitureData_1.type)
         {
            case "s":
               _loc3_ = catalog.roomEngine.getFurnitureIcon(UnknownVarFromFurniProductContainer_IFurnitureData_1.id,this);
               break;
            case "i":
               _loc3_ = catalog.roomEngine.getWallItemIcon(UnknownVarFromFurniProductContainer_IFurnitureData_1.id,this);
         }
         if(_loc3_)
         {
            setIconImage(_loc3_.data,true);
         }
      }
      
      override public function activate() : void
      {
         super.activate();
         var _loc1_:Boolean = _offer != null && _offer.page != null && _offer.page.isBuilderPage;
         if(_offer != null && _offer.offerId > -1)
         {
            catalog.sendGetProductOffer(_offer.offerId);
         }
         else if(UnknownVarFromFurniProductContainer_IFurnitureData_1.rentOfferId > -1 && !_loc1_)
         {
            catalog.sendGetProductOffer(UnknownVarFromFurniProductContainer_IFurnitureData_1.rentOfferId);
         }
         else if(UnknownVarFromFurniProductContainer_IFurnitureData_1.purchaseOfferId > -1)
         {
            catalog.sendGetProductOffer(UnknownVarFromFurniProductContainer_IFurnitureData_1.purchaseOfferId);
         }
      }
      
      override public function get isLazy() : Boolean
      {
         return true;
      }
   }
}

