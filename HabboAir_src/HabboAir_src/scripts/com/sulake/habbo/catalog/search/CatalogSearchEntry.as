package com.sulake.habbo.catalog.search
{
   import com.sulake.habbo.session.furniture.IFurnitureData;
   
   public class CatalogSearchEntry
   {
      private var _furniData:IFurnitureData;
      
      private var _searchTerms:Vector.<String>;
      
      private var _productCode:String;
      
      public function CatalogSearchEntry(param1:IFurnitureData, param2:Vector.<String>, param3:String)
      {
         super();
         _furniData = param1;
         _searchTerms = param2;
         _productCode = param3;
      }
      
      public function get furniData() : IFurnitureData
      {
         return _furniData;
      }
      
      public function get searchTerms() : Vector.<String>
      {
         return _searchTerms;
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
   }
}

