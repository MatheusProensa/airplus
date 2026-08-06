package com.sulake.core.assets
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.loaders.*;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import deng.fzip.FZip;
   import deng.fzip.FZipFile;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.net.URLRequest;
   import flash.system.System;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   
   public class AssetLibrary extends EventDispatcherWrapper implements IAssetLibraryCollection
   {
      public static const ASSET_LIBRARY_READY:String = "AssetLibraryReady";
      
      public static const ASSET_LIBRARY_LOADED:String = "AssetLibraryLoaded";
      
      public static const ASSET_LIBRARY_UNLOADED:String = "AssetLibraryUnloaded";
      
      public static const ASSET_LIBRARY_LOAD_ERROR:String = "AssetLibraryLoadError";
      
      private static const NAME:String = "name";
      
      private static const ASSET:String = "asset";
      
      private static const PARAM:String = "param";
      
      private static const TYPE:String = "mimeType";
      
      private static const LIB:String = "library";
      
      private static const REF:String = "ref";
      
      private static const CACHE_MAGIC:uint = 1212302145;
      
      private static const CACHE_VERSION:uint = 1;
      
      private static var _sharedListOfTypesByMime:Dictionary;
      
      private static const USE_LAZY_ASSET_PROCESSOR:Boolean = false;
      
      private static var _numAssetLibraryInstances:uint = 0;
      
      private static var UnknownVarFromAssetLibrary_Boolean_1:Boolean;
      
      private static var UnknownVarFromAssetLibrary_String_1:String = "";
      
      private static var UnknownVarFromAssetLibrary_Boolean_2:Boolean = false;
      
      private static var UnknownVarFromAssetLibrary_LazyAssetProcessor_1:LazyAssetProcessor = new LazyAssetProcessor();
      
      private static var _assetLibraryRefArray:Array = [];
      
      private var _name:String;
      
      private var _url:String;
      
      private var UnknownVarFromAssetLibrary_XML_1:XML;
      
      private var _isReady:Boolean;
      
      private var _numAssets:uint;
      
      private var UnknownVarFromAssetLibrary_LibraryLoader_1:LibraryLoader;
      
      private var UnknownVarFromAssetLibrary_Class_1:Class;
      
      private var _loadedClasses:Dictionary;
      
      private var UnknownVarFromAssetLibrary_Dictionary_1:Dictionary;
      
      private var UnknownVarFromAssetLibrary_Boolean_3:Boolean = true;
      
      private var UnknownVarFromAssetLibrary_Dictionary_2:Dictionary;
      
      private var _assetNameArray:Array;
      
      private var _localListOfTypesByMime:Dictionary;
      
      public function AssetLibrary(param1:String, param2:XML = null)
      {
         super();
         _name = param1;
         UnknownVarFromAssetLibrary_XML_1 = param2;
         _numAssets = 0;
         _assetNameArray = [];
         if(_sharedListOfTypesByMime == null)
         {
            _sharedListOfTypesByMime = new Dictionary(false);
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/octet-stream",UnknownAsset,BinaryFileLoader));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-shockwave-flash",DisplayAsset,BitmapFileLoader,"swf"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/x-font-truetype",TypeFaceAsset,BinaryFileLoader,"ttf","otf"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("application/zip",UnknownAsset,ZipFileLoader,"zip"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("text/xml",XmlAsset,TextFileLoader,"xml"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("text/html",XmlAsset,TextFileLoader,"htm","html"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("text/plain",TextAsset,TextFileLoader,"txt"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/jpeg",BitmapDataAsset,BitmapFileLoader,"jpg","jpeg"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/gif",BitmapDataAsset,BitmapFileLoader,"gif"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/png",BitmapDataAsset,BitmapFileLoader,"png"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("image/tiff",BitmapDataAsset,BitmapFileLoader,"tif","tiff"));
            registerAssetTypeDeclaration(new AssetTypeDeclaration("sound/mp3",SoundAsset,SoundFileLoader,"mp3"));
         }
         _numAssetLibraryInstances++;
         _localListOfTypesByMime = new Dictionary(false);
         UnknownVarFromAssetLibrary_Dictionary_2 = new Dictionary(false);
         _loadedClasses = new Dictionary(false);
         UnknownVarFromAssetLibrary_Dictionary_1 = new Dictionary(false);
         _assetLibraryRefArray.push(this);
      }
      
      public static function setCacheNamespace(param1:String) : void
      {
         UnknownVarFromAssetLibrary_String_1 = param1 ?? "";
      }
      
      public static function enableGamedataCache() : void
      {
         UnknownVarFromAssetLibrary_Boolean_2 = true;
         var _loc1_:File = File.applicationStorageDirectory.resolvePath("habbo_cache");
         debug("[AssetLibrary] Game data cache enabled, directory: " + _loc1_.nativePath);
         cleanupCacheTempFiles(_loc1_);
      }
      
      public static function setDebugLogsEnabled(param1:Boolean) : void
      {
         UnknownVarFromAssetLibrary_Boolean_1 = param1;
      }
      
      private static function debug(param1:String) : void
      {
         Logger.log(param1);
         if(UnknownVarFromAssetLibrary_Boolean_1)
         {
            Core.debug(param1);
         }
      }
      
      public static function get numAssetLibraryInstances() : uint
      {
         return _numAssetLibraryInstances;
      }
      
      public static function get assetLibraryRefArray() : Array
      {
         return _assetLibraryRefArray;
      }
      
      private static function cleanupCacheTempFiles(param1:File) : void
      {
         var _loc3_:Array = null;
         try
         {
            if(!param1.exists)
            {
               return;
            }
            _loc3_ = param1.getDirectoryListing();
            for each(var _loc2_ in _loc3_)
            {
               if(_loc2_.isDirectory)
               {
                  cleanupCacheTempFiles(_loc2_);
               }
               else if(_loc2_.name.indexOf(".tmp") == _loc2_.name.length - 4)
               {
                  _loc2_.deleteFile();
               }
            }
         }
         catch(e:Error)
         {
            debug("[AssetLibrary] Cache cleanup error: " + e.message);
         }
      }
      
      private static function fetchLibraryContents(param1:AssetLibrary, param2:XML, param3:Class, param4:FZip = null) : Boolean
      {
         var _loc5_:* = null;
         var _loc14_:String = null;
         var _loc9_:String = null;
         var _loc7_:* = null;
         var _loc16_:ISoundAsset = null;
         var _loc13_:XMLList = null;
         var _loc10_:XMLList = null;
         var _loc8_:String = null;
         var _loc11_:FZipFile = null;
         if(param3 == null && param4 == null)
         {
            throw new Error("Library " + param1._url + " doesn\'t contain valid resource class!");
         }
         var _loc6_:XMLList = param2.child("library");
         if(_loc6_ == null)
         {
            throw new Error("Provided manifest doesn\'t contain library node!");
         }
         var _loc15_:* = null;
         var _loc12_:* = null;
         _loc10_ = _loc6_[0].assets;
         if(_loc10_ != null)
         {
            _loc10_ = _loc10_.child("asset");
            for each(_loc5_ in _loc10_)
            {
               _loc14_ = _loc5_.attribute("name");
               _loc9_ = _loc5_.attribute("mimeType");
               if(_loc9_ == _loc12_)
               {
                  _loc7_ = _loc15_;
               }
               else
               {
                  _loc7_ = param1.getAssetTypeDeclarationByMimeType(_loc9_);
                  _loc12_ = _loc9_;
                  _loc15_ = _loc7_;
               }
               if(_loc7_ != null)
               {
                  _loc16_ = new _loc7_.assetClass(_loc7_) as ISoundAsset;
                  if(param4 != null && param4.getFileCount() > 0)
                  {
                     _loc8_ = ".png";
                     if(_loc16_ is BitmapDataAsset)
                     {
                        _loc8_ = ".png";
                     }
                     if(_loc16_ is XmlAsset)
                     {
                        _loc8_ = ".xml";
                     }
                     _loc11_ = param4.getFileByName(_loc14_ + _loc8_);
                     if(_loc11_)
                     {
                        _loc16_.setUnknownContent(_loc11_.content);
                     }
                  }
                  else
                  {
                     _loc16_.setUnknownContent(param3[_loc14_]);
                  }
                  _loc13_ = _loc5_.child("param");
                  if(_loc13_.length())
                  {
                     _loc16_.setParamsDesc(_loc13_);
                  }
                  param1.setAsset(_loc14_,_loc16_);
               }
               else
               {
                  debug("Failed to extract asset " + _loc14_ + " from Library " + param1._url + "!");
               }
            }
         }
         _loc10_ = _loc6_[0].aliases;
         if(_loc10_ != null)
         {
            _loc10_ = _loc10_.child("asset");
            for each(_loc5_ in _loc10_)
            {
               _loc14_ = _loc5_.attribute("name");
               _loc9_ = _loc5_.attribute("mimeType");
               if(_loc9_ == _loc12_)
               {
                  _loc7_ = _loc15_;
               }
               else
               {
                  _loc7_ = param1.getAssetTypeDeclarationByMimeType(_loc9_);
                  _loc12_ = _loc9_;
                  _loc15_ = _loc7_;
               }
               if(_loc7_ != null)
               {
                  _loc16_ = new _loc7_.assetClass(_loc7_) as ISoundAsset;
                  _loc16_.setUnknownContent(param1.getAssetByName(_loc5_.attribute("ref")).content);
                  _loc13_ = _loc5_.child("param");
                  if(_loc13_.length())
                  {
                     _loc16_.setParamsDesc(_loc13_);
                  }
                  param1.setAsset(_loc14_,_loc16_);
               }
               else
               {
                  debug("Failed to extract asset alias " + _loc14_ + " from Library " + param1._url + "!");
               }
            }
         }
         return true;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isReady() : Boolean
      {
         return _isReady;
      }
      
      public function get manifest() : XML
      {
         return !!UnknownVarFromAssetLibrary_XML_1 ? UnknownVarFromAssetLibrary_XML_1 : (UnknownVarFromAssetLibrary_XML_1 = new XML());
      }
      
      public function get numAssets() : uint
      {
         return _numAssets;
      }
      
      public function get nameArray() : Array
      {
         return _assetNameArray;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            unload();
            super.dispose();
            _assetLibraryRefArray.splice(_assetLibraryRefArray.indexOf(this),1);
            _numAssetLibraryInstances--;
            UnknownVarFromAssetLibrary_Dictionary_2 = null;
            _loadedClasses = null;
            UnknownVarFromAssetLibrary_Dictionary_1 = null;
            _assetNameArray = null;
            System.disposeXML(UnknownVarFromAssetLibrary_XML_1);
            UnknownVarFromAssetLibrary_XML_1 = null;
            _numAssets = 0;
            _isReady = false;
            _name = null;
         }
      }
      
      public function loadFromFile(param1:LibraryLoader, param2:Boolean = true) : void
      {
         if(_url == param1.url && _isReady)
         {
            if(!UnknownVarFromAssetLibrary_Boolean_3 && param2)
            {
               AssetLibrary.fetchLibraryContents(this,UnknownVarFromAssetLibrary_XML_1,UnknownVarFromAssetLibrary_Class_1);
            }
            UnknownVarFromAssetLibrary_Boolean_3 = param2;
            dispatchEvent(new Event("AssetLibraryReady"));
         }
         else
         {
            if(UnknownVarFromAssetLibrary_LibraryLoader_1 == null || UnknownVarFromAssetLibrary_LibraryLoader_1.disposed)
            {
               UnknownVarFromAssetLibrary_LibraryLoader_1 = param1;
               UnknownVarFromAssetLibrary_LibraryLoader_1.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",libraryLoadedHandler);
               UnknownVarFromAssetLibrary_LibraryLoader_1.addEventListener("LIBRARY_LOADER_EVENT_ERROR",loadErrorHandler);
            }
            UnknownVarFromAssetLibrary_Boolean_3 = param2;
            _url = UnknownVarFromAssetLibrary_LibraryLoader_1.url;
         }
      }
      
      public function loadFromResource(param1:XML, param2:Class) : Boolean
      {
         return AssetLibrary.fetchLibraryContents(this,param1,param2);
      }
      
      public function unload() : void
      {
         var _loc2_:String = null;
         var _loc1_:AssetLoaderStruct = null;
         var _loc3_:ISoundAsset = null;
         for(_loc2_ in UnknownVarFromAssetLibrary_Dictionary_2)
         {
            _loc1_ = UnknownVarFromAssetLibrary_Dictionary_2[_loc2_];
            _loc1_.assetLoader.dispose();
            delete UnknownVarFromAssetLibrary_Dictionary_2[_loc2_];
         }
         for(_loc2_ in UnknownVarFromAssetLibrary_Dictionary_1)
         {
            _loc3_ = UnknownVarFromAssetLibrary_Dictionary_1[_loc2_];
            _loc3_.dispose();
            delete UnknownVarFromAssetLibrary_Dictionary_1[_loc2_];
         }
         for(_loc2_ in _loadedClasses)
         {
            delete _loadedClasses[_loc2_];
         }
         if(UnknownVarFromAssetLibrary_LibraryLoader_1 != null)
         {
            UnknownVarFromAssetLibrary_LibraryLoader_1.dispose();
            UnknownVarFromAssetLibrary_LibraryLoader_1 = null;
         }
         _numAssets = 0;
         _isReady = false;
         _url = null;
         dispatchEvent(new Event("AssetLibraryUnloaded"));
      }
      
      public function getClass(param1:String) : Class
      {
         var _loc2_:Class = _loadedClasses[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         if(UnknownVarFromAssetLibrary_LibraryLoader_1 != null)
         {
            if(UnknownVarFromAssetLibrary_LibraryLoader_1.hasDefinition(param1))
            {
               _loc2_ = UnknownVarFromAssetLibrary_LibraryLoader_1.getDefinition(param1) as Class;
               if(_loc2_ != null)
               {
                  _loadedClasses[param1] = _loc2_;
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function loadAssetFromFile(param1:String, param2:URLRequest, param3:String = null, param4:int = -1) : AssetLoaderStruct
      {
         var struct:AssetLoaderStruct;
         var decl:AssetTypeDeclaration;
         var cachedBytes:ByteArray;
         var cachedContent:Object;
         var cachedLoader:ICachedAssetLoader;
         var timer:Timer;
         var loader:ICachedAssetLoader;
         var assetName:String = param1;
         var url:URLRequest = param2;
         var mimeType:String = param3;
         var id:int = param4;
         if(getAssetByName(assetName) != null)
         {
            throw new Error("Asset with name " + assetName + " already exists!");
         }
         struct = UnknownVarFromAssetLibrary_Dictionary_2[url.url];
         if(struct != null)
         {
            if(struct.assetName == assetName)
            {
               return struct;
            }
         }
         if(mimeType == null)
         {
            decl = solveAssetTypeDeclarationFromUrl(url.url);
            if(decl == null)
            {
               throw new Error("Couldn\'t solve asset type for file " + url.url + "!");
            }
         }
         else
         {
            decl = getAssetTypeDeclarationByMimeType(mimeType,true);
            if(decl == null)
            {
               throw new Error("Asset type declaration for mime type " + mimeType + "not found!");
            }
         }
         cachedBytes = readCachedAssetData(url.url,decl.mimeType);
         if(cachedBytes != null)
         {
            debug("[AssetLibrary] Cache hit: " + url.url);
            cachedContent = buildCachedContent(decl.mimeType,cachedBytes);
            cachedLoader = new CachedAssetLoader(url.url,decl.mimeType,cachedContent,cachedBytes,id);
            cachedLoader.addEventListener("AssetLoaderEventComplete",assetLoadEventHandler);
            cachedLoader.addEventListener("AssetLoaderEventError",assetLoadEventHandler);
            cachedLoader.addEventListener("AssetLoaderEventUnload",assetLoadEventHandler);
            cachedLoader.addEventListener("AssetLoaderEventProgress",assetLoadEventHandler);
            cachedLoader.addEventListener("AssetLoaderEventStatus",assetLoadEventHandler);
            cachedLoader.addEventListener("AssetLoaderEventOpen",assetLoadEventHandler);
            struct = new AssetLoaderStruct(assetName,cachedLoader);
            UnknownVarFromAssetLibrary_Dictionary_2[url.url] = struct;
            timer = new Timer(10,1);
            timer.addEventListener("timer",function(param1:TimerEvent):void
            {
               cachedLoader.dispatchEvent(new AssetLoaderEvent("AssetLoaderEventComplete",200));
            });
            timer.start();
            return struct;
         }
         if(shouldCacheAssetUrl(url.url))
         {
            debug("[AssetLibrary] Cache miss: " + url.url);
         }
         loader = new decl.loaderClass(decl.mimeType,url,id);
         if(loader == null)
         {
            throw new Error("Invalid file loader class defined for mime type " + mimeType + "!");
         }
         loader.addEventListener("AssetLoaderEventComplete",assetLoadEventHandler);
         loader.addEventListener("AssetLoaderEventError",assetLoadEventHandler);
         loader.addEventListener("AssetLoaderEventUnload",assetLoadEventHandler);
         loader.addEventListener("AssetLoaderEventProgress",assetLoadEventHandler);
         loader.addEventListener("AssetLoaderEventStatus",assetLoadEventHandler);
         loader.addEventListener("AssetLoaderEventOpen",assetLoadEventHandler);
         struct = new AssetLoaderStruct(assetName,loader);
         UnknownVarFromAssetLibrary_Dictionary_2[url.url] = struct;
         return struct;
      }
      
      private function assetLoadEventHandler(param1:AssetLoaderEvent) : void
      {
         var _loc5_:String = null;
         var _loc3_:AssetTypeDeclaration = null;
         var _loc6_:ISoundAsset = null;
         var _loc7_:Boolean = false;
         var _loc4_:ICachedAssetLoader = param1.target as ICachedAssetLoader;
         if(_loc4_ == null)
         {
            throw new Error("Failed to downcast object to asset loader!");
         }
         var _loc2_:AssetLoaderStruct = UnknownVarFromAssetLibrary_Dictionary_2[_loc4_.url];
         if(_loc2_ == null)
         {
            throw new Error("Asset loader structure was lost! " + (!!_loc4_ ? _loc4_.url : ""));
         }
         switch(param1.type)
         {
            case "AssetLoaderEventComplete":
               _loc5_ = _loc4_.mimeType;
               _loc3_ = getAssetTypeDeclarationByMimeType(_loc5_);
               _loc7_ = true;
               if(_loc3_ != null)
               {
                  _loc6_ = new _loc3_.assetClass(_loc3_,_loc4_.url);
                  try
                  {
                     debug("[AssetLibrary] Loaded: \"" + _loc4_.url + "\" (asset: " + _loc2_.assetName + ")");
                     _loc6_.setUnknownContent(_loc4_.content);
                  }
                  catch(error:Error)
                  {
                     _loc6_.dispose();
                     debug("Failed to build asset from loaded file \"" + _loc4_.url + "\" type: " + _loc5_ + " error: " + error.name + " / " + error.message);
                     param1 = new AssetLoaderEvent("AssetLoaderEventError",param1.status);
                     break;
                  }
                  if(UnknownVarFromAssetLibrary_Dictionary_1[_loc2_.assetName] == null)
                  {
                     _numAssets++;
                     _assetNameArray.push(_loc2_.assetName);
                  }
                  UnknownVarFromAssetLibrary_Dictionary_1[_loc2_.assetName] = _loc6_;
                  writeCachedAssetData(_loc4_.url,_loc5_,_loc4_.content,_loc4_.bytes);
               }
               else
               {
                  debug("Failed to resolve asset type declaration: \"" + _loc4_.url + "\" type: " + _loc5_);
                  param1 = new AssetLoaderEvent("AssetLoaderEventError",param1.status);
               }
               break;
            case "AssetLoaderEventError":
               _loc7_ = true;
               debug("Failed to download file \"" + _loc4_.url + "\" error: " + _loc4_.errorCode);
         }
         _loc2_.dispatchEvent(new AssetLoaderEvent(param1.type,param1.status));
         if(_loc7_)
         {
            if(!_disposed && _loc4_)
            {
               delete UnknownVarFromAssetLibrary_Dictionary_2[_loc4_.url];
            }
            if(_loc2_)
            {
               _loc2_.dispose();
            }
         }
      }
      
      public function getAssetByName(param1:String) : ISoundAsset
      {
         var _loc2_:ISoundAsset = UnknownVarFromAssetLibrary_Dictionary_1[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         if(UnknownVarFromAssetLibrary_Boolean_3)
         {
            return null;
         }
         _loc2_ = fetchAssetFromResource(param1);
         if(_loc2_ == null)
         {
         }
         return _loc2_;
      }
      
      public function getAssetByIndex(param1:uint) : ISoundAsset
      {
         return param1 < _assetNameArray.length ? getAssetByName(_assetNameArray[param1]) : null;
      }
      
      public function getAssetByContent(param1:Object) : ISoundAsset
      {
         var _loc3_:ISoundAsset = null;
         var _loc2_:String = null;
         for(_loc2_ in UnknownVarFromAssetLibrary_Dictionary_1)
         {
            _loc3_ = UnknownVarFromAssetLibrary_Dictionary_1[_loc2_];
            if(_loc3_.content === param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function readCachedAssetData(param1:String, param2:String) : ByteArray
      {
         var _loc3_:File = null;
         var _loc5_:FileStream = null;
         var _loc4_:ByteArray = null;
         var _loc6_:ByteArray = null;
         if(!shouldCacheAssetUrl(param1))
         {
            return null;
         }
         try
         {
            _loc3_ = getCacheFile(param1);
            if(!_loc3_.exists)
            {
               debug("[AssetLibrary] Cache read miss: " + _loc3_.nativePath);
               return null;
            }
            _loc5_ = new FileStream();
            _loc4_ = new ByteArray();
            _loc5_.open(_loc3_,"read");
            _loc5_.readBytes(_loc4_,0,_loc5_.bytesAvailable);
            _loc5_.close();
            _loc4_.position = 0;
            _loc6_ = parseCachedPayload(_loc4_,param2);
            if(_loc6_ == null || _loc6_.length == 0)
            {
               deleteCacheFile(_loc3_);
               return null;
            }
            if(param2 == "text/xml" && !isValidXmlPayload(_loc6_))
            {
               deleteCacheFile(_loc3_);
               return null;
            }
            debug("[AssetLibrary] Cache read hit: " + _loc3_.nativePath + " (" + _loc6_.length + " bytes)");
            _loc6_.position = 0;
            return _loc6_;
         }
         catch(e:Error)
         {
            debug("[AssetLibrary] Cache read error: " + e.message);
            var _loc12_:* = null;
         }
         return _loc12_;
      }
      
      private function writeCachedAssetData(param1:String, param2:String, param3:Object, param4:ByteArray) : void
      {
         var _loc5_:File = null;
         var _loc7_:File = null;
         var _loc6_:FileStream = null;
         var _loc8_:ByteArray = null;
         if(!shouldCacheAssetUrl(param1))
         {
            return;
         }
         try
         {
            _loc5_ = getCacheFile(param1);
            if(!_loc5_.parent.exists)
            {
               _loc5_.parent.createDirectory();
            }
            _loc7_ = _loc5_.parent.resolvePath(_loc5_.name + ".tmp");
            _loc6_ = new FileStream();
            _loc6_.open(_loc7_,"write");
            _loc8_ = buildCacheFileBytes(param2,param3,param4);
            _loc6_.writeBytes(_loc8_);
            _loc6_.close();
            _loc7_.moveTo(_loc5_,true);
            debug("[AssetLibrary] Cache write: " + _loc5_.nativePath + " (" + _loc5_.size + " bytes)");
         }
         catch(e:Error)
         {
            debug("[AssetLibrary] Cache write error: " + e.message);
         }
      }
      
      private function buildCachedContent(param1:String, param2:ByteArray) : Object
      {
         if(param1 && param1.indexOf("text/") == 0)
         {
            param2.position = 0;
            return param2.readUTFBytes(param2.length);
         }
         param2.position = 0;
         return param2;
      }
      
      private function buildCacheFileBytes(param1:String, param2:Object, param3:ByteArray) : ByteArray
      {
         var _loc6_:String = null;
         var _loc4_:ByteArray = new ByteArray();
         if(param3 != null && param3.length > 0)
         {
            param3.position = 0;
            _loc4_.writeBytes(param3);
         }
         else if(param2 is ByteArray)
         {
            _loc4_.writeBytes(ByteArray(param2));
         }
         else
         {
            _loc6_ = "";
            if(param2 is XML)
            {
               _loc6_ = XML(param2).toString();
            }
            else if(param2 is String)
            {
               _loc6_ = String(param2);
            }
            _loc4_.writeUTFBytes(_loc6_);
         }
         var _loc5_:String = param1 ?? "";
         var _loc8_:ByteArray = new ByteArray();
         _loc8_.writeUTFBytes(_loc5_);
         var _loc7_:ByteArray = new ByteArray();
         _loc7_.writeUnsignedInt(1212302145);
         _loc7_.writeShort(1);
         _loc7_.writeShort(_loc8_.length);
         _loc7_.writeBytes(_loc8_);
         _loc7_.writeUnsignedInt(_loc4_.length);
         _loc7_.writeBytes(_loc4_);
         _loc7_.position = 0;
         return _loc7_;
      }
      
      private function parseCachedPayload(param1:ByteArray, param2:String) : ByteArray
      {
         if(param1.length < 12)
         {
            return param1;
         }
         param1.position = 0;
         var _loc3_:uint = param1.readUnsignedInt();
         if(_loc3_ != 1212302145)
         {
            param1.position = 0;
            return param1;
         }
         var _loc7_:uint = param1.readUnsignedShort();
         if(_loc7_ != 1)
         {
            return null;
         }
         if(param1.bytesAvailable < 2)
         {
            return null;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         if(param1.bytesAvailable < _loc4_ + 4)
         {
            return null;
         }
         var _loc8_:String = _loc4_ > 0 ? param1.readUTFBytes(_loc4_) : "";
         if(param2 != null && _loc8_ != "" && _loc8_ != param2)
         {
            return null;
         }
         var _loc6_:uint = param1.readUnsignedInt();
         if(param1.bytesAvailable < _loc6_)
         {
            return null;
         }
         var _loc5_:ByteArray = new ByteArray();
         if(_loc6_ > 0)
         {
            param1.readBytes(_loc5_,0,_loc6_);
         }
         _loc5_.position = 0;
         return _loc5_;
      }
      
      private function isValidXmlPayload(param1:ByteArray) : Boolean
      {
         var _loc2_:String = null;
         try
         {
            param1.position = 0;
            _loc2_ = param1.readUTFBytes(param1.length);
            new XML(_loc2_);
            param1.position = 0;
            return true;
         }
         catch(e:Error)
         {
            var _loc5_:Boolean = false;
         }
         return _loc5_;
      }
      
      private function deleteCacheFile(param1:File) : void
      {
         try
         {
            if(param1.exists)
            {
               param1.deleteFile();
            }
         }
         catch(e:Error)
         {
            debug("[AssetLibrary] Cache delete error: " + e.message);
         }
      }
      
      private function shouldCacheAssetUrl(param1:String) : Boolean
      {
         if(!UnknownVarFromAssetLibrary_Boolean_2)
         {
            return false;
         }
         if(!hasHashedSuffix(param1))
         {
            return false;
         }
         return param1.indexOf("/gamedata/figuredata/") > -1 || param1.indexOf("/gamedata/furnidata_xml/") > -1 || param1.indexOf("/gamedata/productdata_xml/") > -1 || param1.indexOf("/gamedata/external_variables/") > -1 || param1.indexOf("/gamedata/external_flash_texts/") > -1;
      }
      
      private function hasHashedSuffix(param1:String) : Boolean
      {
         var _loc4_:int = int(param1.indexOf("?"));
         var _loc5_:String = _loc4_ > -1 ? param1.substring(0,_loc4_) : param1;
         var _loc2_:int = int(_loc5_.lastIndexOf("/"));
         if(_loc2_ < 0 || _loc2_ == _loc5_.length - 1)
         {
            return false;
         }
         var _loc3_:String = _loc5_.substring(_loc2_ + 1);
         if(_loc3_ == "1")
         {
            return false;
         }
         return /^[0-9a-f]{32,}$/i.test(_loc3_);
      }
      
      private function getCacheFile(param1:String) : File
      {
         var _loc2_:File = File.applicationStorageDirectory.resolvePath("habbo_cache");
         var _loc4_:String = cacheDirNameForUrl(param1);
         if(_loc4_ != "")
         {
            _loc2_ = _loc2_.resolvePath(_loc4_);
         }
         var _loc3_:String = cacheKeyForUrl(param1);
         return _loc2_.resolvePath(_loc3_);
      }
      
      private function cacheDirNameForUrl(param1:String) : String
      {
         if(UnknownVarFromAssetLibrary_String_1 != "")
         {
            return UnknownVarFromAssetLibrary_String_1.replace(/[^a-zA-Z0-9._-]/g,"_");
         }
         var _loc2_:String = extractUrlHost(param1);
         if(_loc2_ == "")
         {
            return "";
         }
         return _loc2_.replace(/[^a-zA-Z0-9._-]/g,"_");
      }
      
      private function extractUrlHost(param1:String) : String
      {
         var _loc2_:int = int(param1.indexOf("://"));
         if(_loc2_ < 0)
         {
            return "";
         }
         var _loc3_:int = _loc2_ + 3;
         var _loc4_:int = int(param1.indexOf("/",_loc3_));
         if(_loc4_ < 0)
         {
            _loc4_ = param1.length;
         }
         return param1.substring(_loc3_,_loc4_);
      }
      
      private function cacheKeyForUrl(param1:String) : String
      {
         var _loc2_:int = int(param1.lastIndexOf("/"));
         var _loc4_:String = _loc2_ >= 0 ? param1.substr(_loc2_ + 1) : param1;
         var _loc3_:String = _loc4_.replace(/[^a-zA-Z0-9._-]/g,"_");
         if(_loc3_.length == 0)
         {
            _loc3_ = simpleHash(param1);
         }
         return _loc3_;
      }
      
      private function simpleHash(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = (_loc3_ << 5) - _loc3_ + param1.charCodeAt(_loc2_);
            _loc3_ |= 0;
            _loc2_++;
         }
         return (_loc3_ >>> 0).toString(16);
      }
      
      public function getAssetIndex(param1:ISoundAsset) : int
      {
         var _loc2_:String = null;
         for(_loc2_ in UnknownVarFromAssetLibrary_Dictionary_1)
         {
            if(UnknownVarFromAssetLibrary_Dictionary_1[_loc2_] == param1)
            {
               return _assetNameArray.indexOf(_loc2_);
            }
         }
         return -1;
      }
      
      public function hasAsset(param1:String) : Boolean
      {
         return UnknownVarFromAssetLibrary_Dictionary_1[param1] != null || (UnknownVarFromAssetLibrary_Class_1 != null ? UnknownVarFromAssetLibrary_Class_1[param1] != null : false);
      }
      
      public function setAsset(param1:String, param2:ISoundAsset, param3:Boolean = true) : Boolean
      {
         var _loc4_:* = UnknownVarFromAssetLibrary_Dictionary_1[param1] == null;
         if((param3 || _loc4_) && param2)
         {
            if(_loc4_)
            {
               _numAssets++;
               _assetNameArray.push(param1);
            }
            UnknownVarFromAssetLibrary_Dictionary_1[param1] = param2;
            return true;
         }
         return false;
      }
      
      public function createAsset(param1:String, param2:AssetTypeDeclaration) : ISoundAsset
      {
         if(hasAsset(param1) || !param2)
         {
            return null;
         }
         var _loc3_:ISoundAsset = new param2.assetClass(param2);
         if(!setAsset(param1,_loc3_))
         {
            _loc3_.dispose();
            _loc3_ = null;
         }
         return _loc3_;
      }
      
      public function removeAsset(param1:ISoundAsset) : ISoundAsset
      {
         var _loc2_:String = null;
         if(param1)
         {
            for(_loc2_ in UnknownVarFromAssetLibrary_Dictionary_1)
            {
               if(UnknownVarFromAssetLibrary_Dictionary_1[_loc2_] == param1)
               {
                  _assetNameArray.splice(_assetNameArray.indexOf(_loc2_),1);
                  delete UnknownVarFromAssetLibrary_Dictionary_1[_loc2_];
                  _numAssets--;
                  return param1;
               }
            }
         }
         return null;
      }
      
      public function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean = true) : Boolean
      {
         if(param2)
         {
            if(_sharedListOfTypesByMime.hasOwnProperty(param1.mimeType))
            {
               throw new Error("Asset type " + param1.mimeType + " already registered!");
            }
            _sharedListOfTypesByMime[param1.mimeType] = param1;
         }
         else
         {
            if(_localListOfTypesByMime.hasOwnProperty(param1.mimeType))
            {
               throw new Error("Asset type " + param1.mimeType + " already registered!");
            }
            _localListOfTypesByMime[param1.mimeType] = param1;
         }
         return true;
      }
      
      public function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:AssetTypeDeclaration = null;
         if(param2)
         {
            _loc3_ = AssetTypeDeclaration(_sharedListOfTypesByMime[param1]);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return AssetTypeDeclaration(_localListOfTypesByMime[param1]);
      }
      
      public function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc4_:String = null;
         var _loc3_:AssetTypeDeclaration = null;
         if(param2)
         {
            for(_loc4_ in _sharedListOfTypesByMime)
            {
               _loc3_ = AssetTypeDeclaration(_sharedListOfTypesByMime[_loc4_]);
               if(_loc3_ != null)
               {
                  if(_loc3_.assetClass == param1)
                  {
                     return _loc3_;
                  }
               }
            }
         }
         for(_loc4_ in _localListOfTypesByMime)
         {
            _loc3_ = AssetTypeDeclaration(_localListOfTypesByMime[_loc4_]);
            if(_loc3_ != null)
            {
               if(_loc3_.assetClass == param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc5_:String = null;
         var _loc4_:AssetTypeDeclaration = null;
         var _loc3_:String = param1.substr(param1.lastIndexOf(".") + 1,param1.length);
         if(_loc3_.indexOf("?"))
         {
            _loc3_ = _loc3_.substr(0,_loc3_.indexOf("?") - 1);
         }
         if(param2)
         {
            for(_loc5_ in _sharedListOfTypesByMime)
            {
               _loc4_ = AssetTypeDeclaration(_sharedListOfTypesByMime[_loc5_]);
               if(_loc4_ != null)
               {
                  if(_loc4_.fileTypes.indexOf(_loc3_))
                  {
                     return _loc4_;
                  }
               }
            }
         }
         for(_loc5_ in _localListOfTypesByMime)
         {
            _loc4_ = AssetTypeDeclaration(_localListOfTypesByMime[_loc5_]);
            if(_loc4_ != null)
            {
               if(_loc4_.fileTypes.indexOf(_loc3_))
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      private function libraryLoadedHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         if(_loc2_.manifest == null)
         {
            throw new Error("loader.manifest was null, which would have caused error 1009 anyway. See HL-22347.");
         }
         UnknownVarFromAssetLibrary_XML_1 = _loc2_.manifest.copy();
         UnknownVarFromAssetLibrary_Class_1 = _loc2_.resource;
         _url = _loc2_.url;
         if(UnknownVarFromAssetLibrary_Boolean_3)
         {
            AssetLibrary.fetchLibraryContents(this,UnknownVarFromAssetLibrary_XML_1,UnknownVarFromAssetLibrary_Class_1);
         }
         _isReady = true;
         dispatchEvent(new Event("AssetLibraryLoaded"));
         dispatchEvent(new Event("AssetLibraryReady"));
         if(UnknownVarFromAssetLibrary_Boolean_3)
         {
            UnknownVarFromAssetLibrary_LibraryLoader_1.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",libraryLoadedHandler);
            UnknownVarFromAssetLibrary_LibraryLoader_1.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",loadErrorHandler);
            UnknownVarFromAssetLibrary_LibraryLoader_1.addEventListener("LIBRARY_LOADER_FINALIZE",finalizeLoaderEventHandler);
            UnknownVarFromAssetLibrary_LibraryLoader_1 = null;
            UnknownVarFromAssetLibrary_Class_1 = null;
         }
      }
      
      private function finalizeLoaderEventHandler(param1:Event) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         if(_loc2_ && !_loc2_.disposed)
         {
            if(!_loc2_.hasEventListener("LIBRARY_LOADER_EVENT_COMPLETE"))
            {
               _loc2_.removeEventListener("LIBRARY_LOADER_FINALIZE",finalizeLoaderEventHandler);
               _loc2_.dispose();
            }
         }
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1.clone());
      }
      
      private function loadErrorHandler(param1:LibraryLoaderEvent) : void
      {
         _isReady = false;
         var _loc3_:LibraryLoader = param1.target as LibraryLoader;
         var _loc2_:String = !!_loc3_ ? _loc3_.name : "unknown";
         debug("Cannot load the specified file: " + _loc2_ + " " + param1.status);
         dispatchEvent(new Event("AssetLibraryLoadError"));
         UnknownVarFromAssetLibrary_LibraryLoader_1 = null;
      }
      
      private function solveAssetTypeDeclarationFromUrl(param1:String) : AssetTypeDeclaration
      {
         var _loc4_:int = 0;
         var _loc2_:AssetTypeDeclaration = null;
         var _loc5_:Array = null;
         var _loc3_:String = null;
         _loc4_ = int(param1.indexOf("?",0));
         if(_loc4_ > 0)
         {
            param1 = param1.slice(0,_loc4_);
         }
         _loc4_ = int(param1.lastIndexOf("."));
         if(_loc4_ == -1)
         {
            return null;
         }
         param1 = param1.slice(_loc4_ + 1,param1.length);
         for(_loc3_ in _localListOfTypesByMime)
         {
            _loc2_ = _localListOfTypesByMime[_loc3_];
            _loc5_ = _loc2_.fileTypes;
            if(_loc5_ != null)
            {
               if(_loc5_.indexOf(param1,0) > -1)
               {
                  return _loc2_;
               }
            }
         }
         for(_loc3_ in _sharedListOfTypesByMime)
         {
            _loc2_ = _sharedListOfTypesByMime[_loc3_];
            _loc5_ = _loc2_.fileTypes;
            if(_loc5_ != null)
            {
               if(_loc5_.indexOf(param1,0) > -1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function fetchAssetFromResource(param1:String) : ISoundAsset
      {
         var _loc3_:AssetTypeDeclaration = null;
         var _loc4_:XMLList = null;
         var _loc2_:XML = null;
         var _loc6_:* = 0;
         if(!UnknownVarFromAssetLibrary_Class_1)
         {
            return null;
         }
         var _loc7_:XMLList = UnknownVarFromAssetLibrary_XML_1.child("library");
         if(_loc7_ == null)
         {
            throw new Error("Provided manifest doesn\'t contain library node!");
         }
         if(_loc7_.length() == 0)
         {
            return null;
         }
         _loc7_ = _loc7_[0].assets;
         if(_loc7_ != null)
         {
            _loc7_ = _loc7_.child("asset");
            if(_loc7_ != null)
            {
               var _loc8_:ISoundAsset = null;
               var _loc5_:int = int(_loc7_.length());
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc2_ = _loc7_[_loc6_];
                  if(_loc2_.attribute("name") && _loc2_.attribute("name").toString() == param1)
                  {
                     _loc3_ = getAssetTypeDeclarationByMimeType(_loc2_.attribute("mimeType"));
                     if(_loc3_ == null)
                     {
                        throw new Error("Failed to extract asset " + param1 + " from Library " + _url + "!");
                     }
                     _loc8_ = new _loc3_.assetClass(_loc3_) as ISoundAsset;
                     _loc8_.setUnknownContent(UnknownVarFromAssetLibrary_Class_1[param1]);
                     _loc4_ = _loc2_.child("param");
                     if(_loc4_ && _loc4_.length())
                     {
                        _loc8_.setParamsDesc(_loc4_);
                     }
                     setAsset(param1,_loc8_);
                     return _loc8_;
                  }
                  _loc6_++;
               }
            }
         }
         return null;
      }
      
      public function toString() : String
      {
         return getQualifiedClassName(this) + ": " + _name;
      }
   }
}

