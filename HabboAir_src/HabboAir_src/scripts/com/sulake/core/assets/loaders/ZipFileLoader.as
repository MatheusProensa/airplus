package com.sulake.core.assets.loaders
{
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   
   public class ZipFileLoader extends UnknownCoreAssetsLoaders1 implements ICachedAssetLoader
   {
      protected var _url:String;
      
      protected var _mimeType:String;
      
      protected var UnknownVarFromZipFileLoader_URLStream_1:URLStream;
      
      protected var UnknownVarFromZipFileLoader_ByteArray_1:ByteArray;
      
      private var _id:int;
      
      public function ZipFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         _url = param2?.url;
         _mimeType = param1;
         UnknownVarFromZipFileLoader_URLStream_1 = new URLStream();
         UnknownVarFromZipFileLoader_URLStream_1.addEventListener("complete",loadEventHandler);
         UnknownVarFromZipFileLoader_URLStream_1.addEventListener("httpStatus",loadEventHandler);
         UnknownVarFromZipFileLoader_URLStream_1.addEventListener("ioError",loadEventHandler);
         UnknownVarFromZipFileLoader_URLStream_1.addEventListener("open",loadEventHandler);
         UnknownVarFromZipFileLoader_URLStream_1.addEventListener("progress",loadEventHandler);
         UnknownVarFromZipFileLoader_URLStream_1.addEventListener("securityError",loadEventHandler);
         _id = param3;
         if(param2 != null)
         {
            this.load(param2);
         }
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get content() : Object
      {
         return !!UnknownVarFromZipFileLoader_ByteArray_1 ? UnknownVarFromZipFileLoader_ByteArray_1 : UnknownVarFromZipFileLoader_URLStream_1;
      }
      
      public function get bytes() : ByteArray
      {
         if(UnknownVarFromZipFileLoader_ByteArray_1)
         {
            return UnknownVarFromZipFileLoader_ByteArray_1;
         }
         var _loc1_:ByteArray = new ByteArray();
         UnknownVarFromZipFileLoader_URLStream_1.readBytes(_loc1_);
         return _loc1_;
      }
      
      public function get mimeType() : String
      {
         return _mimeType;
      }
      
      public function get bytesLoaded() : uint
      {
         return UnknownVarFromZipFileLoader_URLStream_1.bytesAvailable;
      }
      
      public function get bytesTotal() : uint
      {
         return UnknownVarFromZipFileLoader_URLStream_1.bytesAvailable;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function load(param1:URLRequest) : void
      {
         _url = param1.url;
         UnknownVarFromZipFileLoader_URLStream_1.load(param1);
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            UnknownVarFromZipFileLoader_URLStream_1.removeEventListener("complete",loadEventHandler);
            UnknownVarFromZipFileLoader_URLStream_1.removeEventListener("httpStatus",loadEventHandler);
            UnknownVarFromZipFileLoader_URLStream_1.removeEventListener("ioError",loadEventHandler);
            UnknownVarFromZipFileLoader_URLStream_1.removeEventListener("open",loadEventHandler);
            UnknownVarFromZipFileLoader_URLStream_1.removeEventListener("progress",loadEventHandler);
            UnknownVarFromZipFileLoader_URLStream_1.removeEventListener("securityError",loadEventHandler);
            UnknownVarFromZipFileLoader_URLStream_1.close();
            UnknownVarFromZipFileLoader_URLStream_1 = null;
            _mimeType = null;
            _url = null;
         }
      }
   }
}

