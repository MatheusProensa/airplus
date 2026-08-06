package com.sulake.habbo.habbicons.assets
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.utils.BitmapHelper;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class HabbiconAssetManager
   {
      private static const UnknownConstFromHabbiconAssetManager_String_1:String = "habbicons.asset.root";
      
      private static const HABBICONS_ASSET_HASH:String = "habbicons.asset.hash";
      
      private static const UnknownConstFromHabbiconAssetManager_String_2:String = "habbicons.json";
      
      private static const UnknownConstFromHabbiconAssetManager_String_3:String = "habbicons_spritesheet.png";
      
      private static const COLLECTION_ICONS_SPRITESHEET_FILE:String = "collection_icons_spritesheet.png";
      
      private static const HABBICONS_ANIMATION_PATH:String = "animation/";
      
      private static const DEFAULT_FRAME_SIZE:int = 40;
      
      private static const DEFAULT_COLLECTION_ICON_SIZE:int = 18;
      
      private static const COLLECTION_ICON_OUTLINE_SIZE:int = 2;
      
      private static const COLLECTION_ICON_OUTLINE_COLOR:uint = 4294967295;
      
      public static const ASSETS_LOADED:String = "habbicon_assets_loaded";
      
      private static var UnknownVarFromHabbiconAssetManager_HabbiconAssetManager_1:HabbiconAssetManager;
      
      private static var UnknownVarFromHabbiconAssetManager_IComponent_1_1:IComponent_1;
      
      private static var UnknownVarFromHabbiconAssetManager_EventDispatcher_1:EventDispatcher = new EventDispatcher();
      
      private var UnknownVarFromHabbiconAssetManager_Boolean_1:Boolean = false;
      
      private var _jsonLoaded:Boolean = false;
      
      private var _sheetLoaded:Boolean = false;
      
      private var _collectionSheetLoaded:Boolean = false;
      
      private var UnknownVarFromHabbiconAssetManager_Boolean_2:Boolean = false;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_1:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_2:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_3:Dictionary;
      
      private var _previewBitmapsSmall:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_4:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_5:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_6:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_7:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_8:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_9:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_Dictionary_10:Dictionary;
      
      private var UnknownVarFromHabbiconAssetManager_BitmapData_1:BitmapData;
      
      private var UnknownVarFromHabbiconAssetManager_BitmapData_2:BitmapData;
      
      private var UnknownVarFromHabbiconAssetManager_String_1:String;
      
      public function HabbiconAssetManager()
      {
         super();
         UnknownVarFromHabbiconAssetManager_Dictionary_1 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_2 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_3 = new Dictionary();
         _previewBitmapsSmall = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_4 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_5 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_6 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_7 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_8 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_9 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_10 = new Dictionary();
      }
      
      public static function getPreviewBitmap(param1:int, param2:Boolean) : BitmapData
      {
         return getInstance().resolvePreviewBitmap(param1,param2);
      }
      
      public static function getHabbiconNameKey(param1:int) : String
      {
         return getInstance().resolveNameLocalizationKey(param1);
      }
      
      public static function getCollectionIconBitmap(param1:int) : BitmapData
      {
         return getInstance().resolveCollectionIconBitmap(param1);
      }
      
      public static function getOutlinedCollectionIconBitmap(param1:int) : BitmapData
      {
         return getInstance().resolveOutlinedCollectionIconBitmap(param1);
      }
      
      public static function getRuntimeAsset(param1:int) : Object
      {
         return getInstance().resolveRuntimeAsset(param1);
      }
      
      public static function getDirection(param1:int) : int
      {
         return getInstance().resolveDirection(param1);
      }
      
      public static function configure(param1:IComponent_1) : void
      {
         UnknownVarFromHabbiconAssetManager_IComponent_1_1 = param1;
         getInstance().refreshAssetRoot();
      }
      
      public static function preload() : void
      {
         getInstance().ensureLoaded();
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromHabbiconAssetManager_EventDispatcher_1.addEventListener(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromHabbiconAssetManager_EventDispatcher_1.removeEventListener(param1,param2);
      }
      
      private static function getInstance() : HabbiconAssetManager
      {
         if(UnknownVarFromHabbiconAssetManager_HabbiconAssetManager_1 == null)
         {
            UnknownVarFromHabbiconAssetManager_HabbiconAssetManager_1 = new HabbiconAssetManager();
         }
         return UnknownVarFromHabbiconAssetManager_HabbiconAssetManager_1;
      }
      
      private static function createOutlinedBitmap(param1:BitmapData, param2:int, param3:uint) : BitmapData
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:BitmapData = new BitmapData(param1.width + param2 * 2,param1.height + param2 * 2,true,0);
         var _loc5_:BitmapData = new BitmapData(param1.width,param1.height,true,param3);
         var _loc8_:Point = new Point();
         _loc5_.copyChannel(param1,param1.rect,_loc8_,8,8);
         _loc6_ = -param2;
         while(_loc6_ <= param2)
         {
            _loc7_ = -param2;
            while(_loc7_ <= param2)
            {
               if(!(_loc6_ == 0 && _loc7_ == 0))
               {
                  _loc8_.x = param2 + _loc6_;
                  _loc8_.y = param2 + _loc7_;
                  _loc4_.copyPixels(_loc5_,_loc5_.rect,_loc8_,null,null,true);
               }
               _loc7_++;
            }
            _loc6_++;
         }
         _loc4_.copyPixels(param1,param1.rect,new Point(param2,param2),null,null,true);
         _loc5_.dispose();
         return _loc4_;
      }
      
      private function refreshAssetRoot() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(UnknownVarFromHabbiconAssetManager_IComponent_1_1 == null)
         {
            return UnknownVarFromHabbiconAssetManager_String_1;
         }
         _loc1_ = UnknownVarFromHabbiconAssetManager_IComponent_1_1.getProperty("habbicons.asset.root");
         _loc2_ = UnknownVarFromHabbiconAssetManager_IComponent_1_1.getProperty("habbicons.asset.hash");
         if(_loc1_ == null || _loc1_ == "")
         {
            return UnknownVarFromHabbiconAssetManager_String_1;
         }
         _loc1_ = stripTrailingSlash(_loc1_);
         if(_loc2_ != null && _loc2_ != "" && (_loc1_.indexOf("{hash}") > -1 || _loc1_.indexOf("%hash%") > -1))
         {
            _loc1_ = _loc1_.split("{hash}").join(_loc2_);
            _loc1_ = _loc1_.split("%hash%").join(_loc2_);
         }
         else if(_loc2_ != null && _loc2_ != "" && !endsWithPathSegment(_loc1_,_loc2_))
         {
            _loc1_ += "/" + _loc2_;
         }
         _loc1_ += "/";
         if(UnknownVarFromHabbiconAssetManager_String_1 != _loc1_)
         {
            resetLoadedAssets();
            UnknownVarFromHabbiconAssetManager_String_1 = _loc1_;
         }
         return UnknownVarFromHabbiconAssetManager_String_1;
      }
      
      private function resetLoadedAssets() : void
      {
         UnknownVarFromHabbiconAssetManager_Boolean_1 = false;
         _jsonLoaded = false;
         _sheetLoaded = false;
         _collectionSheetLoaded = false;
         UnknownVarFromHabbiconAssetManager_Boolean_2 = false;
         UnknownVarFromHabbiconAssetManager_Dictionary_1 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_2 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_3 = new Dictionary();
         _previewBitmapsSmall = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_4 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_5 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_6 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_7 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_8 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_9 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_Dictionary_10 = new Dictionary();
         UnknownVarFromHabbiconAssetManager_BitmapData_1 = null;
         UnknownVarFromHabbiconAssetManager_BitmapData_2 = null;
      }
      
      private function stripTrailingSlash(param1:String) : String
      {
         while(param1.length > 0 && param1.charAt(param1.length - 1) == "/")
         {
            param1 = param1.substr(0,param1.length - 1);
         }
         return param1;
      }
      
      private function endsWithPathSegment(param1:String, param2:String) : Boolean
      {
         return param1 == param2 || param1.lastIndexOf("/" + param2) == param1.length - param2.length - 1;
      }
      
      private function resolvePreviewBitmap(param1:int, param2:Boolean) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc5_:Object = null;
         var _loc4_:BitmapData = null;
         ensureLoaded();
         _loc3_ = param2 ? _previewBitmapsSmall[param1] as BitmapData : UnknownVarFromHabbiconAssetManager_Dictionary_3[param1] as BitmapData;
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         if(!_jsonLoaded || !_sheetLoaded || UnknownVarFromHabbiconAssetManager_BitmapData_1 == null)
         {
            return null;
         }
         _loc5_ = UnknownVarFromHabbiconAssetManager_Dictionary_1[param1];
         if(_loc5_ == null)
         {
            return null;
         }
         _loc4_ = extractFrameBitmap(_loc5_);
         if(_loc4_ == null)
         {
            return null;
         }
         UnknownVarFromHabbiconAssetManager_Dictionary_3[param1] = _loc4_;
         if(param2)
         {
            _loc3_ = BitmapHelper.resampleBitmapData(_loc4_,0.5);
            _previewBitmapsSmall[param1] = _loc3_;
            return _loc3_;
         }
         return _loc4_;
      }
      
      private function resolveCollectionIconBitmap(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc4_:Object = null;
         var _loc3_:BitmapData = null;
         ensureLoaded();
         _loc2_ = UnknownVarFromHabbiconAssetManager_Dictionary_4[param1] as BitmapData;
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         if(!_jsonLoaded || !_collectionSheetLoaded || UnknownVarFromHabbiconAssetManager_BitmapData_2 == null)
         {
            return null;
         }
         _loc4_ = UnknownVarFromHabbiconAssetManager_Dictionary_2[param1];
         if(_loc4_ == null)
         {
            return null;
         }
         _loc3_ = extractFrameBitmapFromSheet(UnknownVarFromHabbiconAssetManager_BitmapData_2,_loc4_);
         if(_loc3_ != null)
         {
            UnknownVarFromHabbiconAssetManager_Dictionary_4[param1] = _loc3_;
         }
         return _loc3_;
      }
      
      private function resolveOutlinedCollectionIconBitmap(param1:int) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         _loc2_ = UnknownVarFromHabbiconAssetManager_Dictionary_5[param1] as BitmapData;
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc3_ = resolveCollectionIconBitmap(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         _loc2_ = createOutlinedBitmap(_loc3_,2,4294967295);
         UnknownVarFromHabbiconAssetManager_Dictionary_5[param1] = _loc2_;
         return _loc2_;
      }
      
      private function resolveNameLocalizationKey(param1:int) : String
      {
         ensureLoaded();
         return UnknownVarFromHabbiconAssetManager_Dictionary_6[param1];
      }
      
      private function resolveDirection(param1:int) : int
      {
         var _loc2_:HabbiconDefinition = null;
         ensureLoaded();
         _loc2_ = UnknownVarFromHabbiconAssetManager_Dictionary_7[param1] as HabbiconDefinition;
         return _loc2_ != null ? _loc2_.direction : 0;
      }
      
      private function resolveRuntimeAsset(param1:int) : Object
      {
         var _loc3_:HabbiconDefinition = null;
         var _loc2_:Object = null;
         ensureLoaded();
         _loc2_ = UnknownVarFromHabbiconAssetManager_Dictionary_9[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc3_ = UnknownVarFromHabbiconAssetManager_Dictionary_7[param1] as HabbiconDefinition;
         if(_loc3_ == null)
         {
            return null;
         }
         if(_loc3_.animated)
         {
            loadRuntimeAsset(param1,_loc3_);
         }
         _loc2_ = UnknownVarFromHabbiconAssetManager_Dictionary_8[param1];
         if(_loc2_ == null)
         {
            _loc2_ = buildFallbackRuntimeAsset(param1,_loc3_);
            if(_loc2_ != null)
            {
               UnknownVarFromHabbiconAssetManager_Dictionary_8[param1] = _loc2_;
            }
         }
         return _loc2_;
      }
      
      private function ensureLoaded() : void
      {
         var _loc1_:URLLoader = null;
         var _loc2_:Loader = null;
         var _loc4_:Loader = null;
         var _loc3_:String = null;
         if(UnknownVarFromHabbiconAssetManager_Boolean_1 || _jsonLoaded && _sheetLoaded && _collectionSheetLoaded || UnknownVarFromHabbiconAssetManager_Boolean_2)
         {
            return;
         }
         _loc3_ = refreshAssetRoot();
         if(_loc3_ == null || _loc3_ == "")
         {
            Logger.log("[HabbiconAssetManager] Habbicon asset root is not configured.");
            markLoadFailed();
            return;
         }
         UnknownVarFromHabbiconAssetManager_Boolean_1 = true;
         _loc1_ = new URLLoader();
         _loc1_.dataFormat = "text";
         _loc1_.addEventListener("complete",onMetadataLoaded);
         _loc1_.addEventListener("ioError",onLoadError);
         _loc1_.addEventListener("securityError",onSecurityError);
         _loc1_.load(new URLRequest(_loc3_ + "habbicons.json"));
         _loc2_ = new Loader();
         _loc2_.contentLoaderInfo.addEventListener("complete",onSpritesheetLoaded);
         _loc2_.contentLoaderInfo.addEventListener("ioError",onLoadError);
         _loc2_.contentLoaderInfo.addEventListener("securityError",onSecurityError);
         _loc2_.load(new URLRequest(_loc3_ + "habbicons_spritesheet.png"));
         _loc4_ = new Loader();
         _loc4_.contentLoaderInfo.addEventListener("complete",onCollectionSpritesheetLoaded);
         _loc4_.contentLoaderInfo.addEventListener("ioError",onCollectionLoadError);
         _loc4_.contentLoaderInfo.addEventListener("securityError",onCollectionSecurityError);
         _loc4_.load(new URLRequest(_loc3_ + "collection_icons_spritesheet.png"));
      }
      
      private function onMetadataLoaded(param1:Event) : void
      {
         var _loc4_:Object = null;
         var _loc3_:Array = null;
         var _loc5_:Array = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:URLLoader = param1.currentTarget as URLLoader;
         removeTextLoaderListeners(_loc6_);
         try
         {
            _loc4_ = JSON.parse(_loc6_.data as String);
            _loc3_ = _loc4_ && _loc4_.habbicons is Array ? _loc4_.habbicons as Array : [];
            for each(_loc2_ in _loc3_)
            {
               if(!(_loc2_ == null || _loc2_.id == null))
               {
                  _loc7_ = normalizeDimension(_loc2_.width);
                  _loc8_ = normalizeDimension(_loc2_.height);
                  UnknownVarFromHabbiconAssetManager_Dictionary_1[int(_loc2_.id)] = {
                     "x":int(_loc2_.x),
                     "y":int(_loc2_.y),
                     "width":_loc7_,
                     "height":_loc8_
                  };
                  if(_loc2_.name != null)
                  {
                     UnknownVarFromHabbiconAssetManager_Dictionary_6[int(_loc2_.id)] = String(_loc2_.name);
                  }
                  UnknownVarFromHabbiconAssetManager_Dictionary_7[int(_loc2_.id)] = buildDefinition(_loc2_,_loc7_,_loc8_);
               }
            }
            _loc5_ = _loc4_ && _loc4_.collectionIcons is Array ? _loc4_.collectionIcons as Array : [];
            for each(_loc2_ in _loc5_)
            {
               if(!(_loc2_ == null || _loc2_.id == null))
               {
                  UnknownVarFromHabbiconAssetManager_Dictionary_2[int(_loc2_.id)] = {
                     "x":int(_loc2_.x),
                     "y":int(_loc2_.y),
                     "width":normalizeDimension(_loc2_.width,18),
                     "height":normalizeDimension(_loc2_.height,18)
                  };
               }
            }
            _jsonLoaded = true;
            checkLoadCompletion();
         }
         catch(error:Error)
         {
            Logger.log("[HabbiconAssetManager] Failed to parse habbicon metadata: " + error.message);
            markLoadFailed();
         }
      }
      
      private function onSpritesheetLoaded(param1:Event) : void
      {
         var _loc3_:Bitmap = null;
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         removeImageLoaderListeners(_loc2_);
         _loc3_ = _loc2_.content as Bitmap;
         if(_loc3_ == null || _loc3_.bitmapData == null)
         {
            Logger.log("[HabbiconAssetManager] Loaded habbicon spritesheet without bitmap data.");
            markLoadFailed();
            return;
         }
         UnknownVarFromHabbiconAssetManager_BitmapData_1 = _loc3_.bitmapData;
         _sheetLoaded = true;
         checkLoadCompletion();
      }
      
      private function onCollectionSpritesheetLoaded(param1:Event) : void
      {
         var _loc3_:Bitmap = null;
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         removeImageLoaderListeners(_loc2_,onCollectionSpritesheetLoaded,onCollectionLoadError,onCollectionSecurityError);
         _loc3_ = _loc2_.content as Bitmap;
         if(_loc3_ == null || _loc3_.bitmapData == null)
         {
            Logger.log("[HabbiconAssetManager] Loaded habbicon collection icon spritesheet without bitmap data.");
            _collectionSheetLoaded = true;
            checkLoadCompletion();
            return;
         }
         UnknownVarFromHabbiconAssetManager_BitmapData_2 = _loc3_.bitmapData;
         _collectionSheetLoaded = true;
         checkLoadCompletion();
      }
      
      private function onLoadError(param1:IOErrorEvent) : void
      {
         Logger.log("[HabbiconAssetManager] Failed to load habbicon asset: " + param1.text);
         markLoadFailed();
      }
      
      private function onCollectionLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         removeImageLoaderListeners(_loc2_,onCollectionSpritesheetLoaded,onCollectionLoadError,onCollectionSecurityError);
         Logger.log("[HabbiconAssetManager] Failed to load habbicon collection icon asset: " + param1.text);
         _collectionSheetLoaded = true;
         checkLoadCompletion();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         Logger.log("[HabbiconAssetManager] Security error while loading habbicon asset: " + param1.text);
         markLoadFailed();
      }
      
      private function onCollectionSecurityError(param1:SecurityErrorEvent) : void
      {
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         removeImageLoaderListeners(_loc2_,onCollectionSpritesheetLoaded,onCollectionLoadError,onCollectionSecurityError);
         Logger.log("[HabbiconAssetManager] Security error while loading habbicon collection icon asset: " + param1.text);
         _collectionSheetLoaded = true;
         checkLoadCompletion();
      }
      
      private function markLoadFailed() : void
      {
         UnknownVarFromHabbiconAssetManager_Boolean_1 = false;
         UnknownVarFromHabbiconAssetManager_Boolean_2 = true;
      }
      
      private function checkLoadCompletion() : void
      {
         if(_jsonLoaded && _sheetLoaded && _collectionSheetLoaded)
         {
            UnknownVarFromHabbiconAssetManager_Boolean_1 = false;
            UnknownVarFromHabbiconAssetManager_EventDispatcher_1.dispatchEvent(new Event("habbicon_assets_loaded"));
         }
      }
      
      private function buildDefinition(param1:Object, param2:int, param3:int) : HabbiconDefinition
      {
         var _loc5_:Array = null;
         var _loc8_:Object = null;
         var _loc7_:Array = null;
         var _loc6_:Boolean = false;
         var _loc4_:Number = 1;
         _loc5_ = param1.frameData is Array ? param1.frameData as Array : [];
         _loc8_ = param1.animation;
         _loc7_ = _loc8_ != null && _loc8_.steps is Array ? _loc8_.steps as Array : [];
         if(_loc8_ != null && _loc8_.playbackSpeed != null)
         {
            _loc4_ = Number(_loc8_.playbackSpeed);
         }
         if(isNaN(_loc4_) || _loc4_ <= 0)
         {
            _loc4_ = 1;
         }
         _loc6_ = int(param1.frameCount) > 1 && _loc5_.length > 0 && _loc7_.length > 0;
         return new HabbiconDefinition(param2,param3,normalizeDirection(param1.dir),_loc6_,param1 != null && param1.loop,buildRuntimeFrameDefinitions(_loc5_,param2,param3),buildRuntimeAnimationSteps(_loc7_,_loc4_));
      }
      
      private function buildRuntimeFrameDefinitions(param1:Array, param2:int, param3:int) : Array
      {
         var _loc5_:* = null;
         var _loc4_:Array = [];
         if(param1 == null)
         {
            return _loc4_;
         }
         for each(_loc5_ in param1)
         {
            if(_loc5_ != null)
            {
               _loc4_.push({
                  "id":int(_loc5_.id),
                  "x":int(_loc5_.x),
                  "y":int(_loc5_.y),
                  "width":normalizeDimension(_loc5_.width,param2),
                  "height":normalizeDimension(_loc5_.height,param3)
               });
            }
         }
         _loc4_.sortOn("id",16);
         return _loc4_;
      }
      
      private function buildRuntimeAnimationSteps(param1:Array, param2:Number) : Array
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         if(param1 == null)
         {
            return _loc3_;
         }
         for each(_loc4_ in param1)
         {
            if(_loc4_ != null)
            {
               if(_loc4_.enabled !== false)
               {
                  _loc5_ = Math.max(1,int(_loc4_.durationMs));
                  _loc5_ = Math.max(1,_loc5_ / param2);
                  _loc3_.push({
                     "sourceFrame":Math.max(0,int(_loc4_.sourceFrame)),
                     "durationMs":_loc5_
                  });
               }
            }
         }
         return _loc3_;
      }
      
      private function buildFallbackRuntimeAsset(param1:int, param2:HabbiconDefinition) : Object
      {
         var _loc3_:BitmapData = resolvePreviewBitmap(param1,false);
         var _loc4_:BitmapData = resolvePreviewBitmap(param1,true);
         if(_loc3_ == null)
         {
            return null;
         }
         return {
            "animated":false,
            "loop":false,
            "direction":param2.direction,
            "baseWidth":_loc3_.width,
            "baseHeight":_loc3_.height,
            "frames":[{
               "bitmap":_loc3_,
               "smallBitmap":_loc4_ ?? _loc3_,
               "width":_loc3_.width,
               "height":_loc3_.height
            }],
            "steps":[{
               "sourceFrame":0,
               "durationMs":0
            }],
            "playbackDurationMs":0
         };
      }
      
      private function loadRuntimeAsset(param1:int, param2:HabbiconDefinition) : void
      {
         var _loc3_:Loader = null;
         var _loc4_:String = null;
         if(param2 == null || !param2.animated || UnknownVarFromHabbiconAssetManager_Dictionary_10[param1] || UnknownVarFromHabbiconAssetManager_Dictionary_9[param1] != null)
         {
            return;
         }
         _loc4_ = refreshAssetRoot();
         if(_loc4_ == null || _loc4_ == "")
         {
            return;
         }
         UnknownVarFromHabbiconAssetManager_Dictionary_10[param1] = true;
         _loc3_ = new Loader();
         _loc3_.name = String(param1);
         _loc3_.contentLoaderInfo.addEventListener("complete",onRuntimeSheetLoaded);
         _loc3_.contentLoaderInfo.addEventListener("ioError",onRuntimeLoadError);
         _loc3_.contentLoaderInfo.addEventListener("securityError",onRuntimeSecurityError);
         _loc3_.load(new URLRequest(_loc4_ + "animation/" + param1 + ".png"));
      }
      
      private function onRuntimeSheetLoaded(param1:Event) : void
      {
         var _loc3_:Loader = param1.currentTarget.loader as Loader;
         var _loc4_:Bitmap = _loc3_ != null ? _loc3_.content as Bitmap : null;
         var _loc2_:int = int(_loc3_ != null ? int(_loc3_.name) : 0);
         var _loc5_:HabbiconDefinition = UnknownVarFromHabbiconAssetManager_Dictionary_7[_loc2_] as HabbiconDefinition;
         removeImageLoaderListeners(_loc3_,onRuntimeSheetLoaded,onRuntimeLoadError,onRuntimeSecurityError);
         delete UnknownVarFromHabbiconAssetManager_Dictionary_10[_loc2_];
         if(_loc4_ == null || _loc4_.bitmapData == null || _loc5_ == null)
         {
            return;
         }
         UnknownVarFromHabbiconAssetManager_Dictionary_9[_loc2_] = buildAnimatedRuntimeAsset(_loc5_,_loc4_.bitmapData);
      }
      
      private function onRuntimeLoadError(param1:IOErrorEvent) : void
      {
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         if(_loc2_ != null)
         {
            removeImageLoaderListeners(_loc2_,onRuntimeSheetLoaded,onRuntimeLoadError,onRuntimeSecurityError);
            delete UnknownVarFromHabbiconAssetManager_Dictionary_10[int(_loc2_.name)];
         }
         Logger.log("[HabbiconAssetManager] Failed to load habbicon runtime asset: " + param1.text);
      }
      
      private function onRuntimeSecurityError(param1:SecurityErrorEvent) : void
      {
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         if(_loc2_ != null)
         {
            removeImageLoaderListeners(_loc2_,onRuntimeSheetLoaded,onRuntimeLoadError,onRuntimeSecurityError);
            delete UnknownVarFromHabbiconAssetManager_Dictionary_10[int(_loc2_.name)];
         }
         Logger.log("[HabbiconAssetManager] Security error while loading habbicon runtime asset: " + param1.text);
      }
      
      private function buildAnimatedRuntimeAsset(param1:HabbiconDefinition, param2:BitmapData) : Object
      {
         var _loc8_:* = null;
         var _loc5_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc6_:* = null;
         var _loc4_:Array = [];
         var _loc3_:int = 0;
         if(param1 == null || param2 == null || param1.frames == null || param1.frames.length == 0)
         {
            return null;
         }
         for each(_loc8_ in param1.frames)
         {
            _loc5_ = extractFrameBitmapFromSheet(param2,_loc8_);
            if(_loc5_ != null)
            {
               _loc7_ = BitmapHelper.resampleBitmapData(_loc5_,0.5);
               _loc4_.push({
                  "bitmap":_loc5_,
                  "smallBitmap":_loc7_,
                  "width":_loc5_.width,
                  "height":_loc5_.height
               });
            }
         }
         if(_loc4_.length == 0)
         {
            return null;
         }
         for each(_loc6_ in param1.steps)
         {
            _loc3_ += Math.max(1,int(_loc6_.durationMs));
         }
         return {
            "animated":true,
            "loop":param1.loop,
            "direction":param1.direction,
            "baseWidth":param1.previewWidth,
            "baseHeight":param1.previewHeight,
            "frames":_loc4_,
            "steps":(param1.steps != null && param1.steps.length > 0 ? param1.steps : [{
               "sourceFrame":0,
               "durationMs":0
            }]),
            "playbackDurationMs":_loc3_
         };
      }
      
      private function extractFrameBitmap(param1:Object) : BitmapData
      {
         var _loc2_:Rectangle = null;
         var _loc3_:BitmapData = null;
         _loc2_ = createValidRect(int(param1.x),int(param1.y),int(param1.width),int(param1.height));
         if(_loc2_ == null)
         {
            return null;
         }
         _loc3_ = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc3_.copyPixels(UnknownVarFromHabbiconAssetManager_BitmapData_1,_loc2_,new Point(0,0),null,null,true);
         return _loc3_;
      }
      
      private function extractFrameBitmapFromSheet(param1:BitmapData, param2:Object) : BitmapData
      {
         var _loc3_:Rectangle = null;
         var _loc4_:BitmapData = null;
         _loc3_ = createValidRectForSheet(param1,int(param2.x),int(param2.y),int(param2.width),int(param2.height));
         if(_loc3_ == null)
         {
            return null;
         }
         _loc4_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc4_.copyPixels(param1,_loc3_,new Point(0,0),null,null,true);
         return _loc4_;
      }
      
      private function createValidRect(param1:int, param2:int, param3:int, param4:int) : Rectangle
      {
         return createValidRectForSheet(UnknownVarFromHabbiconAssetManager_BitmapData_1,param1,param2,param3,param4);
      }
      
      private function createValidRectForSheet(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : Rectangle
      {
         var _loc6_:Rectangle = null;
         if(param1 == null)
         {
            return null;
         }
         _loc6_ = new Rectangle(param2,param1.height - param3 - param5,param4,param5);
         if(isRectWithinBitmap(param1,_loc6_))
         {
            return _loc6_;
         }
         _loc6_ = new Rectangle(param2,param3,param4,param5);
         if(isRectWithinBitmap(param1,_loc6_))
         {
            return _loc6_;
         }
         return null;
      }
      
      private function isRectWithinBitmap(param1:BitmapData, param2:Rectangle) : Boolean
      {
         return param1 != null && param2.x >= 0 && param2.y >= 0 && param2.right <= param1.width && param2.bottom <= param1.height;
      }
      
      private function normalizeDimension(param1:*, param2:int = 40) : int
      {
         var _loc3_:int = param1;
         return _loc3_ > 0 ? _loc3_ : param2;
      }
      
      private function normalizeDirection(param1:*) : int
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return 0;
         }
         _loc2_ = param1;
         if(_loc2_ < 0)
         {
            return -1;
         }
         if(_loc2_ > 0)
         {
            return 1;
         }
         return 0;
      }
      
      private function removeTextLoaderListeners(param1:URLLoader) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("complete",onMetadataLoaded);
         param1.removeEventListener("ioError",onLoadError);
         param1.removeEventListener("securityError",onSecurityError);
      }
      
      private function removeImageLoaderListeners(param1:Loader, param2:Function = null, param3:Function = null, param4:Function = null) : void
      {
         if(param1 == null || param1.contentLoaderInfo == null)
         {
            return;
         }
         param1.contentLoaderInfo.removeEventListener("complete",param2 ?? onSpritesheetLoaded);
         param1.contentLoaderInfo.removeEventListener("ioError",param3 ?? onLoadError);
         param1.contentLoaderInfo.removeEventListener("securityError",param4 ?? onSecurityError);
      }
   }
}

