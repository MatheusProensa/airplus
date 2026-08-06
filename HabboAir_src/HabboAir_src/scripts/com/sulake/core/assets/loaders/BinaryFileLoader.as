package com.sulake.core.assets.loaders
{
   import com.sulake.core.utils.Resources;
   import flash.events.Event;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class BinaryFileLoader extends UnknownCoreAssetsLoaders1 implements ICachedAssetLoader
   {
      protected var _url:String;
      
      protected var _mimeType:String;
      
      protected var UnknownVarFromBinaryFileLoader_Object_1:Object;
      
      protected var UnknownVarFromBinaryFileLoader_URLLoader_1:URLLoader;
      
      private var _id:int;
      
      public function BinaryFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         _url = param2?.url;
         _mimeType = param1;
         UnknownVarFromBinaryFileLoader_URLLoader_1 = new URLLoader();
         UnknownVarFromBinaryFileLoader_URLLoader_1.dataFormat = "binary";
         UnknownVarFromBinaryFileLoader_URLLoader_1.addEventListener("complete",loadEventHandler);
         UnknownVarFromBinaryFileLoader_URLLoader_1.addEventListener("unload",loadEventHandler);
         UnknownVarFromBinaryFileLoader_URLLoader_1.addEventListener("httpStatus",loadEventHandler);
         UnknownVarFromBinaryFileLoader_URLLoader_1.addEventListener("progress",loadEventHandler);
         UnknownVarFromBinaryFileLoader_URLLoader_1.addEventListener("ioError",loadEventHandler);
         UnknownVarFromBinaryFileLoader_URLLoader_1.addEventListener("securityError",securityErrorEventHandler);
         _id = param3;
         if(param2 != null)
         {
            load(param2);
         }
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get content() : Object
      {
         return !!UnknownVarFromBinaryFileLoader_Object_1 ? UnknownVarFromBinaryFileLoader_Object_1 : (!!UnknownVarFromBinaryFileLoader_URLLoader_1 ? UnknownVarFromBinaryFileLoader_URLLoader_1.data : null);
      }
      
      public function get bytes() : ByteArray
      {
         var _loc1_:ByteArray = null;
         if(UnknownVarFromBinaryFileLoader_URLLoader_1)
         {
            if(UnknownVarFromBinaryFileLoader_URLLoader_1.data is ByteArray)
            {
               return UnknownVarFromBinaryFileLoader_URLLoader_1.data;
            }
            if(UnknownVarFromBinaryFileLoader_URLLoader_1.data is String)
            {
               _loc1_ = new ByteArray();
               _loc1_.writeUTFBytes(UnknownVarFromBinaryFileLoader_URLLoader_1.data);
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get mimeType() : String
      {
         return _mimeType;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!UnknownVarFromBinaryFileLoader_URLLoader_1 ? UnknownVarFromBinaryFileLoader_URLLoader_1.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!UnknownVarFromBinaryFileLoader_URLLoader_1 ? UnknownVarFromBinaryFileLoader_URLLoader_1.bytesTotal : 0;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function load(param1:URLRequest) : void
      {
         var _loc2_:Timer = null;
         _url = param1.url;
         UnknownVarFromBinaryFileLoader_Object_1 = null;
         _retries = 0;
         UnknownVarFromBinaryFileLoader_URLLoader_1.dataFormat = "binary";
         UnknownVarFromBinaryFileLoader_Object_1 = Resources.get(param1.url) as String;
         if(UnknownVarFromBinaryFileLoader_Object_1)
         {
            _loc2_ = new Timer(10,1);
            _loc2_.addEventListener("timer",timerEventHandler);
            _loc2_.start();
            return;
         }
         UnknownVarFromBinaryFileLoader_URLLoader_1.load(param1);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++_retries <= UnknownVarFromUnknownCoreAssetsLoaders1_Int_1)
            {
               try
               {
                  UnknownVarFromBinaryFileLoader_URLLoader_1.close();
               }
               catch(e:Error)
               {
               }
               UnknownVarFromBinaryFileLoader_URLLoader_1.load(new URLRequest(_url + (_url.indexOf("?") == -1 ? "?" : "&") + "retry=" + _retries));
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
            UnknownVarFromBinaryFileLoader_URLLoader_1.removeEventListener("complete",loadEventHandler);
            UnknownVarFromBinaryFileLoader_URLLoader_1.removeEventListener("unload",loadEventHandler);
            UnknownVarFromBinaryFileLoader_URLLoader_1.removeEventListener("httpStatus",loadEventHandler);
            UnknownVarFromBinaryFileLoader_URLLoader_1.removeEventListener("progress",loadEventHandler);
            UnknownVarFromBinaryFileLoader_URLLoader_1.removeEventListener("ioError",loadEventHandler);
            UnknownVarFromBinaryFileLoader_URLLoader_1.removeEventListener("securityError",securityErrorEventHandler);
            try
            {
               UnknownVarFromBinaryFileLoader_URLLoader_1.close();
            }
            catch(e:Error)
            {
            }
            UnknownVarFromBinaryFileLoader_URLLoader_1 = null;
            _mimeType = null;
            UnknownVarFromBinaryFileLoader_Object_1 = null;
            _url = null;
         }
      }
      
      private function securityErrorEventHandler(param1:SecurityErrorEvent) : void
      {
         if(!_disposed)
         {
            loadEventHandler(param1);
         }
      }
      
      private function timerEventHandler(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.target as Timer;
         if(_loc2_)
         {
            _loc2_.stop();
            _loc2_.removeEventListener("timer",timerEventHandler);
         }
         if(!_disposed)
         {
            loadEventHandler(new Event("complete"));
         }
      }
   }
}

