package com.sulake.habbo.communication.messages.parser.crafting
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class FurnitureProductItem
   {
      private var _recipeCode:String;
      
      private var _productCode:String;
      
      private var _furnitureClassName:String;
      
      public function FurnitureProductItem(param1:IMessageDataWrapper)
      {
         super();
         _recipeCode = param1.readString();
         _productCode = param1.readString();
         _furnitureClassName = param1.readString();
      }
      
      public function get recipeCode() : String
      {
         return _recipeCode;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get furnitureClassName() : String
      {
         return _furnitureClassName;
      }
   }
}

