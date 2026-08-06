package com.sulake.habbo.ui.widget.crafting.utils
{
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import flash.events.EventDispatcher;
   
   public class CraftingFurnitureItem extends EventDispatcher
   {
      private var _recipeCode:String;
      
      private var _productCode:String;
      
      private var _furnitureData:IFurnitureData;
      
      private var UnknownVarFromCraftingFurnitureItem_Vector_1:Vector.<int>;
      
      private var UnknownVarFromCraftingFurnitureItem_Vector_2:Vector.<int>;
      
      public function CraftingFurnitureItem(param1:String, param2:String, param3:IFurnitureData)
      {
         super();
         _recipeCode = param1;
         _productCode = param2;
         _furnitureData = param3;
         UnknownVarFromCraftingFurnitureItem_Vector_1 = new Vector.<int>(0);
         UnknownVarFromCraftingFurnitureItem_Vector_2 = new Vector.<int>(0);
      }
      
      public function get recipeCode() : String
      {
         return _recipeCode;
      }
      
      public function get furnitureData() : IFurnitureData
      {
         return _furnitureData;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get typeId() : int
      {
         return !!_furnitureData ? _furnitureData.id : -1;
      }
      
      public function get countInInventory() : int
      {
         return !!UnknownVarFromCraftingFurnitureItem_Vector_1 ? UnknownVarFromCraftingFurnitureItem_Vector_1.length : 0;
      }
      
      public function set inventoryIds(param1:Vector.<int>) : void
      {
         UnknownVarFromCraftingFurnitureItem_Vector_1 = param1;
      }
      
      public function getItemToMixer() : int
      {
         if(countInInventory == 0)
         {
            return 0;
         }
         var _loc1_:int = int(UnknownVarFromCraftingFurnitureItem_Vector_1.shift());
         UnknownVarFromCraftingFurnitureItem_Vector_2.push(_loc1_);
         return _loc1_;
      }
      
      public function returnItemToInventory(param1:int) : void
      {
         UnknownVarFromCraftingFurnitureItem_Vector_1.push(param1);
         UnknownVarFromCraftingFurnitureItem_Vector_2.splice(UnknownVarFromCraftingFurnitureItem_Vector_2.indexOf(param1),1);
      }
   }
}

