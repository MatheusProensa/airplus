package com.sulake.habbo.session
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.session.events.FurniIconImageReadyEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   
   public class FurniIconImageManager
   {
      private const ASSET_PREFIX:String = "furni_icon_";
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromFurniIconImageManager_IEventDispatcher_1:IEventDispatcher;
      
      private var UnknownVarFromFurniIconImageManager_IComponent_1_1:IComponent_1;
      
      private var _sessionDataManager:SessionDataManager;
      
      private var _loadingInfo:Map;
      
      public function FurniIconImageManager(param1:IAssetLibraryCollection, param2:IEventDispatcher, param3:IComponent_1, param4:SessionDataManager)
      {
         super();
         if(param1 == null)
         {
            param1 = new AssetLibrary("furni_icon_images");
         }
         _loadingInfo = new Map();
         _assets = param1;
         UnknownVarFromFurniIconImageManager_IEventDispatcher_1 = param2;
         UnknownVarFromFurniIconImageManager_IComponent_1_1 = param3;
         _sessionDataManager = param4;
      }
      
      public function dispose() : void
      {
         _assets = null;
      }
      
      private function getData(param1:Boolean, param2:int, param3:String) : IFurnitureData
      {
         if(param1)
         {
            return _sessionDataManager.getWallItemData(param2);
         }
         return _sessionDataManager.getFloorItemData(param2);
      }
      
      private function getClassName(param1:Boolean, param2:int, param3:String) : String
      {
         var _loc4_:IFurnitureData = getData(param1,param2,param3);
         if(_loc4_ == null)
         {
            return String(param1) + "_" + param2 + "_" + param3;
         }
         return _loc4_.className + param3;
      }
      
      private function getAssetName(param1:Boolean, param2:int, param3:String) : String
      {
         var _loc5_:String = "furni_icon_" + getClassName(param1,param2,param3);
         var _loc4_:IFurnitureData = getData(param1,param2,param3);
         if(_loc4_ == null)
         {
            return _loc5_;
         }
         if(_loc4_.hasIndexedColor)
         {
            _loc5_ += "_" + _loc4_.colourIndex;
         }
         return _loc5_;
      }
      
      public function getFurniIconImage(param1:Boolean, param2:int, param3:String, param4:Boolean = true) : BitmapData
      {
         var _loc5_:BitmapData = getFurniIconImageInternal(param1,param2,param3);
         if(!_loc5_ && param4)
         {
            _loc5_ = getPlaceholder();
         }
         return _loc5_;
      }
      
      public function getFurniIconImageAssetName(param1:Boolean, param2:int, param3:String) : String
      {
         var _loc4_:String = getAssetName(param1,param2,param3);
         if(_assets.hasAsset(_loc4_))
         {
            return _loc4_;
         }
         getFurniIconImageInternal(param1,param2,param3);
         return null;
      }
      
      private function getFurniIconImageInternal(param1:Boolean, param2:int, param3:String) : BitmapData
      {
         var _loc13_:BitmapDataAsset = null;
         var _loc9_:URLRequest = null;
         var _loc6_:String = null;
         var _loc4_:IFurnitureData = null;
         var _loc11_:Boolean = false;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:AssetLoaderStruct = null;
         var _loc8_:String = getClassName(param1,param2,param3);
         var _loc12_:String = getAssetName(param1,param2,param3);
         if(_assets.hasAsset(_loc12_))
         {
            _loc13_ = _assets.getAssetByName(_loc12_) as BitmapDataAsset;
            return (_loc13_.content as BitmapData).clone();
         }
         Logger.log("Request furni icon: " + _loc12_);
         if(UnknownVarFromFurniIconImageManager_IComponent_1_1 != null)
         {
            _loc4_ = getData(param1,param2,param3);
            if(_loc4_ == null)
            {
               return null;
            }
            _loc11_ = _loc4_.hasIndexedColor;
            _loc7_ = _loc4_.colourIndex;
            _loc10_ = _loc4_.revision;
            _loc6_ = UnknownVarFromFurniIconImageManager_IComponent_1_1.getProperty("flash.dynamic.download.url");
            _loc6_ = _loc6_ + UnknownVarFromFurniIconImageManager_IComponent_1_1.getProperty("flash.dynamic.icon.download.name.template");
            _loc6_ = _loc6_.replace("%revision%",String(_loc10_));
            _loc6_ = _loc6_.replace("%typeid%",_loc8_);
            _loc6_ = _loc6_.replace("%param%",_loc11_ ? "_" + _loc7_ : "");
            _loc9_ = new URLRequest(_loc6_);
         }
         if(_loc9_ != null && !_loadingInfo.hasKey(_loc12_))
         {
            _loc5_ = _assets.loadAssetFromFile(_loc12_,_loc9_,"image/png");
            _loadingInfo.add(_loc12_,[param1,param2,param3]);
            _loc5_.addEventListener("AssetLoaderEventComplete",onFurniIconImageReady);
            _loc5_.addEventListener("AssetLoaderEventError",onFurniIconImageError);
         }
         return null;
      }
      
      private function onFurniIconImageError(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null && _loc2_.assetLoader != null)
         {
            _loadingInfo.remove(_loc2_.assetLoader.id);
         }
      }
      
      private function getPlaceholder() : BitmapData
      {
         return BitmapData(_assets.getAssetByName("loading_icon").content).clone();
      }
      
      private function onFurniIconImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc5_:Array = null;
         var _loc3_:String = null;
         var _loc2_:Bitmap = null;
         var _loc4_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc4_ != null && _loc4_.assetLoader != null)
         {
            _loc5_ = _loadingInfo.remove(_loc4_.assetName);
            if(_loc5_ == null)
            {
               return;
            }
            if(_loc4_.assetLoader.content != null)
            {
               _loc3_ = _loc4_.assetName;
               _loc2_ = _loc4_.assetLoader.content as Bitmap;
               if(_loc2_ == null)
               {
                  return;
               }
               UnknownVarFromFurniIconImageManager_IEventDispatcher_1.dispatchEvent(new FurniIconImageReadyEvent(_loc3_,_loc5_[0],_loc5_[1],_loc5_[2],_loc2_.bitmapData.clone()));
            }
         }
      }
   }
}

