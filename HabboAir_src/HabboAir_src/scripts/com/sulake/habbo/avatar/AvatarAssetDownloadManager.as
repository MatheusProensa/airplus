package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.habbo.avatar.events.LibraryLoadedEvent;
   import com.sulake.habbo.avatar.structure.IFigureSetData;
   import com.sulake.habbo.avatar.structure.figure.FigurePart;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AvatarAssetDownloadManager extends EventDispatcherWrapper
   {
      public static const LIBRARY_LOADED:String = "LIBRARY_LOADED";
      
      private static const LIB_BODY:String = "hh_human_body";
      
      private static const LIB_ITEMS:String = "hh_human_item";
      
      private static const LIB_AVATAR_EDITOR:String = "hh_avatar_editor";
      
      private var UnknownVarFromAvatarAssetDownloadManager_AvatarRenderManager_1:AvatarRenderManager;
      
      private var _libraries:Dictionary;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Dictionary_1:Dictionary;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _incompleteFigures:Dictionary;
      
      private var _listeners:Dictionary;
      
      private var UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1:AvatarStructure;
      
      private var UnknownVarFromAvatarAssetDownloadManager_String_1:String;
      
      private var UnknownVarFromAvatarAssetDownloadManager_String_2:String;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Boolean_1:Boolean;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Int_1:int = 3;
      
      private var UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1:AssetLoaderStruct;
      
      private var _downloadShiftTimer:Timer;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Array_1:Array;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Array_2:Array;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Array_3:Array;
      
      private const DOWNLOAD_TIMEOUT:int = 100;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Int_2:int = 6;
      
      private var UnknownVarFromAvatarAssetDownloadManager_String_3:String;
      
      private var UnknownVarFromAvatarAssetDownloadManager_Array_4:Array;
      
      public function AvatarAssetDownloadManager(param1:AvatarRenderManager, param2:IAssetLibraryCollection, param3:String, param4:String, param5:AvatarStructure, param6:String)
      {
         var _loc10_:XmlAsset = null;
         var _loc8_:XML = null;
         UnknownVarFromAvatarAssetDownloadManager_Array_4 = ["hh_human_body","hh_human_item"];
         super();
         UnknownVarFromAvatarAssetDownloadManager_AvatarRenderManager_1 = param1;
         _libraries = new Dictionary();
         UnknownVarFromAvatarAssetDownloadManager_Dictionary_1 = new Dictionary();
         _assets = param2;
         UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1 = param5;
         _incompleteFigures = new Dictionary();
         UnknownVarFromAvatarAssetDownloadManager_String_1 = param4;
         UnknownVarFromAvatarAssetDownloadManager_String_2 = param3;
         UnknownVarFromAvatarAssetDownloadManager_String_3 = param6;
         _listeners = new Dictionary();
         UnknownVarFromAvatarAssetDownloadManager_Array_1 = [];
         UnknownVarFromAvatarAssetDownloadManager_Array_2 = [];
         UnknownVarFromAvatarAssetDownloadManager_Array_3 = [];
         if(param4 && param4.indexOf("//rumba.sulake.com") > 0)
         {
            UnknownVarFromAvatarAssetDownloadManager_Int_2 = 16;
         }
         UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1.renderManager.events.addEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
         var _loc7_:URLRequest = new URLRequest(param3);
         var _loc9_:ISoundAsset = _assets.getAssetByName("figuremap");
         if(_loc9_ == null)
         {
            UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1 = _assets.loadAssetFromFile("figuremap",_loc7_,"text/xml");
            addMapLoaderEventListeners();
         }
         else
         {
            _loc10_ = _assets.getAssetByName("figuremap") as XmlAsset;
            _loc8_ = (_loc10_.content as XML).copy();
            loadFigureMapData(_loc8_);
         }
         _downloadShiftTimer = new Timer(100,1);
         _downloadShiftTimer.addEventListener("timerComplete",onNextDownloadTimeout);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromAvatarAssetDownloadManager_Dictionary_1 = null;
         _assets = null;
         _incompleteFigures = null;
         _listeners = null;
         if(UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1.renderManager)
         {
            UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1.renderManager.events.removeEventListener("AVATAR_RENDER_READY",purgeInitDownloadBuffer);
         }
         UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1 = null;
         UnknownVarFromAvatarAssetDownloadManager_Array_2 = null;
         UnknownVarFromAvatarAssetDownloadManager_Array_1 = null;
         if(_downloadShiftTimer)
         {
            _downloadShiftTimer.stop();
            _downloadShiftTimer = null;
         }
         if(UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1)
         {
            removeMapLoaderEventListeners();
            UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1 = null;
         }
      }
      
      private function addMapLoaderEventListeners() : void
      {
         if(UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1)
         {
            UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1.addEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1.addEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function removeMapLoaderEventListeners() : void
      {
         if(UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1)
         {
            UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1.removeEventListener("AssetLoaderEventComplete",onConfigurationComplete);
            UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1.removeEventListener("AssetLoaderEventError",onConfigurationError);
         }
      }
      
      private function onConfigurationError(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         if(disposed)
         {
            return;
         }
         UnknownVarFromAvatarAssetDownloadManager_Int_1--;
         if(UnknownVarFromAvatarAssetDownloadManager_Int_1 <= 0)
         {
            HabboWebTools.logEventLog("Figuremap download error " + UnknownVarFromAvatarAssetDownloadManager_String_2);
         }
         else
         {
            if(UnknownVarFromAvatarAssetDownloadManager_String_2.indexOf("?") > 0)
            {
               _loc2_ = UnknownVarFromAvatarAssetDownloadManager_String_2 + "&retry=" + UnknownVarFromAvatarAssetDownloadManager_Int_1;
            }
            else
            {
               _loc2_ = UnknownVarFromAvatarAssetDownloadManager_String_2 + "?retry=" + UnknownVarFromAvatarAssetDownloadManager_Int_1;
            }
            removeMapLoaderEventListeners();
            _loc3_ = new URLRequest(_loc2_);
            UnknownVarFromAvatarAssetDownloadManager_AssetLoaderStruct_1 = _assets.loadAssetFromFile("figuremap",_loc3_,"text/xml");
            addMapLoaderEventListeners();
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
         loadFigureMapData(_loc2_);
      }
      
      private function loadFigureMapData(param1:XML) : void
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
         UnknownVarFromAvatarAssetDownloadManager_Boolean_1 = true;
         dispatchEvent(new Event("complete"));
      }
      
      public function loadMandatoryLibs() : void
      {
         var _loc2_:AvatarAssetDownloadLibrary = null;
         var _loc1_:Array = UnknownVarFromAvatarAssetDownloadManager_Array_4.slice();
         for each(var _loc3_ in _loc1_)
         {
            _loc2_ = _libraries[_loc3_];
            if(_loc2_)
            {
               _loc2_.isMandatory = true;
               addToQueue(_loc2_);
            }
            else
            {
               Logger.log("Missing mandatory library: " + _loc3_);
            }
         }
         _downloadShiftTimer.start();
      }
      
      private function purgeInitDownloadBuffer(param1:Event) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in UnknownVarFromAvatarAssetDownloadManager_Array_1)
         {
            loadFigureSetData(_loc2_[0],_loc2_[1]);
         }
         UnknownVarFromAvatarAssetDownloadManager_Array_1 = [];
      }
      
      private function generateMap(param1:XML) : void
      {
         var _loc2_:AvatarAssetDownloadLibrary = null;
         var _loc3_:String = null;
         var _loc6_:Array = null;
         for each(var _loc5_ in param1.lib)
         {
            _loc2_ = new AvatarAssetDownloadLibrary(_loc5_.@id,_loc5_.@revision,UnknownVarFromAvatarAssetDownloadManager_String_1,_assets,UnknownVarFromAvatarAssetDownloadManager_String_3);
            _loc2_.addEventListener("complete",libraryComplete);
            _libraries[_loc2_.libraryName] = _loc2_;
            for each(var _loc4_ in _loc5_.part)
            {
               _loc3_ = _loc4_.@type + ":" + _loc4_.@id;
               _loc6_ = UnknownVarFromAvatarAssetDownloadManager_Dictionary_1[_loc3_];
               if(_loc6_ == null)
               {
                  _loc6_ = [];
               }
               _loc6_.push(_loc2_);
               UnknownVarFromAvatarAssetDownloadManager_Dictionary_1[_loc3_] = _loc6_;
            }
         }
      }
      
      public function isReady(param1:IAvatarFigureContainer) : Boolean
      {
         if(!UnknownVarFromAvatarAssetDownloadManager_Boolean_1 || !UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1.renderManager.isReady)
         {
            return false;
         }
         var _loc2_:Array = getLibsToDownload(param1);
         return _loc2_.length == 0;
      }
      
      public function loadFigureSetData(param1:IAvatarFigureContainer, param2:UnknownIHabboAvatar1) : void
      {
         var _loc5_:Array = null;
         if(!UnknownVarFromAvatarAssetDownloadManager_Boolean_1 || !UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1.renderManager.isReady)
         {
            UnknownVarFromAvatarAssetDownloadManager_Array_1.push([param1,param2]);
            return;
         }
         var _loc6_:String = param1.getFigureString();
         var _loc4_:Array = getLibsToDownload(param1);
         if(_loc4_.length > 0)
         {
            if(param2 && !param2.disposed)
            {
               _loc5_ = _listeners[_loc6_];
               if(_loc5_ == null)
               {
                  _loc5_ = [];
               }
               _loc5_.push(param2);
               _listeners[_loc6_] = _loc5_;
            }
            _incompleteFigures[_loc6_] = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               addToQueue(_loc3_);
            }
            _downloadShiftTimer.start();
         }
         else if(param2 != null && !param2.disposed)
         {
            param2.avatarImageReady(_loc6_);
         }
      }
      
      private function libraryComplete(param1:Event) : void
      {
         var _loc10_:String = null;
         var _loc4_:Array = null;
         var _loc12_:Boolean = false;
         var _loc5_:Array = null;
         var _loc8_:AvatarAssetDownloadLibrary = null;
         var _loc9_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc11_:Array = [];
         for(_loc10_ in _incompleteFigures)
         {
            _loc12_ = true;
            _loc4_ = _incompleteFigures[_loc10_];
            for each(var _loc3_ in _loc4_)
            {
               if(!_loc3_.isReady)
               {
                  _loc12_ = false;
                  break;
               }
            }
            if(_loc12_)
            {
               _loc11_.push(_loc10_);
               _loc5_ = _listeners[_loc10_];
               for each(var _loc7_ in _loc5_)
               {
                  if(_loc7_ != null && !_loc7_.disposed)
                  {
                     _loc7_.avatarImageReady(_loc10_);
                  }
               }
               delete _listeners[_loc10_];
            }
         }
         for each(_loc10_ in _loc11_)
         {
            delete _incompleteFigures[_loc10_];
         }
         var _loc6_:String = (param1.target as AvatarAssetDownloadLibrary).libraryName;
         var _loc2_:int = int(UnknownVarFromAvatarAssetDownloadManager_Array_4.indexOf(_loc6_));
         if(_loc2_ != -1)
         {
            UnknownVarFromAvatarAssetDownloadManager_Array_4.splice(_loc2_,1);
            if(UnknownVarFromAvatarAssetDownloadManager_Array_4.length == 0)
            {
               UnknownVarFromAvatarAssetDownloadManager_AvatarRenderManager_1.onMandatoryLibrariesReady();
            }
         }
         _loc9_ = 0;
         while(_loc9_ < UnknownVarFromAvatarAssetDownloadManager_Array_3.length)
         {
            _loc8_ = UnknownVarFromAvatarAssetDownloadManager_Array_3[_loc9_];
            if(_loc8_.libraryName == _loc6_)
            {
               UnknownVarFromAvatarAssetDownloadManager_Array_3.splice(_loc9_,1);
            }
            _loc9_++;
         }
         if(_loc11_.length > 0)
         {
            dispatchEvent(new LibraryLoadedEvent("LIBRARY_LOADED",_loc6_));
         }
         _downloadShiftTimer.start();
      }
      
      public function isMissingMandatoryLibs() : Boolean
      {
         return UnknownVarFromAvatarAssetDownloadManager_Array_4.length > 0;
      }
      
      private function getLibsToDownload(param1:IAvatarFigureContainer) : Array
      {
         var _loc12_:ISetType = null;
         var _loc7_:int = 0;
         var _loc5_:IFigurePartSet = null;
         var _loc11_:String = null;
         var _loc4_:Array = null;
         var _loc8_:Array = [];
         if(!UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1)
         {
            return _loc8_;
         }
         if(!param1)
         {
            return _loc8_;
         }
         var _loc2_:IFigureSetData = UnknownVarFromAvatarAssetDownloadManager_AvatarStructure_1.figureData;
         if(!_loc2_)
         {
            return _loc8_;
         }
         var _loc10_:Array = param1.getPartTypeIds();
         for each(var _loc6_ in _loc10_)
         {
            _loc12_ = _loc2_.getSetType(_loc6_);
            if(_loc12_)
            {
               _loc7_ = param1.getPartSetId(_loc6_);
               _loc5_ = _loc12_.getPartSet(_loc7_);
               if(_loc5_)
               {
                  for each(var _loc9_ in _loc5_.parts)
                  {
                     _loc11_ = _loc9_.type + ":" + _loc9_.id;
                     _loc4_ = UnknownVarFromAvatarAssetDownloadManager_Dictionary_1[_loc11_];
                     if(_loc4_ != null)
                     {
                        for each(var _loc3_ in _loc4_)
                        {
                           if(_loc3_ != null)
                           {
                              if(!_loc3_.isReady)
                              {
                                 if(_loc8_.indexOf(_loc3_) == -1)
                                 {
                                    _loc8_.push(_loc3_);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc8_;
      }
      
      private function processPending() : void
      {
         var _loc1_:AvatarAssetDownloadLibrary = null;
         while(UnknownVarFromAvatarAssetDownloadManager_Array_2.length > 0 && UnknownVarFromAvatarAssetDownloadManager_Array_3.length < UnknownVarFromAvatarAssetDownloadManager_Int_2)
         {
            _loc1_ = UnknownVarFromAvatarAssetDownloadManager_Array_2.shift();
            UnknownVarFromAvatarAssetDownloadManager_Array_3.push(_loc1_);
            _loc1_.startDownloading();
         }
      }
      
      private function addToQueue(param1:AvatarAssetDownloadLibrary) : void
      {
         if(!param1.isReady && UnknownVarFromAvatarAssetDownloadManager_Array_2.indexOf(param1) == -1 && UnknownVarFromAvatarAssetDownloadManager_Array_3.indexOf(param1) == -1)
         {
            UnknownVarFromAvatarAssetDownloadManager_Array_2.push(param1);
         }
      }
      
      private function onNextDownloadTimeout(param1:Event = null) : void
      {
         processPending();
      }
      
      public function purge() : void
      {
         for each(var _loc1_ in _libraries)
         {
            if(_loc1_.isReady && !_loc1_.isMandatory)
            {
               _loc1_.purge();
            }
         }
      }
   }
}

