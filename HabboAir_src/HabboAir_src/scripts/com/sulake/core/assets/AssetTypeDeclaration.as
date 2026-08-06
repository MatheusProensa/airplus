package com.sulake.core.assets
{
   public class AssetTypeDeclaration
   {
      private var _mimeType:String;
      
      private var _assetClass:Class;
      
      private var _loaderClass:Class;
      
      private var _fileTypes:Array;
      
      public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class = null, ... rest)
      {
         super();
         _mimeType = param1;
         _assetClass = param2;
         _loaderClass = param3;
         if(rest == null)
         {
            _fileTypes = [];
         }
         else
         {
            _fileTypes = rest;
         }
      }
      
      public function get mimeType() : String
      {
         return _mimeType;
      }
      
      public function get assetClass() : Class
      {
         return _assetClass;
      }
      
      public function get loaderClass() : Class
      {
         return _loaderClass;
      }
      
      public function get fileTypes() : Array
      {
         return _fileTypes;
      }
   }
}

