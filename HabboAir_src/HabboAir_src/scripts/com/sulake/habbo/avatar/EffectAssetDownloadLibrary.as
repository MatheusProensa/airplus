package com.sulake.habbo.avatar
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.IRoomData;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class EffectAssetDownloadLibrary extends EventDispatcherWrapper implements IRoomData
   {
      private static var STATE_IDLE:int = 0;
      
      private static var STATE_DOWNLOADING:int = 1;
      
      private static var STATE_READY:int = 2;
      
      private var UnknownVarFromEffectAssetDownloadLibrary_Int_1:int;
      
      private var _name:String;
      
      private var UnknownVarFromEffectAssetDownloadLibrary_String_1:String;
      
      private var _downloadUrl:String;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _animation:XML;
      
      public function EffectAssetDownloadLibrary(param1:String, param2:String, param3:String, param4:IAssetLibraryCollection, param5:String)
      {
         super();
         UnknownVarFromEffectAssetDownloadLibrary_Int_1 = STATE_IDLE;
         _assets = param4;
         _name = param1;
         UnknownVarFromEffectAssetDownloadLibrary_String_1 = param2;
         _downloadUrl = param3 + param5;
         _downloadUrl = _downloadUrl.replace("%libname%",_name);
         _downloadUrl = _downloadUrl.replace("%revision%",UnknownVarFromEffectAssetDownloadLibrary_String_1);
         var _loc6_:AssetLibraryCollection = _assets as AssetLibraryCollection;
         var _loc7_:IAssetLibraryCollection = _loc6_.getAssetLibraryByUrl(_name + ".swf");
         if(_loc7_ != null)
         {
            UnknownVarFromEffectAssetDownloadLibrary_Int_1 = STATE_READY;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function startDownloading() : void
      {
         UnknownVarFromEffectAssetDownloadLibrary_Int_1 = STATE_DOWNLOADING;
         var _loc1_:URLRequest = new URLRequest(_downloadUrl);
         var _loc2_:LibraryLoader = new LibraryLoader();
         _assets.loadFromFile(_loc2_,true);
         _loc2_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         _loc2_.load(_loc1_);
      }
      
      private function onLoaderError(param1:LibraryLoaderEvent) : void
      {
         Core.error("Could not load effect asset library " + _name + " from URL " + _downloadUrl + " HTTP status " + param1.status + " bytes loaded " + param1.bytesLoaded + "/" + param1.bytesTotal,false,2);
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc5_:ByteArray = null;
         var _loc3_:ByteArray = null;
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         var _loc4_:Object = (_loc2_.resource as Object).animation;
         if(_loc4_ is XML)
         {
            _animation = _loc4_ as XML;
         }
         else if(_loc4_ is Class)
         {
            _loc5_ = new (_loc4_ as Class)() as ByteArray;
            _animation = new XML(_loc5_.readUTFBytes(_loc5_.length));
         }
         else if(_loc4_ is ByteArray)
         {
            _loc3_ = _loc4_ as ByteArray;
            _animation = new XML(_loc3_.readUTFBytes(_loc3_.length));
         }
         UnknownVarFromEffectAssetDownloadLibrary_Int_1 = STATE_READY;
         dispatchEvent(new Event("complete"));
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isReady() : Boolean
      {
         return UnknownVarFromEffectAssetDownloadLibrary_Int_1 == STATE_READY;
      }
      
      public function toString() : String
      {
         var _loc1_:String = _name;
         return _loc1_ + (isReady ? "[x]" : "[ ]");
      }
      
      public function get animation() : XML
      {
         return _animation;
      }
   }
}

