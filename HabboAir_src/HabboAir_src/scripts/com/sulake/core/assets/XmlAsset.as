package com.sulake.core.assets
{
   import flash.system.System;
   import flash.utils.ByteArray;
   
   public class XmlAsset implements ILazyAsset
   {
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromXmlAsset_Object_1:Object;
      
      private var _content:XML;
      
      private var _decl:AssetTypeDeclaration;
      
      private var _url:String;
      
      public function XmlAsset(param1:AssetTypeDeclaration, param2:String = null)
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
         if(!_content)
         {
            prepareLazyContent();
         }
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
            System.disposeXML(_content);
            _content = null;
            UnknownVarFromXmlAsset_Object_1 = null;
            _decl = null;
            _url = null;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         _content = null;
         UnknownVarFromXmlAsset_Object_1 = param1;
      }
      
      public function prepareLazyContent() : void
      {
         var _loc1_:ByteArray = null;
         if(UnknownVarFromXmlAsset_Object_1 is Class)
         {
            _loc1_ = new (UnknownVarFromXmlAsset_Object_1 as Class)() as ByteArray;
            _content = new XML(_loc1_.readUTFBytes(_loc1_.length));
            return;
         }
         if(UnknownVarFromXmlAsset_Object_1 is ByteArray)
         {
            _loc1_ = UnknownVarFromXmlAsset_Object_1 as ByteArray;
            _content = new XML(_loc1_.readUTFBytes(_loc1_.length));
            return;
         }
         if(UnknownVarFromXmlAsset_Object_1 is String)
         {
            _content = new XML(UnknownVarFromXmlAsset_Object_1 as String);
            return;
         }
         if(UnknownVarFromXmlAsset_Object_1 is XML)
         {
            _content = UnknownVarFromXmlAsset_Object_1 as XML;
            return;
         }
         if(UnknownVarFromXmlAsset_Object_1 is XmlAsset)
         {
            _content = XmlAsset(UnknownVarFromXmlAsset_Object_1)._content;
            return;
         }
      }
      
      public function setFromOtherAsset(param1:ISoundAsset) : void
      {
         if(param1 is XmlAsset)
         {
            _content = XmlAsset(param1)._content;
            return;
         }
         throw Error("Provided asset is not of type XmlAsset!");
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
      }
      
      public function toString() : String
      {
         var _loc1_:String = "XmlAsset";
         _loc1_ += " _url:" + _url;
         _loc1_ += " _content:" + _content;
         return _loc1_ + (" _unknown:" + UnknownVarFromXmlAsset_Object_1);
      }
   }
}

