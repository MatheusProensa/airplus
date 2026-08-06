package com.sulake.habbo.catalog.special_items_display.model
{
   import com.sulake.habbo.catalog.special_items_display.SpecialItemsController;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class FurniSpecialItem extends AbstractSpecialItem
   {
      private var UnknownVarFromFurniSpecialItem_Int_1:int = -1;
      
      private var _furniName:String = "";
      
      public function FurniSpecialItem(param1:int, param2:String, param3:String, param4:SpecialItemsController, param5:String)
      {
         super(param1,param2,param3,param4);
         var _loc6_:IFurnitureData = param4.sessionDataManager.getFloorItemDataByName(param5);
         if(_loc6_ != null)
         {
            UnknownVarFromFurniSpecialItem_Int_1 = _loc6_.id;
            _furniName = _loc6_.localizedName;
         }
      }
      
      override public function get productTypeId() : int
      {
         return 1;
      }
      
      override public function get itemTypeId() : String
      {
         return String(UnknownVarFromFurniSpecialItem_Int_1);
      }
      
      override public function get isValid() : Boolean
      {
         return UnknownVarFromFurniSpecialItem_Int_1 != -1;
      }
      
      override public function get name() : String
      {
         var _loc1_:String = super.name;
         if(_loc1_ != null && _loc1_.length > 0)
         {
            return _loc1_;
         }
         return _furniName;
      }
   }
}

