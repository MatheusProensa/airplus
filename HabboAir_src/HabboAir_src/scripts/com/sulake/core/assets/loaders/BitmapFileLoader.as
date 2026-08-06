package com.sulake.core.assets.loaders
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.PNGEncoderOptions;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class BitmapFileLoader extends UnknownCoreAssetsLoaders1 implements ICachedAssetLoader
   {
      protected var _url:String;
      
      protected var _mimeType:String;
      
      protected var UnknownVarFromBitmapFileLoader_Loader_1:Loader;
      
      protected var _loaderContext:LoaderContext;
      
      private var _id:int = -1;
      
      public function BitmapFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         _url = param2?.url;
         _mimeType = param1;
         UnknownVarFromBitmapFileLoader_Loader_1 = new Loader();
         _loaderContext = new LoaderContext();
         _loaderContext.checkPolicyFile = false;
         UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.addEventListener("complete",completeEventHandler);
         UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.addEventListener("unload",loadEventHandler);
         UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.addEventListener("httpStatus",loadEventHandler);
         UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.addEventListener("progress",loadEventHandler);
         UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.addEventListener("ioError",loadEventHandler);
         UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.addEventListener("securityError",loadEventHandler);
         _id = param3;
         if(param2 != null && param2.url != null)
         {
            UnknownVarFromBitmapFileLoader_Loader_1.load(param2,_loaderContext);
         }
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get content() : Object
      {
         return !!UnknownVarFromBitmapFileLoader_Loader_1 ? UnknownVarFromBitmapFileLoader_Loader_1.content : null;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc2_:Bitmap = content as Bitmap;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc1_:BitmapData = _loc2_.bitmapData;
         return _loc1_.encode(_loc1_.rect,new PNGEncoderOptions());
      }
      
      public function get mimeType() : String
      {
         return _mimeType;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!UnknownVarFromBitmapFileLoader_Loader_1 ? UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!UnknownVarFromBitmapFileLoader_Loader_1 ? UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.bytesTotal : 0;
      }
      
      public function get loaderContext() : LoaderContext
      {
         return _loaderContext;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function load(param1:URLRequest) : void
      {
         _url = param1.url;
         _retries = 0;
         UnknownVarFromBitmapFileLoader_Loader_1.load(param1,_loaderContext);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++_retries <= UnknownVarFromUnknownCoreAssetsLoaders1_Int_1)
            {
               try
               {
                  UnknownVarFromBitmapFileLoader_Loader_1.close();
                  UnknownVarFromBitmapFileLoader_Loader_1.unload();
               }
               catch(e:Error)
               {
               }
               UnknownVarFromBitmapFileLoader_Loader_1.load(new URLRequest(_url + (_url.indexOf("?") == -1 ? "?" : "&") + "retry=" + _retries),_loaderContext);
               return true;
            }
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.removeEventListener("complete",completeEventHandler);
            UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.removeEventListener("unload",loadEventHandler);
            UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.removeEventListener("httpStatus",loadEventHandler);
            UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.removeEventListener("progress",loadEventHandler);
            UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.removeEventListener("ioError",loadEventHandler);
            UnknownVarFromBitmapFileLoader_Loader_1.contentLoaderInfo.removeEventListener("securityError",loadEventHandler);
            try
            {
               UnknownVarFromBitmapFileLoader_Loader_1.close();
            }
            catch(e:*)
            {
            }
            UnknownVarFromBitmapFileLoader_Loader_1.unload();
            UnknownVarFromBitmapFileLoader_Loader_1 = null;
            _mimeType = null;
            _url = null;
         }
      }
      
      private function completeEventHandler(param1:Event) : void
      {
         loadEventHandler(param1);
      }
   }
}

