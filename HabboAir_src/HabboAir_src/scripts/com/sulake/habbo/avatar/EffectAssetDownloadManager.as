package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class EffectAssetDownloadManager extends EventDispatcherWrapper
   {
      public static const LIBRARY_LOADED:String = "LIBRARY_LOADED";
      
      private var UnknownVarFromEffectAssetDownloadManager_Array_1:Array;
      
      private var _map:Dictionary;
      
      private var UnknownVarFromEffectAssetDownloadManager_Int_1:int = 3;
      
      private var UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1:AssetLoaderStruct;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromEffectAssetDownloadManager_Boolean_1:Boolean;
      
      private var UnknownVarFromEffectAssetDownloadManager_String_1:String;
      
      private var UnknownVarFromEffectAssetDownloadManager_String_2:String;
      
      private var UnknownVarFromEffectAssetDownloadManager_String_3:String;
      
      private var UnknownVarFromEffectAssetDownloadManager_AvatarStructure_1:AvatarStructure;
      
      private var _listeners:Dictionary;
      
      private var UnknownVarFromEffectAssetDownloadManager_Dictionary_1:Dictionary;
      
      private var _downloadShiftTimer:Timer;
      
      private var UnknownVarFromEffectAssetDownloadManager_Array_2:Array;
      
      private var UnknownVarFromEffectAssetDownloadManager_Array_3:Array;
      
      private var UnknownVarFromEffectAssetDownloadManager_Array_4:Array;
      
      private const DOWNLOAD_TIMEOUT:int = 100;
      
      private const MAX_SIMULTANEOUS_DOWNLOADS:int = 2;
      
      public function EffectAssetDownloadManager(param1:IAssetLibraryCollection, param2:String, param3:String, param4:AvatarStructure, param5:String)
      {
         var _loc9_:XmlAsset = null;
         var _loc7_:XML = null;
         UnknownVarFromEffectAssetDownloadManager_Array_1 = ["dance.1","dance.2","dance.3","dance.4"];
         super();
         _map = new Dictionary();
         _assets = param1;
         UnknownVarFromEffectAssetDownloadManager_AvatarStructure_1 = param4;
         UnknownVarFromEffectAssetDownloadManager_String_1 = param2;
         UnknownVarFromEffectAssetDownloadManager_String_2 = param3;
         UnknownVarFromEffectAssetDownloadManager_String_3 = param5;
         _listeners = new Dictionary();
         UnknownVarFromEffectAssetDownloadManager_Dictionary_1 = new Dictionary();
         UnknownVarFromEffectAssetDownloadManager_Array_2 = [];
         UnknownVarFromEffectAssetDownloadManager_Array_3 = [];
         UnknownVarFromEffectAssetDownloadManager_Array_4 = [];
         var _loc6_:URLRequest = new URLRequest(UnknownVarFromEffectAssetDownloadManager_String_1);
         var _loc8_:ISoundAsset = _assets.getAssetByName("effectmap");
         if(_loc8_ == null)
         {
            UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1 = _assets.loadAssetFromFile("effectmap",_loc6_,"text/xml");
            addMapLoaderEventListeners();
         }
         else
         {
            _loc9_ = _assets.getAssetByName("effectmap") as XmlAsset;
            _loc7_ = (_loc9_.content as XML).copy();
            loadEffectMapData(_loc7_);
         }
         _downloadShiftTimer = new Timer(100,1);
         _downloadShiftTimer.addEventListener("timerComplete",onNextDownloadTimeout);
         UnknownVarFromEffectAssetDownloadManager_AvatarStructure_1.renderManager.events.addEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
      }
      
      public function loadMandatoryLibs() : void
      {
         var _loc4_:Array = null;
         var _loc1_:Array = UnknownVarFromEffectAssetDownloadManager_Array_1.slice();
         for each(var _loc3_ in _loc1_)
         {
            _loc4_ = _map[_loc3_];
            if(_loc4_ != null)
            {
               for each(var _loc2_ in _loc4_)
               {
                  addToQueue(_loc2_);
               }
            }
         }
      }
      
      private function addMapLoaderEventListeners() : void
      {
         if(UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1)
         {
            UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1.addEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1.addEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function removeMapLoaderEventListeners() : void
      {
         if(UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1)
         {
            UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1.removeEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1.removeEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var _loc2_:XML = null;
         if(disposed)
         {
            return;
         }
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ == null)
         {
            return;
         }
         try
         {
            _loc2_ = new XML(_loc3_.assetLoader.content as String);
         }
         catch(e:Error)
         {
            return;
         }
         loadEffectMapData(_loc2_);
      }
      
      private function onConfigurationError(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         if(disposed)
         {
            return;
         }
         UnknownVarFromEffectAssetDownloadManager_Int_1--;
         if(UnknownVarFromEffectAssetDownloadManager_Int_1 <= 0)
         {
            HabboWebTools.logEventLog("Effect download error " + UnknownVarFromEffectAssetDownloadManager_String_1);
         }
         else
         {
            if(UnknownVarFromEffectAssetDownloadManager_String_1.indexOf("?") > 0)
            {
               _loc2_ = UnknownVarFromEffectAssetDownloadManager_String_1 + "&retry=" + UnknownVarFromEffectAssetDownloadManager_Int_1;
            }
            else
            {
               _loc2_ = UnknownVarFromEffectAssetDownloadManager_String_1 + "?retry=" + UnknownVarFromEffectAssetDownloadManager_Int_1;
            }
            removeMapLoaderEventListeners();
            _loc3_ = new URLRequest(_loc2_);
            UnknownVarFromEffectAssetDownloadManager_AssetLoaderStruct_1 = _assets.loadAssetFromFile("effectmap",_loc3_,"text/xml");
            addMapLoaderEventListeners();
         }
      }
      
      private function loadEffectMapData(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.toString() == "")
         {
            return;
         }
         generateMap(param1);
         loadMandatoryLibs();
         UnknownVarFromEffectAssetDownloadManager_Boolean_1 = true;
         dispatchEvent(new Event("complete"));
      }
      
      private function generateMap(param1:XML) : void
      {
         var _loc2_:EffectAssetDownloadLibrary = null;
         var _loc3_:String = null;
         var _loc5_:Array = null;
         for each(var _loc4_ in param1.effect)
         {
            _loc2_ = new EffectAssetDownloadLibrary(_loc4_.@lib,"0",UnknownVarFromEffectAssetDownloadManager_String_2,_assets,UnknownVarFromEffectAssetDownloadManager_String_3);
            _loc2_.addEventListener("complete",libraryComplete);
            _loc3_ = _loc4_.@id;
            _loc5_ = _map[_loc3_];
            if(_loc5_ == null)
            {
               _loc5_ = [];
            }
            _loc5_.push(_loc2_);
            _map[_loc3_] = _loc5_;
         }
      }
      
      private function libraryComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc11_:Array = null;
         var _loc10_:Boolean = false;
         var _loc5_:Array = null;
         var _loc7_:EffectAssetDownloadLibrary = null;
         var _loc8_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc9_:EffectAssetDownloadLibrary = param1.target as EffectAssetDownloadLibrary;
         UnknownVarFromEffectAssetDownloadManager_AvatarStructure_1.registerAnimation(_loc9_.animation);
         for(_loc2_ in UnknownVarFromEffectAssetDownloadManager_Dictionary_1)
         {
            _loc10_ = true;
            _loc11_ = UnknownVarFromEffectAssetDownloadManager_Dictionary_1[_loc2_];
            for each(var _loc3_ in _loc11_)
            {
               if(!_loc3_.isReady)
               {
                  _loc10_ = false;
                  break;
               }
            }
            if(_loc10_)
            {
               _loc4_.push(_loc2_);
               _loc5_ = _listeners[_loc2_];
               for each(var _loc6_ in _loc5_)
               {
                  if(_loc6_ != null && !_loc6_.disposed)
                  {
                     _loc6_.avatarEffectReady(parseInt(_loc2_));
                  }
               }
               delete _listeners[_loc2_];
            }
         }
         for each(_loc2_ in _loc4_)
         {
            delete UnknownVarFromEffectAssetDownloadManager_Dictionary_1[_loc2_];
         }
         while(_loc8_ < UnknownVarFromEffectAssetDownloadManager_Array_4.length)
         {
            _loc7_ = UnknownVarFromEffectAssetDownloadManager_Array_4[_loc8_];
            if(_loc7_.name == _loc9_.name)
            {
               UnknownVarFromEffectAssetDownloadManager_Array_4.splice(_loc8_,1);
            }
            _loc8_++;
         }
         if(_loc4_.length > 0)
         {
            dispatchEvent(new LibraryLoadedEvent("LIBRARY_LOADED",_loc9_.name));
         }
         _downloadShiftTimer.start();
      }
      
      public function isReady(param1:int) : Boolean
      {
         if(!UnknownVarFromEffectAssetDownloadManager_Boolean_1 || !UnknownVarFromEffectAssetDownloadManager_AvatarStructure_1.renderManager.isReady)
         {
            return false;
         }
         var _loc2_:Array = getLibsToDownload(param1);
         return _loc2_.length == 0;
      }
      
      public function loadEffectData(param1:int, param2:IAvatarImage_1) : void
      {
         var _loc5_:Array = null;
         if(!UnknownVarFromEffectAssetDownloadManager_Boolean_1 || !UnknownVarFromEffectAssetDownloadManager_AvatarStructure_1.renderManager.isReady)
         {
            UnknownVarFromEffectAssetDownloadManager_Array_2.push([param1,param2]);
            return;
         }
         var _loc4_:Array = getLibsToDownload(param1);
         if(_loc4_.length > 0)
         {
            if(param2 && !param2.disposed)
            {
               _loc5_ = _listeners[String(param1)];
               if(_loc5_ == null)
               {
                  _loc5_ = [];
               }
               _loc5_.push(param2);
               _listeners[String(param1)] = _loc5_;
            }
            UnknownVarFromEffectAssetDownloadManager_Dictionary_1[String(param1)] = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               addToQueue(_loc3_);
            }
         }
         else if(param2 != null && !param2.disposed)
         {
            param2.avatarEffectReady(param1);
            Logger.log("Effect ready to use: " + param1);
         }
      }
      
      private function getLibsToDownload(param1:int) : Array
      {
         var _loc3_:Array = [];
         if(!UnknownVarFromEffectAssetDownloadManager_AvatarStructure_1)
         {
            return _loc3_;
         }
         var _loc4_:Array = _map[String(param1)];
         if(_loc4_ != null)
         {
            for each(var _loc2_ in _loc4_)
            {
               if(_loc2_ != null)
               {
                  if(!_loc2_.isReady)
                  {
                     if(_loc3_.indexOf(_loc2_) == -1)
                     {
                        _loc3_.push(_loc2_);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function processPending() : void
      {
         var _loc1_:EffectAssetDownloadLibrary = null;
         while(UnknownVarFromEffectAssetDownloadManager_Array_3.length > 0 && UnknownVarFromEffectAssetDownloadManager_Array_4.length < 2)
         {
            _loc1_ = UnknownVarFromEffectAssetDownloadManager_Array_3.shift();
            _loc1_.startDownloading();
            UnknownVarFromEffectAssetDownloadManager_Array_4.push(_loc1_);
         }
      }
      
      private function addToQueue(param1:EffectAssetDownloadLibrary) : void
      {
         if(!param1.isReady && UnknownVarFromEffectAssetDownloadManager_Array_3.indexOf(param1) == -1 && UnknownVarFromEffectAssetDownloadManager_Array_4.indexOf(param1) == -1)
         {
            UnknownVarFromEffectAssetDownloadManager_Array_3.push(param1);
            processPending();
         }
      }
      
      private function onNextDownloadTimeout(param1:Event = null) : void
      {
         processPending();
      }
      
      private function purgeInitDownloadBuffer(param1:Event) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in UnknownVarFromEffectAssetDownloadManager_Array_2)
         {
            loadEffectData(_loc2_[0],_loc2_[1]);
         }
         UnknownVarFromEffectAssetDownloadManager_Array_2 = [];
      }
      
      public function get map() : Dictionary
      {
         return _map;
      }
   }
}

