package com.sulake.core.assets
{
   import flash.utils.ByteArray;
   
   public class TextAsset implements ISoundAsset
   {
      private var _disposed:Boolean = false;
      
      private var _content:String = "";
      
      private var _decl:AssetTypeDeclaration;
      
      private var _url:String;
      
      public function TextAsset(param1:AssetTypeDeclaration, param2:String = null)
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
         var _loc2_:ByteArray = null;
         if(param1 is String)
         {
            _content = param1 as String;
            return;
         }
         if(param1 is Class)
         {
            _loc2_ = new (param1 as Class)() as ByteArray;
            _content = _loc2_.readUTFBytes(_loc2_.length);
            return;
         }
         if(param1 is ByteArray)
         {
            _loc2_ = param1 as ByteArray;
            _content = _loc2_.readUTFBytes(_loc2_.length);
            return;
         }
         if(param1 is TextAsset)
         {
            _content = TextAsset(param1)._content;
            return;
         }
         _content = !!param1 ? param1.toString() : "";
      }
      
      public function setFromOtherAsset(param1:ISoundAsset) : void
      {
         if(param1 is TextAsset)
         {
            _content = TextAsset(param1)._content;
            return;
         }
         throw Error("Provided asset is not of type TextAsset!");
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
   }
}

