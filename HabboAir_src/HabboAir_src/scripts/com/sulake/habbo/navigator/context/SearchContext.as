package com.sulake.habbo.navigator.context
{
   public class SearchContext
   {
      private var _searchCode:String;
      
      private var _filtering:String;
      
      public function SearchContext(param1:String, param2:String)
      {
         super();
         this._searchCode = param1;
         this._filtering = param2;
      }
      
      public function get searchCode() : String
      {
         return _searchCode;
      }
      
      public function get filtering() : String
      {
         return _filtering;
      }
      
      public function toString() : String
      {
         return _searchCode + " : " + _filtering;
      }
   }
}

