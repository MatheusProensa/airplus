package com.sulake.habbo.session
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class BadgeImageManager
   {
      public static const UnknownConstFromBadgeImageManager_String_1:String = "group_badge";
      
      public static const TYPE_NORMAL:String = "normal_badge";
      
      private const ASSET_PREFIX:String = "badge_";
      
      private const ASSET_SMALL_POSTFIX:String = "_32";
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromBadgeImageManager_IEventDispatcher_1:IEventDispatcher;
      
      private var UnknownVarFromBadgeImageManager_IComponent_1_1:IComponent_1;
      
      private var _requestedGroupBadges:Dictionary = new Dictionary();
      
      public function BadgeImageManager(param1:IAssetLibraryCollection, param2:IEventDispatcher, param3:IComponent_1)
      {
         super();
         if(param1 == null)
         {
            param1 = new AssetLibrary("badge_images");
         }
         _assets = param1;
         UnknownVarFromBadgeImageManager_IEventDispatcher_1 = param2;
         UnknownVarFromBadgeImageManager_IComponent_1_1 = param3;
      }
      
      public function dispose() : void
      {
         _assets = null;
      }
      
      public function getBadgeImage(param1:String, param2:String = "normal_badge", param3:Boolean = true, param4:Boolean = false) : BitmapData
      {
         var _loc5_:BitmapData = getBadgeImageInternal(param1,param2,param4);
         if(!_loc5_ && param3)
         {
            _loc5_ = getPlaceholder();
         }
         return _loc5_;
      }
      
      public function getSmallBadgeImage(param1:String, param2:String = "normal_badge") : BitmapData
      {
         if(getBadgeImageInternal(param1,param2,true) == null && getBadgeImageInternal(param1) != null)
         {
            createSmallBadgeBitmap("badge_" + param1,param1);
         }
         return getBadgeImage(param1,param2,false,true);
      }
      
      public function getBadgeImageWithInfo(param1:String) : BadgeInfo
      {
         var _loc2_:BitmapData = getBadgeImageInternal(param1);
         return _loc2_ != null ? new BadgeInfo(_loc2_,false) : new BadgeInfo(getPlaceholder(),true);
      }
      
      public function getBadgeImageAssetName(param1:String, param2:String = "normal_badge", param3:Boolean = false) : String
      {
         var _loc4_:String = "badge_" + param1 + (param3 ? "_32" : "");
         if(_assets.hasAsset(_loc4_))
         {
            return _loc4_;
         }
         getBadgeImageInternal(param1,param2,param3);
         return null;
      }
      
      public function getSmallScaleBadgeAssetName(param1:String, param2:String = "normal_badge") : String
      {
         var _loc3_:String = getBadgeImageAssetName(param1,param2,true);
         if(_loc3_ == null)
         {
            createSmallBadgeBitmap("badge_" + param1,param1);
            return getBadgeImageAssetName(param1,param2,true);
         }
         return _loc3_;
      }
      
      private function getBadgeImageInternal(param1:String, param2:String = "normal_badge", param3:Boolean = false) : BitmapData
      {
         var _loc7_:BitmapDataAsset = null;
         var _loc8_:URLRequest = null;
         var _loc5_:String = null;
         var _loc4_:AssetLoaderStruct = null;
         var _loc6_:String = "badge_" + param1 + (param3 ? "_32" : "");
         if(_assets.hasAsset(_loc6_))
         {
            _loc7_ = _assets.getAssetByName(_loc6_) as BitmapDataAsset;
            return (_loc7_.content as BitmapData).clone();
         }
         if(param3)
         {
            return null;
         }
         Logger.log("Request badge: " + param1);
         switch(param2)
         {
            case "normal_badge":
               if(UnknownVarFromBadgeImageManager_IComponent_1_1 != null)
               {
                  _loc5_ = UnknownVarFromBadgeImageManager_IComponent_1_1.getProperty("image.library.url");
                  _loc5_ = _loc5_ + ("album1584/" + param1 + ".png");
                  _loc8_ = new URLRequest(_loc5_);
               }
               break;
            case "group_badge":
               if(UnknownVarFromBadgeImageManager_IComponent_1_1 != null && !_requestedGroupBadges[_loc6_])
               {
                  _loc5_ = UnknownVarFromBadgeImageManager_IComponent_1_1.getProperty("group.badge.url");
                  _loc5_ = _loc5_.replace("%imagerdata%",param1);
                  if(_loc5_.substr(-4) == ".gif")
                  {
                     _loc5_ = _loc5_.slice(0,-3) + "png";
                  }
                  _loc8_ = new URLRequest(_loc5_);
                  _requestedGroupBadges[_loc6_] = true;
               }
         }
         if(_loc8_ != null)
         {
            _loc4_ = _assets.loadAssetFromFile(_loc6_,_loc8_,"image/png");
            _loc4_.addEventListener("AssetLoaderEventComplete",onBadgeImageReady);
         }
         return null;
      }
      
      private function getPlaceholder() : BitmapData
      {
         return BitmapData(_assets.getAssetByName("loading_icon").content).clone();
      }
      
      private function onBadgeImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = null;
         var _loc2_:Bitmap = null;
         var _loc5_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc5_ != null)
         {
            if(_loc5_.assetLoader != null && _loc5_.assetLoader.content != null)
            {
               _loc4_ = _loc5_.assetName;
               _loc3_ = _loc4_.replace("badge_","");
               _loc2_ = _loc5_.assetLoader.content as Bitmap;
               if(_loc2_ == null)
               {
                  return;
               }
               UnknownVarFromBadgeImageManager_IEventDispatcher_1.dispatchEvent(new BadgeImageReadyEvent(_loc3_,_loc2_.bitmapData.clone()));
            }
         }
      }
      
      private function createSmallBadgeBitmap(param1:String, param2:String) : void
      {
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:BitmapData = renderSmallScaleBadgeBitmap(param1);
         if(_loc3_)
         {
            _loc4_ = new BitmapDataAsset(_assets.getAssetTypeDeclarationByClass(BitmapDataAsset));
            if(_loc4_ != null)
            {
               _assets.setAsset("badge_" + param2 + "_32",_loc4_);
               _loc4_.setUnknownContent(_loc3_);
            }
         }
      }
      
      private function renderSmallScaleBadgeBitmap(param1:String) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc2_:Matrix = null;
         var _loc4_:ISoundAsset = _assets.getAssetByName(param1);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.content as BitmapData;
            _loc5_ = new BitmapData(_loc3_.width / 2,_loc3_.height / 2,true,0);
            _loc2_ = new Matrix(0.5,0,0,0.5);
            _loc5_.draw(_loc3_,_loc2_,null,null,null,true);
            return _loc5_;
         }
         return null;
      }
   }
}

