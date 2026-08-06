package com.sulake.core.assets
{
   import flash.utils.getQualifiedClassName;
   
   public class UnknownAsset implements ISoundAsset
   {
      private var _disposed:Boolean = false;
      
      private var _content:Object = null;
      
      private var _decl:AssetTypeDeclaration;
      
      private var _url:String;
      
      public function UnknownAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         _decl = param1;
         _url = param2;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get content() : Object
      {
         return _content;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return _decl;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _content = null;
            _decl = null;
            _url = null;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         _content = param1;
      }
      
      public function setFromOtherAsset(param1:ISoundAsset) : void
      {
         _content = param1.content as Object;
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function toString() : String
      {
         return getQualifiedClassName(this) + ": " + _content;
      }
   }
}

