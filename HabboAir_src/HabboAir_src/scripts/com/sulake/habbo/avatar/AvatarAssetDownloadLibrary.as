package com.sulake.habbo.avatar
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class AvatarAssetDownloadLibrary extends EventDispatcherWrapper
   {
      private static var STATE_IDLE:int = 0;
      
      private static var STATE_DOWNLOADING:int = 1;
      
      private static var STATE_READY:int = 2;
      
      private var UnknownVarFromAvatarAssetDownloadLibrary_Int_1:int;
      
      private var _libraryName:String;
      
      private var UnknownVarFromAvatarAssetDownloadLibrary_String_1:String;
      
      private var _downloadUrl:String;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _isMandatory:Boolean;
      
      public function AvatarAssetDownloadLibrary(param1:String, param2:String, param3:String, param4:IAssetLibraryCollection, param5:String)
      {
         super();
         UnknownVarFromAvatarAssetDownloadLibrary_Int_1 = STATE_IDLE;
         _assets = param4;
         _libraryName = param1;
         UnknownVarFromAvatarAssetDownloadLibrary_String_1 = param2;
         _downloadUrl = param3 + param5;
         _downloadUrl = _downloadUrl.replace("%libname%",_libraryName);
         _downloadUrl = _downloadUrl.replace("%revision%",UnknownVarFromAvatarAssetDownloadLibrary_String_1);
         var _loc6_:AssetLibraryCollection = _assets as AssetLibraryCollection;
         var _loc7_:IAssetLibraryCollection = _loc6_.getAssetLibraryByUrl(_libraryName + ".swf");
         if(_loc7_ != null)
         {
            UnknownVarFromAvatarAssetDownloadLibrary_Int_1 = STATE_READY;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function startDownloading() : void
      {
         UnknownVarFromAvatarAssetDownloadLibrary_Int_1 = STATE_DOWNLOADING;
         var _loc1_:URLRequest = new URLRequest(_downloadUrl);
         var _loc2_:LibraryLoader = new LibraryLoader();
         _assets.loadFromFile(_loc2_,true);
         _loc2_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         _loc2_.load(_loc1_);
      }
      
      private function onLoaderError(param1:LibraryLoaderEvent) : void
      {
         UnknownVarFromAvatarAssetDownloadLibrary_Int_1 = STATE_READY;
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         Core.error("Could not load avatar asset library " + _libraryName + " from URL " + _downloadUrl + " HTTP status " + param1.status + " bytes loaded " + param1.bytesLoaded + "/" + param1.bytesTotal,false,2);
         dispatchEvent(new Event("complete"));
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         UnknownVarFromAvatarAssetDownloadLibrary_Int_1 = STATE_READY;
         dispatchEvent(new Event("complete"));
      }
      
      public function get libraryName() : String
      {
         return _libraryName;
      }
      
      public function get isReady() : Boolean
      {
         return UnknownVarFromAvatarAssetDownloadLibrary_Int_1 == STATE_READY;
      }
      
      public function purge() : void
      {
         var _loc1_:AssetLibraryCollection = _assets as AssetLibraryCollection;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:IAssetLibraryCollection = _loc1_.getAssetLibraryByUrl(_downloadUrl);
         if(_loc2_)
         {
            _loc1_.removeAssetLibrary(_loc2_);
            _loc2_.dispose();
            UnknownVarFromAvatarAssetDownloadLibrary_Int_1 = STATE_IDLE;
         }
      }
      
      public function get isMandatory() : Boolean
      {
         return _isMandatory;
      }
      
      public function set isMandatory(param1:Boolean) : void
      {
         _isMandatory = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = _libraryName;
         return _loc1_ + (isReady ? "[x]" : "[ ]");
      }
   }
}

