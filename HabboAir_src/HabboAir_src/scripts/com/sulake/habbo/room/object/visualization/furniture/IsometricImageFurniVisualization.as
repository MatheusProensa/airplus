package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class IsometricImageFurniVisualization extends AnimatedFurnitureVisualization
   {
      protected static const THUMBNAIL_SPRITE_TAG:String = "THUMBNAIL";
      
      private var _thumbnailAssetNameSmall:String = null;
      
      private var _thumbnailAssetNameNormal:String = null;
      
      private var UnknownVarFromIsometricImageFurniVisualization_Boolean_1:Boolean = false;
      
      private var _thumbnailImageSmall:BitmapData;
      
      private var _thumbnailImageNormal:BitmapData;
      
      private var UnknownVarFromIsometricImageFurniVisualization_Int_1:int;
      
      private var UnknownVarFromIsometricImageFurniVisualization_Boolean_2:Boolean;
      
      public function IsometricImageFurniVisualization()
      {
         super();
      }
      
      public function set hasOutline(param1:Boolean) : void
      {
         UnknownVarFromIsometricImageFurniVisualization_Boolean_1 = param1;
      }
      
      public function get hasThumbnailImage() : Boolean
      {
         return _thumbnailImageNormal != null;
      }
      
      public function setThumbnailImages(param1:BitmapData, param2:BitmapData = null) : void
      {
         _thumbnailImageNormal = param1;
         _thumbnailImageSmall = param2 ?? param1;
         UnknownVarFromIsometricImageFurniVisualization_Boolean_2 = true;
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:Boolean = super.updateModel(param1);
         if(!object)
         {
            return _loc2_;
         }
         if(!UnknownVarFromIsometricImageFurniVisualization_Boolean_2 && UnknownVarFromIsometricImageFurniVisualization_Int_1 == direction)
         {
            return _loc2_;
         }
         refreshThumbnail();
         return true;
      }
      
      private function refreshThumbnail() : void
      {
         if(assetCollection == null)
         {
            return;
         }
         if(_thumbnailImageNormal != null)
         {
            addThumbnailAsset(_thumbnailImageNormal,64);
            addThumbnailAsset(_thumbnailImageSmall,32);
         }
         else
         {
            clearThumbnailSpriteAssets();
            assetCollection.disposeAsset(getThumbnailAssetName(64));
            assetCollection.disposeAsset(getThumbnailAssetName(32));
         }
         UnknownVarFromIsometricImageFurniVisualization_Boolean_2 = false;
         UnknownVarFromIsometricImageFurniVisualization_Int_1 = direction;
      }
      
      private function addThumbnailAsset(param1:BitmapData, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc4_:IGraphicAsset = null;
         var _loc3_:BitmapData = null;
         var _loc7_:String = null;
         _loc5_ = 0;
         while(_loc5_ < spriteCount)
         {
            if(getSpriteTag(param2,direction,_loc5_) == "THUMBNAIL")
            {
               _loc6_ = getSpriteAssetNameWithoutFrame(param2,_loc5_,false) + getFrameNumber(param2,_loc5_);
               _loc4_ = getAsset(_loc6_,_loc5_);
               if(_loc4_ != null)
               {
                  _loc3_ = generateTransformedThumbnail(param1,_loc4_);
                  _loc7_ = getThumbnailAssetName(param2);
                  clearThumbnailSpriteAssets();
                  assetCollection.disposeAsset(_loc7_);
                  assetCollection.addAsset(_loc7_,_loc3_,true,_loc4_.offsetX,_loc4_.offsetY);
               }
               return;
            }
            _loc5_++;
         }
      }
      
      private function clearThumbnailSpriteAssets() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IRoomObjectSprite = null;
         _loc2_ = 0;
         while(_loc2_ < spriteCount)
         {
            _loc1_ = getSprite(_loc2_);
            if(_loc1_ != null && _loc1_.tag == "THUMBNAIL")
            {
               _loc1_.asset = null;
            }
            _loc2_++;
         }
      }
      
      private function generateTransformedThumbnail(param1:BitmapData, param2:IGraphicAsset) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc8_:Bitmap = null;
         var _loc7_:ColorTransform = null;
         var _loc4_:Number = 1.1;
         var _loc6_:Matrix = new Matrix();
         var _loc5_:Number = param2.width / param1.width;
         switch(direction)
         {
            case 0:
            case 4:
               _loc6_.a = _loc5_;
               _loc6_.b = 0.5 * _loc5_;
               _loc6_.c = 0;
               _loc6_.d = _loc5_ * _loc4_;
               _loc6_.tx = 0;
               _loc6_.ty = 0;
               break;
            case 2:
               _loc6_.a = _loc5_;
               _loc6_.b = -0.5 * _loc5_;
               _loc6_.c = 0;
               _loc6_.d = _loc5_ * _loc4_;
               _loc6_.tx = 0;
               _loc6_.ty = 0.5 * _loc5_ * param1.width;
               break;
            default:
               _loc6_.a = _loc5_;
               _loc6_.b = 0;
               _loc6_.c = 0;
               _loc6_.d = _loc5_;
               _loc6_.tx = 0;
               _loc6_.ty = 0;
         }
         if(UnknownVarFromIsometricImageFurniVisualization_Boolean_1)
         {
            _loc3_ = new BitmapData(param2.width + 2,param2.height + 2,true,0);
            _loc8_ = new Bitmap(param1);
            _loc7_ = new ColorTransform();
            _loc7_.color = 0;
            _loc3_.draw(_loc8_,_loc6_,_loc7_);
            _loc6_.tx += 1;
            _loc6_.ty -= 1;
            _loc3_.draw(_loc8_,_loc6_,_loc7_);
            _loc6_.ty += 2;
            _loc3_.draw(_loc8_,_loc6_,_loc7_);
            _loc6_.tx += 1;
            _loc6_.ty -= 1;
            _loc3_.draw(_loc8_,_loc6_,_loc7_);
            _loc6_.tx -= 1;
            _loc3_.draw(_loc8_,_loc6_);
         }
         else
         {
            _loc3_ = new BitmapData(param2.width,param2.height,true,0);
            _loc3_.draw(param1,_loc6_);
         }
         return _loc3_;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         if(_thumbnailImageNormal == null || getSpriteTag(param1,direction,param2) != "THUMBNAIL")
         {
            return super.getSpriteAssetName(param1,param2);
         }
         return getThumbnailAssetName(param1);
      }
      
      protected function getThumbnailAssetName(param1:int) : String
      {
         if(_thumbnailAssetNameSmall == null)
         {
            _thumbnailAssetNameSmall = getFullThumbnailAssetName(object.getId(),32);
            _thumbnailAssetNameNormal = getFullThumbnailAssetName(object.getId(),64);
         }
         return param1 == 32 ? _thumbnailAssetNameSmall : _thumbnailAssetNameNormal;
      }
      
      protected function getFullThumbnailAssetName(param1:int, param2:int) : String
      {
         return [type,param1,"thumb",param2].join("_");
      }
   }
}

