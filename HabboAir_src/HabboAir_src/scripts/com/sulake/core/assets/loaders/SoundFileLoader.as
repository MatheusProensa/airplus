package com.sulake.core.assets.loaders
{
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class SoundFileLoader extends UnknownCoreAssetsLoaders1 implements ICachedAssetLoader
   {
      protected var _url:String;
      
      protected var _mimeType:String;
      
      protected var _content:Sound;
      
      private var _id:int;
      
      public function SoundFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         _url = param2?.url;
         _mimeType = param1;
         _content = new Sound(null,null);
         _content.addEventListener("id3",loadEventHandler);
         _content.addEventListener("open",loadEventHandler);
         _content.addEventListener("complete",loadEventHandler);
         _content.addEventListener("ioError",loadEventHandler);
         _content.addEventListener("progress",loadEventHandler);
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
         return _content;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _content.extract(_loc1_,_content.length);
         return _loc1_;
      }
      
      public function get mimeType() : String
      {
         return _mimeType;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!_content ? _content.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!_content ? _content.bytesTotal : 0;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _content.removeEventListener("id3",loadEventHandler);
            _content.removeEventListener("open",loadEventHandler);
            _content.removeEventListener("complete",loadEventHandler);
            _content.removeEventListener("ioError",loadEventHandler);
            _content.removeEventListener("progress",loadEventHandler);
            _content = null;
            _mimeType = null;
            _url = null;
            super.dispose();
         }
      }
      
      public function load(param1:URLRequest) : void
      {
         _url = param1.url;
         _content.load(param1,null);
      }
   }
}

