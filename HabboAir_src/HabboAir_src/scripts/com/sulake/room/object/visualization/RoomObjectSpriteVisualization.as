package com.sulake.room.object.visualization
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class RoomObjectSpriteVisualization implements IRoomObjectSpriteVisualization
   {
      protected static const UnknownConstFromRoomObjectSpriteVisualization_String_1:String = "_";
      
      protected static const ICON_LAYER_ID:String = "_icon_";
      
      private static var UnknownVarFromRoomObjectSpriteVisualization_Int_1:int = 0;
      
      private var _sprites:Array;
      
      private var _object:IRoomObject;
      
      private var _assetCollection:IGraphicAssetCollection;
      
      protected var UnknownVarFromRoomObjectSpriteVisualization_Int_2:int = -1;
      
      protected var UnknownVarFromRoomObjectSpriteVisualization_Int_3:int = -1;
      
      protected var UnknownVarFromRoomObjectSpriteVisualization_Int_4:int = -1;
      
      private var UnknownVarFromRoomObjectSpriteVisualization_Int_5:int = 0;
      
      private var UnknownVarFromRoomObjectSpriteVisualization_Int_6:int = 0;
      
      public function RoomObjectSpriteVisualization()
      {
         super();
         UnknownVarFromRoomObjectSpriteVisualization_Int_5 = UnknownVarFromRoomObjectSpriteVisualization_Int_1++;
         _sprites = [];
         _object = null;
         _assetCollection = null;
      }
      
      public function dispose() : void
      {
         if(_sprites != null)
         {
            for each(var _loc1_ in _sprites)
            {
               _loc1_.dispose();
            }
            _sprites = null;
         }
         _object = null;
         assetCollection = null;
      }
      
      public function set assetCollection(param1:IGraphicAssetCollection) : void
      {
         if(_assetCollection != null)
         {
            _assetCollection.removeReference();
         }
         _assetCollection = param1;
         if(_assetCollection != null)
         {
            _assetCollection.addReference();
         }
      }
      
      public function setExternalBaseUrls(param1:String, param2:String, param3:Boolean) : void
      {
      }
      
      public function get assetCollection() : IGraphicAssetCollection
      {
         return _assetCollection;
      }
      
      public function getUpdateID() : int
      {
         return UnknownVarFromRoomObjectSpriteVisualization_Int_6;
      }
      
      public function getInstanceId() : int
      {
         return UnknownVarFromRoomObjectSpriteVisualization_Int_5;
      }
      
      protected function createSprites(param1:int) : void
      {
         var _loc2_:RoomObjectSprite = null;
         while(_sprites.length > param1)
         {
            _loc2_ = _sprites[_sprites.length - 1] as RoomObjectSprite;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            _sprites.pop();
         }
         while(_sprites.length < param1)
         {
            _loc2_ = new RoomObjectSprite();
            _sprites.push(_loc2_);
         }
      }
      
      protected function clearSprites() : void
      {
         if(_sprites.length > 0)
         {
            for each(var _loc1_ in _sprites)
            {
               _loc1_.dispose();
            }
            _sprites = [];
         }
      }
      
      public function addSprite() : IRoomObjectSprite
      {
         return addSpriteAt(_sprites.length);
      }
      
      public function addSpriteAt(param1:int) : IRoomObjectSprite
      {
         var _loc2_:IRoomObjectSprite = new RoomObjectSprite();
         if(param1 >= _sprites.length)
         {
            _sprites.push(_loc2_);
         }
         else
         {
            _sprites.splice(param1,0,_loc2_);
         }
         return _loc2_;
      }
      
      public function removeSprite(param1:IRoomObjectSprite) : void
      {
         var _loc2_:int = int(_sprites.indexOf(param1));
         if(_loc2_ == -1)
         {
            throw new Error("Trying to remove non-existing sprite!");
         }
         _sprites.splice(_loc2_,1);
         RoomObjectSprite(param1).dispose();
      }
      
      public function get spriteCount() : int
      {
         return _sprites.length;
      }
      
      public function getSprite(param1:int) : IRoomObjectSprite
      {
         if(param1 >= 0 && param1 < _sprites.length)
         {
            return _sprites[param1];
         }
         return null;
      }
      
      public function get object() : IRoomObject
      {
         return _object;
      }
      
      public function set object(param1:IRoomObject) : void
      {
         _object = param1;
      }
      
      public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
      }
      
      protected function increaseUpdateId() : void
      {
         UnknownVarFromRoomObjectSpriteVisualization_Int_6++;
      }
      
      protected function reset() : void
      {
         UnknownVarFromRoomObjectSpriteVisualization_Int_2 = 4294967295;
         UnknownVarFromRoomObjectSpriteVisualization_Int_3 = 4294967295;
         UnknownVarFromRoomObjectSpriteVisualization_Int_4 = -1;
      }
      
      public function getSpriteList() : Array
      {
         return null;
      }
      
      public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         return false;
      }
      
      public function get image() : BitmapData
      {
         return getImage(0,-1);
      }
      
      private function normalizeColourComponent(param1:int) : Number
      {
         return Math.max(0,Math.min(255,param1)) / 255;
      }
      
      public function getImage(param1:int, param2:int) : BitmapData
      {
         var _loc16_:Number = NaN;
         var _loc6_:int = 0;
         var _loc15_:* = 0;
         var _loc9_:* = 0;
         var _loc4_:* = 0;
         var _loc7_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc8_:Rectangle = boundingRectangle;
         if(_loc8_.width * _loc8_.height == 0)
         {
            return null;
         }
         var _loc10_:int = spriteCount;
         var _loc3_:IRoomObjectSprite = null;
         var _loc12_:Array = [];
         var _loc11_:int = 0;
         var _loc5_:BitmapData = null;
         _loc11_ = 0;
         while(_loc11_ < _loc10_)
         {
            _loc3_ = getSprite(_loc11_);
            if(_loc3_ != null && _loc3_.visible)
            {
               _loc5_ = _loc3_.asset;
               if(_loc5_ != null)
               {
                  _loc12_.push(_loc3_);
               }
            }
            _loc11_++;
         }
         if(_loc12_.length > 1)
         {
            _loc12_.sortOn("relativeDepth",16);
            _loc12_.reverse();
         }
         var _loc18_:BitmapData = null;
         try
         {
            _loc18_ = new BitmapData(_loc8_.width,_loc8_.height,true,param1);
         }
         catch(e:ArgumentError)
         {
            Logger.log("Unable to create BitmapData object! " + e);
         }
         if(!_loc18_)
         {
            return new BitmapData(1,1,true);
         }
         var _loc13_:Matrix = new Matrix();
         var _loc20_:ColorTransform = new ColorTransform();
         var _loc19_:* = null;
         _loc11_ = 0;
         while(_loc11_ < _loc12_.length)
         {
            _loc3_ = _loc12_[_loc11_] as IRoomObjectSprite;
            _loc5_ = _loc3_.asset;
            if(_loc5_ != null)
            {
               try
               {
                  _loc6_ = _loc3_.color;
                  _loc15_ = _loc6_ >> 16;
                  _loc9_ = _loc6_ >> 8 & 0xFF;
                  _loc4_ = _loc6_ & 0xFF;
                  _loc19_ = null;
                  if(_loc15_ < 255 || _loc9_ < 255 || _loc4_ < 255)
                  {
                     _loc7_ = normalizeColourComponent(_loc15_);
                     _loc14_ = normalizeColourComponent(_loc9_);
                     _loc17_ = normalizeColourComponent(_loc4_);
                     _loc16_ = normalizeColourComponent(_loc3_.alpha);
                     _loc20_.redMultiplier = _loc7_;
                     _loc20_.greenMultiplier = _loc14_;
                     _loc20_.blueMultiplier = _loc17_;
                     _loc20_.alphaMultiplier = _loc16_;
                     _loc19_ = _loc20_;
                  }
                  else if(_loc3_.alpha < 255)
                  {
                     _loc16_ = normalizeColourComponent(_loc3_.alpha);
                     _loc20_.redMultiplier = 1;
                     _loc20_.greenMultiplier = 1;
                     _loc20_.blueMultiplier = 1;
                     _loc20_.alphaMultiplier = _loc16_;
                     _loc19_ = _loc20_;
                  }
                  if(param1 == 0 && _loc3_.blendMode == "add")
                  {
                     _loc5_ = extractDarknessToAlpha(_loc5_);
                  }
                  _loc13_.identity();
                  if(_loc3_.flipH)
                  {
                     _loc13_.scale(-1,1);
                     _loc13_.translate(_loc3_.width,0);
                  }
                  if(_loc3_.flipV)
                  {
                     _loc13_.scale(1,-1);
                     _loc13_.translate(0,_loc3_.height);
                  }
                  _loc13_.translate(_loc3_.offsetX - _loc8_.left,_loc3_.offsetY - _loc8_.top);
                  _loc18_.draw(_loc5_,_loc13_,_loc19_,_loc3_.blendMode,null,false);
               }
               catch(e:Error)
               {
               }
            }
            _loc11_++;
         }
         return _loc18_;
      }
      
      public function get boundingRectangle() : Rectangle
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = spriteCount;
         var _loc1_:IRoomObjectSprite = null;
         var _loc5_:Rectangle = new Rectangle();
         var _loc2_:BitmapData = null;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc1_ = getSprite(_loc7_);
            if(_loc1_ != null && _loc1_.visible)
            {
               _loc2_ = _loc1_.asset;
               if(_loc2_ != null)
               {
                  _loc4_ = _loc1_.offsetX;
                  _loc3_ = _loc1_.offsetY;
                  if(_loc7_ == 0)
                  {
                     _loc5_.left = _loc4_;
                     _loc5_.top = _loc3_;
                     _loc5_.right = _loc4_ + _loc1_.width;
                     _loc5_.bottom = _loc3_ + _loc1_.height;
                  }
                  else
                  {
                     if(_loc4_ < _loc5_.left)
                     {
                        _loc5_.left = _loc4_;
                     }
                     if(_loc3_ < _loc5_.top)
                     {
                        _loc5_.top = _loc3_;
                     }
                     if(_loc4_ + _loc1_.width > _loc5_.right)
                     {
                        _loc5_.right = _loc4_ + _loc1_.width;
                     }
                     if(_loc3_ + _loc1_.height > _loc5_.bottom)
                     {
                        _loc5_.bottom = _loc3_ + _loc1_.height;
                     }
                  }
               }
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      private function extractDarknessToAlpha(param1:BitmapData) : BitmapData
      {
         var _loc14_:BitmapData = null;
         var _loc12_:* = undefined;
         var _loc8_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc11_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc9_:* = 0;
         var _loc2_:int = 0;
         var _loc10_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc13_:Number = NaN;
         try
         {
            _loc14_ = new BitmapData(param1.width,param1.height,true);
            _loc12_ = param1.getVector(param1.rect);
            _loc8_ = 0;
            while(_loc8_ < _loc12_.length)
            {
               _loc3_ = _loc12_[_loc8_];
               _loc4_ = uint(_loc3_ >> 24 & 0xFF);
               _loc11_ = uint(_loc3_ >> 16 & 0xFF);
               _loc6_ = uint(_loc3_ >> 8 & 0xFF);
               _loc5_ = uint(_loc3_ & 0xFF);
               _loc9_ = _loc11_ << 16 | _loc6_ << 8 | _loc5_;
               _loc2_ = int(ColorConverter.rgbToHSL(_loc9_));
               _loc10_ = _loc2_ & 0xFF;
               if(_loc10_ <= 128)
               {
                  _loc7_ = _loc2_ >> 16 & 0xFF;
                  _loc13_ = _loc2_ >> 8 & 0xFF;
                  _loc4_ *= _loc10_ / 128;
                  _loc10_ = 128;
                  _loc2_ = (_loc7_ << 16) + (_loc13_ << 8) + _loc10_;
                  _loc9_ = int(ColorConverter.hslToRGB(_loc2_));
                  _loc3_ = uint(_loc4_ << 24 | _loc9_);
               }
               _loc12_[_loc8_] = _loc3_;
               _loc8_++;
            }
            _loc14_.setVector(_loc14_.rect,_loc12_);
            return _loc14_;
         }
         catch(e:Error)
         {
            var _loc17_:* = new BitmapData(1,1,true);
         }
         return _loc17_;
      }
   }
}

