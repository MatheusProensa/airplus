package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CraftableProductsMessageParser implements IMessageParser
   {
      private var _recipeProductItems:Vector.<FurnitureProductItem> = new Vector.<FurnitureProductItem>(0);
      
      private var _usableInventoryFurniClasses:Vector.<String> = new Vector.<String>(0);
      
      public function CraftableProductsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _recipeProductItems = new Vector.<FurnitureProductItem>(0);
         _usableInventoryFurniClasses = new Vector.<String>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _recipeProductItems.push(new FurnitureProductItem(param1));
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _usableInventoryFurniClasses.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get recipeProductItems() : Vector.<FurnitureProductItem>
      {
         return _recipeProductItems;
      }
      
      public function get usableInventoryFurniClasses() : Vector.<String>
      {
         return _usableInventoryFurniClasses;
      }
      
      public function hasData() : Boolean
      {
         return _recipeProductItems.length > 0 || _usableInventoryFurniClasses.length > 0;
      }
   }
}

