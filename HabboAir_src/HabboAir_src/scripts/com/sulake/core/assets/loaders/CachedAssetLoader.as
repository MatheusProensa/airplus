package com.sulake.core.assets.loaders
{
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class CachedAssetLoader extends EventDispatcherWrapper implements ICachedAssetLoader
   {
      private var _url:String;
      
      private var _content:Object;
      
      private var _mimeType:String;
      
      private var _bytes:ByteArray;
      
      private var _id:int;
      
      public function CachedAssetLoader(param1:String, param2:String, param3:Object, param4:ByteArray = null, param5:int = -1)
      {
         super();
         _url = param1;
         _mimeType = param2;
         _content = param3;
         _id = param5;
         _bytes = param4 ?? buildBytes(param3);
         if(_bytes != null)
         {
            _bytes.position = 0;
         }
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get content() : Object
      {
         return _content;
      }
      
      public function get bytes() : ByteArray
      {
         return _bytes;
      }
      
      public function get mimeType() : String
      {
         return _mimeType;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!_bytes ? _bytes.length : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!_bytes ? _bytes.length : 0;
      }
      
      public function get errorCode() : uint
      {
         return 0;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function load(param1:URLRequest) : void
      {
         if(param1 != null)
         {
            _url = param1.url;
         }
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _content = null;
            _bytes = null;
            super.dispose();
         }
      }
      
      private function buildBytes(param1:Object) : ByteArray
      {
         if(param1 is ByteArray)
         {
            return param1 as ByteArray;
         }
         var _loc2_:ByteArray = new ByteArray();
         if(param1 is XML)
         {
            _loc2_.writeUTFBytes(XML(param1).toXMLString());
         }
         else if(param1 != null)
         {
            _loc2_.writeUTFBytes(String(param1));
         }
         return _loc2_;
      }
   }
}

