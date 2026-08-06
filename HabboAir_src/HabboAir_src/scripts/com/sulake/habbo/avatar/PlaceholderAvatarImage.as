package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import flash.display.BitmapData;
   
   public class PlaceholderAvatarImage extends AvatarImage
   {
      internal static var _fullImageCache:Map = new Map();
      
      public function PlaceholderAvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String, param5:EffectAssetDownloadManager)
      {
         super(param1,param2,param3,param4,param5,null);
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            if(_cache)
            {
               _cache.dispose();
               _cache = null;
            }
            UnknownVarFromAvatarImage_AvatarStructure_1 = null;
            _assets = null;
            UnknownVarFromAvatarImage_IActiveActionData_1 = null;
            _figure = null;
            _avatarSpriteData = null;
            UnknownVarFromAvatarImage_Array_1 = null;
            if(!UnknownVarFromAvatarImage_Boolean_3 && UnknownVarFromAvatarImage_BitmapData_1)
            {
               UnknownVarFromAvatarImage_BitmapData_1.dispose();
            }
            UnknownVarFromAvatarImage_BitmapData_1 = null;
            _canvasOffsets = null;
            _disposed = true;
         }
      }
      
      override protected function getFullImage(param1:String) : BitmapData
      {
         return _fullImageCache[param1];
      }
      
      override protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         if(_fullImageCache.getValue(param1))
         {
            (_fullImageCache.getValue(param1) as BitmapData).dispose();
            _fullImageCache.remove(param1);
         }
         _fullImageCache[param1] = param2;
      }
      
      override public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:String = null;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = rest[0];
         }
         switch(param1)
         {
            case "posture":
               switch(_loc3_)
               {
                  case "lay":
                  case "mv":
                  case "std":
                  case "swim":
                  case "float":
                  case "sit":
                     super.appendAction.apply(null,[param1].concat(rest));
               }
               break;
            case "fx":
            case "dance":
            case "wave":
            case "sign":
            case "cri":
            case "usei":
            case "blow":
            case "67":
               super.addActionData.apply(null,[param1].concat(rest));
         }
         return true;
      }
      
      override public function isPlaceholder() : Boolean
      {
         return true;
      }
   }
}

