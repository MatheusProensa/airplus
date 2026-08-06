package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class HabbiconBubble implements IGameClickTarget
   {
      private static const DEFAULT_VISIBLE_DURATION_MS:int = 3000;
      
      private static const INTRO_DURATION_MS:int = 180;
      
      private static const INTRO_START_OFFSET_Y:int = 12;
      
      private static const FADE_IN_DURATION_MS:int = 150;
      
      private static const FADE_OUT_DURATION_MS:int = 350;
      
      private static const BACKGROUND_VISIBLE_DURATION_MS:int = 3350;
      
      private static const BACKGROUND_FADE_OUT_DURATION_MS:int = 530;
      
      private static const ROOM_LARGE_OFFSET_X:int = -20;
      
      private static const ROOM_LARGE_OFFSET_Y:int = -126;
      
      private static const ROOM_SMALL_OFFSET_X:int = -10;
      
      private static const ROOM_SMALL_OFFSET_Y:int = -65;
      
      private static const DEFAULT_RELATIVE_DEPTH:Number = -0.2;
      
      private static const UnknownConstFromHabbiconBubble_Int_1:int = 2;
      
      private static const UnknownConstFromHabbiconBubble_Uint_1:uint = 4294967295;
      
      private static const BACKGROUND_SHADOW_PADDING:int = 5;
      
      private static const BACKGROUND_CONTENT_INSET:int = 7;
      
      private static const BACKGROUND_SHADOW_OFFSET_X:Number = 1.5;
      
      private static const BACKGROUND_SHADOW_OFFSET_Y:Number = 2;
      
      private static const BACKGROUND_SHADOW_BLUR:int = 6;
      
      private static const BACKGROUND_SHADOW_ALPHA:Number = 0.55;
      
      private static const BACKGROUND_SHADOW_QUALITY:int = 2;
      
      private static const BACKGROUND_SHADOW_COLOR:uint = 0;
      
      private static const UnknownConstFromHabbiconBubble_Object_1:Object = {};
      
      private static const UnknownConstFromHabbiconBubble_Object_2:Object = {};
      
      private static const BACKGROUND_SHADOW_BITMAP_CACHE:Object = {};
      
      private var _id:int = -1;
      
      private var UnknownVarFromHabbiconBubble_AvatarVisualization_1:AvatarVisualization;
      
      private var _habbiconId:int;
      
      private var UnknownVarFromHabbiconBubble_Number_1:Number;
      
      private var UnknownVarFromHabbiconBubble_Int_1:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Boolean_1:Boolean = false;
      
      private var UnknownVarFromHabbiconBubble_Int_2:int = 0;
      
      private var _bitmap:BitmapData;
      
      private var UnknownVarFromHabbiconBubble_Boolean_2:Boolean = false;
      
      private var UnknownVarFromHabbiconBubble_Boolean_3:Boolean = false;
      
      private var UnknownVarFromHabbiconBubble_Int_3:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Boolean_4:Boolean = false;
      
      private var UnknownVarFromHabbiconBubble_Boolean_5:Boolean = false;
      
      private var UnknownVarFromHabbiconBubble_Int_4:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Object_1:Object;
      
      private var UnknownVarFromHabbiconBubble_Int_5:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Int_6:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Int_7:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Int_8:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Int_9:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Int_10:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Int_11:int = -1;
      
      private var _lastComposedSourceAlpha:int = -1;
      
      private var _lastComposedBackgroundAlpha:int = -1;
      
      private var UnknownVarFromHabbiconBubble_Boolean_6:Boolean = false;
      
      private var UnknownVarFromHabbiconBubble_Boolean_7:Boolean = false;
      
      private var _triggerSequence:int = 0;
      
      private var UnknownVarFromHabbiconBubble_Boolean_8:Boolean = false;
      
      private var _relativeDepth:Number = -0.2;
      
      private var UnknownVarFromHabbiconBubble_Boolean_9:Boolean = false;
      
      private var UnknownVarFromHabbiconBubble_Boolean_10:Boolean = false;
      
      public function HabbiconBubble(param1:int, param2:int, param3:int, param4:AvatarVisualization)
      {
         super();
         _id = param1;
         _habbiconId = param2;
         _triggerSequence = param3;
         UnknownVarFromHabbiconBubble_AvatarVisualization_1 = param4;
      }
      
      private static function getOutlineBitmap(param1:BitmapData, param2:String) : BitmapData
      {
         var _loc3_:BitmapData = UnknownConstFromHabbiconBubble_Object_1[param2] as BitmapData;
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc3_ = createOutlineBitmap(param1);
         UnknownConstFromHabbiconBubble_Object_1[param2] = _loc3_;
         return _loc3_;
      }
      
      private static function getMirroredBitmap(param1:BitmapData, param2:String) : BitmapData
      {
         var _loc3_:BitmapData = UnknownConstFromHabbiconBubble_Object_2[param2] as BitmapData;
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc3_ = createMirroredBitmap(param1);
         UnknownConstFromHabbiconBubble_Object_2[param2] = _loc3_;
         return _loc3_;
      }
      
      private static function createMirroredBitmap(param1:BitmapData) : BitmapData
      {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         var _loc3_:Matrix = new Matrix();
         _loc3_.scale(-1,1);
         _loc3_.translate(param1.width,0);
         _loc2_.draw(param1,_loc3_,null,null,null,false);
         return _loc2_;
      }
      
      private static function createOutlineBitmap(param1:BitmapData) : BitmapData
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:BitmapData = new BitmapData(param1.width + 2 * 2,param1.height + 2 * 2,true,0);
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,4294967295);
         var _loc6_:Point = new Point();
         _loc3_.copyChannel(param1,param1.rect,_loc6_,8,8);
         _loc5_ = -2;
         while(_loc5_ <= 2)
         {
            _loc4_ = -2;
            while(_loc4_ <= 2)
            {
               if(!(_loc4_ == 0 && _loc5_ == 0))
               {
                  _loc6_.x = 2 + _loc4_;
                  _loc6_.y = 2 + _loc5_;
                  _loc2_.copyPixels(_loc3_,_loc3_.rect,_loc6_,null,null,true);
               }
               _loc4_++;
            }
            _loc5_++;
         }
         _loc3_.dispose();
         return _loc2_;
      }
      
      private static function getBackgroundShadowBitmap(param1:BitmapData, param2:String) : BitmapData
      {
         var _loc3_:BitmapData = BACKGROUND_SHADOW_BITMAP_CACHE[param2] as BitmapData;
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc3_ = createBackgroundShadowBitmap(param1);
         BACKGROUND_SHADOW_BITMAP_CACHE[param2] = _loc3_;
         return _loc3_;
      }
      
      private static function createBackgroundShadowBitmap(param1:BitmapData) : BitmapData
      {
         var _loc2_:BitmapData = new BitmapData(param1.width + 5 * 2,param1.height + 5 * 2,true,0);
         var _loc4_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc6_:BitmapData = new BitmapData(param1.width,param1.height,true,4278190080 | 0);
         var _loc5_:BlurFilter = new BlurFilter(6,6,2);
         var _loc3_:Point = new Point(5 + 1.5,5 + 2);
         _loc6_.copyChannel(param1,param1.rect,new Point(),8,8);
         _loc4_.copyPixels(_loc6_,_loc6_.rect,_loc3_,null,null,true);
         _loc4_.colorTransform(_loc4_.rect,new ColorTransform(1,1,1,0.55));
         _loc2_.applyFilter(_loc4_,_loc4_.rect,new Point(),_loc5_);
         _loc6_.dispose();
         _loc4_.dispose();
         return _loc2_;
      }
      
      private static function drawBitmapLayer(param1:BitmapData, param2:BitmapData, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:Matrix = null;
         if(param5 <= 0)
         {
            return;
         }
         if(param5 >= 255)
         {
            param1.copyPixels(param2,param2.rect,new Point(param3,param4),null,null,true);
            return;
         }
         _loc6_ = new Matrix();
         _loc6_.translate(param3,param4);
         param1.draw(param2,_loc6_,new ColorTransform(1,1,1,param5 / 255));
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get habbiconId() : int
      {
         return _habbiconId;
      }
      
      public function get triggerSequence() : int
      {
         return _triggerSequence;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromHabbiconBubble_AvatarVisualization_1 == null;
      }
      
      public function set relativeDepth(param1:Number) : void
      {
         _relativeDepth = param1;
      }
      
      public function dispose() : void
      {
         if(_bitmap != null && !UnknownVarFromHabbiconBubble_Boolean_2)
         {
            _bitmap.dispose();
         }
         _bitmap = null;
         UnknownVarFromHabbiconBubble_Boolean_2 = false;
         UnknownVarFromHabbiconBubble_Boolean_3 = false;
         UnknownVarFromHabbiconBubble_Int_3 = 0;
         UnknownVarFromHabbiconBubble_Boolean_4 = false;
         UnknownVarFromHabbiconBubble_Boolean_5 = false;
         UnknownVarFromHabbiconBubble_Int_4 = 0;
         UnknownVarFromHabbiconBubble_Int_8 = 0;
         UnknownVarFromHabbiconBubble_Int_9 = 0;
         UnknownVarFromHabbiconBubble_Int_10 = 0;
         _lastComposedSourceAlpha = -1;
         _lastComposedBackgroundAlpha = -1;
         UnknownVarFromHabbiconBubble_Boolean_7 = false;
         UnknownVarFromHabbiconBubble_Boolean_8 = false;
         UnknownVarFromHabbiconBubble_Boolean_9 = false;
         UnknownVarFromHabbiconBubble_Boolean_10 = false;
         UnknownVarFromHabbiconBubble_AvatarVisualization_1 = null;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 64;
         var _loc6_:* = !UnknownVarFromHabbiconBubble_Boolean_7;
         if(!param1)
         {
            return;
         }
         if(UnknownVarFromHabbiconBubble_Boolean_8 || UnknownVarFromHabbiconBubble_Int_7 > 0 && getTimer() >= UnknownVarFromHabbiconBubble_Int_7)
         {
            UnknownVarFromHabbiconBubble_Boolean_8 = true;
            param1.alpha = 0;
            param1.visible = false;
            return;
         }
         UnknownVarFromHabbiconBubble_Number_1 = param2;
         if(_loc6_)
         {
            UnknownVarFromHabbiconBubble_Object_1 = HabbiconAssetManager.getRuntimeAsset(_habbiconId);
            UnknownVarFromHabbiconBubble_Boolean_6 = UnknownVarFromHabbiconBubble_Object_1 != null && Boolean(UnknownVarFromHabbiconBubble_Object_1.animated);
            UnknownVarFromHabbiconBubble_Int_5 = getTimer();
            UnknownVarFromHabbiconBubble_Int_11 = resolveFrameIndex(0);
            configureTiming();
            applyFrame(resolveBitmap(param2,resolveAlpha(UnknownVarFromHabbiconBubble_Int_5),resolveBackgroundAlpha(UnknownVarFromHabbiconBubble_Int_5)));
            UnknownVarFromHabbiconBubble_Boolean_7 = true;
         }
         _loc4_ = getTimer() - UnknownVarFromHabbiconBubble_Int_5;
         if(param2 < 48)
         {
            _loc3_ = -10;
            _loc5_ = -65;
            _loc7_ = 32;
         }
         else
         {
            _loc3_ = -20;
            _loc5_ = -126;
         }
         if(UnknownVarFromHabbiconBubble_AvatarVisualization_1.posture == "sit")
         {
            _loc5_ += _loc7_ / 2;
         }
         else if(UnknownVarFromHabbiconBubble_AvatarVisualization_1.posture == "lay")
         {
            _loc5_ += _loc7_;
         }
         _loc8_ = getIntroOffsetY(_loc4_);
         param1.asset = _bitmap;
         param1.offsetX = _loc3_ + resolveFrameAnchorCompensationX();
         param1.offsetY = _loc5_ + _loc8_ + resolveFrameAnchorCompensationY();
         param1.relativeDepth = _relativeDepth;
         if(_loc6_)
         {
            param1.visible = true;
            param1.alpha = 255;
            UnknownVarFromHabbiconBubble_Int_1 = 0;
            UnknownVarFromHabbiconBubble_Boolean_1 = false;
            UnknownVarFromHabbiconBubble_Int_2 = 0;
         }
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Boolean = false;
         var _loc6_:int = 64;
         var _loc4_:Boolean = false;
         if(!param1)
         {
            return false;
         }
         _loc8_ = getTimer();
         _loc2_ = _loc8_ - UnknownVarFromHabbiconBubble_Int_5;
         UnknownVarFromHabbiconBubble_Object_1 = HabbiconAssetManager.getRuntimeAsset(_habbiconId);
         if(UnknownVarFromHabbiconBubble_Object_1 != null && Boolean(UnknownVarFromHabbiconBubble_Object_1.animated) != UnknownVarFromHabbiconBubble_Boolean_6)
         {
            UnknownVarFromHabbiconBubble_Boolean_6 = Boolean(UnknownVarFromHabbiconBubble_Object_1.animated);
            configureTiming();
         }
         _loc5_ = resolveFrameIndex(_loc2_);
         if(UnknownVarFromHabbiconBubble_Object_1 != null && _loc5_ != UnknownVarFromHabbiconBubble_Int_11)
         {
            UnknownVarFromHabbiconBubble_Int_11 = _loc5_;
            _loc4_ = true;
         }
         _loc10_ = resolveAlpha(_loc8_);
         _loc11_ = resolveBackgroundAlpha(_loc8_);
         if(_loc10_ != _lastComposedSourceAlpha || _loc11_ != _lastComposedBackgroundAlpha)
         {
            _loc4_ = true;
         }
         if(_loc4_)
         {
            applyFrame(resolveBitmap(UnknownVarFromHabbiconBubble_Number_1,_loc10_,_loc11_));
            _loc12_ = true;
         }
         if(_bitmap != null)
         {
            param1.asset = _bitmap;
         }
         param1.relativeDepth = _relativeDepth;
         _loc7_ = UnknownVarFromHabbiconBubble_Number_1 < 48 ? -65 : -126;
         if(UnknownVarFromHabbiconBubble_AvatarVisualization_1.posture == "sit")
         {
            _loc7_ += _loc6_ / 2;
         }
         else if(UnknownVarFromHabbiconBubble_AvatarVisualization_1.posture == "lay")
         {
            _loc7_ += _loc6_;
         }
         _loc9_ = getIntroOffsetY(_loc2_);
         param1.offsetY = _loc7_ + _loc9_ + resolveFrameAnchorCompensationY();
         param1.offsetX = (UnknownVarFromHabbiconBubble_Number_1 < 48 ? -10 : -20) + resolveFrameAnchorCompensationX();
         if(_loc8_ >= UnknownVarFromHabbiconBubble_Int_7)
         {
            UnknownVarFromHabbiconBubble_Boolean_8 = true;
            param1.alpha = 0;
            param1.visible = false;
            return true;
         }
         _loc3_ = Math.max(_loc10_,_loc11_);
         if(param1.alpha != 255)
         {
            param1.alpha = 255;
            _loc12_ = true;
         }
         param1.visible = _loc3_ > 0;
         return true;
      }
      
      private function resolveBitmap(param1:Number, param2:int = -1, param3:int = -1) : BitmapData
      {
         var _loc5_:BitmapData = null;
         var _loc8_:Array = null;
         var _loc9_:String = null;
         var _loc7_:BitmapData = null;
         var _loc6_:int = param1 < 48 ? 20 : 40;
         var _loc4_:* = param1 < 48;
         if(param2 < 0)
         {
            param2 = resolveAlpha(getTimer());
         }
         if(param3 < 0)
         {
            param3 = resolveBackgroundAlpha(getTimer());
         }
         UnknownVarFromHabbiconBubble_Boolean_4 = false;
         UnknownVarFromHabbiconBubble_Boolean_5 = false;
         UnknownVarFromHabbiconBubble_Int_4 = _loc6_;
         if(UnknownVarFromHabbiconBubble_Object_1 != null && UnknownVarFromHabbiconBubble_Object_1.frames is Array && UnknownVarFromHabbiconBubble_Object_1.frames.length > 0)
         {
            _loc8_ = UnknownVarFromHabbiconBubble_Object_1.frames as Array;
            if(UnknownVarFromHabbiconBubble_Int_11 < 0 || UnknownVarFromHabbiconBubble_Int_11 >= _loc8_.length)
            {
               UnknownVarFromHabbiconBubble_Int_11 = 0;
            }
            _loc5_ = _loc4_ ? _loc8_[UnknownVarFromHabbiconBubble_Int_11].smallBitmap as BitmapData : _loc8_[UnknownVarFromHabbiconBubble_Int_11].bitmap as BitmapData;
         }
         else
         {
            _loc5_ = HabbiconAssetManager.getPreviewBitmap(_habbiconId,_loc4_);
         }
         if(_loc5_ != null)
         {
            UnknownVarFromHabbiconBubble_Boolean_4 = false;
            UnknownVarFromHabbiconBubble_Boolean_5 = true;
            UnknownVarFromHabbiconBubble_Int_4 = _loc5_.width + 2 * 2 + 5 * 2;
            _lastComposedSourceAlpha = param2;
            _lastComposedBackgroundAlpha = param3;
            _loc9_ = createOutlineBitmapCacheKey(_loc4_);
            if(shouldMirrorHabbicon())
            {
               _loc9_ += ":mirrored";
               _loc5_ = getMirroredBitmap(_loc5_,_loc9_);
            }
            _loc7_ = getOutlineBitmap(_loc5_,_loc9_);
            return composeBitmap(_loc5_,_loc7_,getBackgroundShadowBitmap(_loc7_,_loc9_),_bitmap,param2,param3);
         }
         if(_bitmap != null && !UnknownVarFromHabbiconBubble_Boolean_2 && UnknownVarFromHabbiconBubble_Int_3 == _loc6_)
         {
            return _bitmap;
         }
         return createBitmap(_loc6_,seededColor(_habbiconId * 37));
      }
      
      private function applyFrame(param1:BitmapData) : void
      {
         setBitmap(param1,UnknownVarFromHabbiconBubble_Boolean_4,UnknownVarFromHabbiconBubble_Int_4,UnknownVarFromHabbiconBubble_Boolean_5);
      }
      
      private function setBitmap(param1:BitmapData, param2:Boolean, param3:int, param4:Boolean) : void
      {
         if(_bitmap === param1)
         {
            UnknownVarFromHabbiconBubble_Boolean_2 = param2;
            UnknownVarFromHabbiconBubble_Int_3 = param3;
            UnknownVarFromHabbiconBubble_Boolean_3 = param4;
            return;
         }
         if(_bitmap != null && !UnknownVarFromHabbiconBubble_Boolean_2)
         {
            _bitmap.dispose();
         }
         _bitmap = param1;
         UnknownVarFromHabbiconBubble_Boolean_2 = param2;
         UnknownVarFromHabbiconBubble_Int_3 = param3;
         UnknownVarFromHabbiconBubble_Boolean_3 = param4;
      }
      
      private function configureTiming() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = Math.max(3000,150 + 350);
         var _loc1_:int = Math.max(3350,150 + 530);
         var _loc6_:int = int(UnknownVarFromHabbiconBubble_Object_1 != null ? int(UnknownVarFromHabbiconBubble_Object_1.playbackDurationMs) : 0);
         var _loc5_:Boolean = UnknownVarFromHabbiconBubble_Object_1 != null && Boolean(UnknownVarFromHabbiconBubble_Object_1.animated) && UnknownVarFromHabbiconBubble_Object_1.frames is Array && UnknownVarFromHabbiconBubble_Object_1.frames.length > 1 && UnknownVarFromHabbiconBubble_Object_1.steps is Array && UnknownVarFromHabbiconBubble_Object_1.steps.length > 0;
         var _loc7_:Boolean = false;
         _loc3_ = UnknownVarFromHabbiconBubble_Int_5 + (_loc7_ ? _loc6_ : _loc2_);
         _loc4_ = int(_loc7_ ? _loc3_ : _loc3_ - 350);
         UnknownVarFromHabbiconBubble_Int_8 = _loc3_;
         UnknownVarFromHabbiconBubble_Int_10 = _loc7_ ? _loc4_ + 530 : UnknownVarFromHabbiconBubble_Int_5 + _loc1_;
         UnknownVarFromHabbiconBubble_Int_9 = _loc7_ ? _loc4_ : UnknownVarFromHabbiconBubble_Int_10 - 530;
         UnknownVarFromHabbiconBubble_Int_7 = Math.max(_loc3_,UnknownVarFromHabbiconBubble_Int_10);
         UnknownVarFromHabbiconBubble_Int_6 = _loc4_;
      }
      
      private function resolveFrameIndex(param1:int) : int
      {
         var _loc2_:Object = getCurrentStep(param1);
         if(UnknownVarFromHabbiconBubble_Object_1 == null || UnknownVarFromHabbiconBubble_Object_1.frames == null || UnknownVarFromHabbiconBubble_Object_1.frames.length == 0)
         {
            return 0;
         }
         if(_loc2_ == null)
         {
            return 0;
         }
         return Math.max(0,Math.min(int(_loc2_.sourceFrame),UnknownVarFromHabbiconBubble_Object_1.frames.length - 1));
      }
      
      private function getCurrentStep(param1:int) : Object
      {
         var _loc6_:Array = null;
         var _loc3_:* = 0;
         var _loc5_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(UnknownVarFromHabbiconBubble_Object_1 == null || !(UnknownVarFromHabbiconBubble_Object_1.steps is Array) || UnknownVarFromHabbiconBubble_Object_1.steps.length == 0)
         {
            return null;
         }
         _loc6_ = UnknownVarFromHabbiconBubble_Object_1.steps as Array;
         if(_loc6_.length == 1)
         {
            return _loc6_[0];
         }
         for each(_loc5_ in _loc6_)
         {
            _loc2_ += Math.max(1,int(_loc5_.durationMs));
         }
         if(_loc2_ <= 0)
         {
            return _loc6_[0];
         }
         _loc3_ = param1;
         if(UnknownVarFromHabbiconBubble_Object_1.animated)
         {
            _loc3_ %= _loc2_;
         }
         else if(_loc3_ >= _loc2_)
         {
            return _loc6_[_loc6_.length - 1];
         }
         _loc2_ = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc5_ = _loc6_[_loc4_];
            _loc2_ += Math.max(1,int(_loc5_.durationMs));
            if(_loc3_ < _loc2_)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return _loc6_[_loc6_.length - 1];
      }
      
      private function getIntroOffsetY(param1:int) : int
      {
         var _loc2_:Number = Math.min(1,Math.max(0,param1 / 180));
         return int(Math.round((1 - _loc2_) * 12));
      }
      
      private function resolveAlpha(param1:int) : int
      {
         var _loc3_:Number = Math.min(1,Math.max(0,(param1 - UnknownVarFromHabbiconBubble_Int_5) / 150));
         var _loc2_:Number = param1 < UnknownVarFromHabbiconBubble_Int_6 ? 1 : 1 - Math.min(1,Math.max(0,(param1 - UnknownVarFromHabbiconBubble_Int_6) / 350));
         if(UnknownVarFromHabbiconBubble_Int_8 > 0 && param1 >= UnknownVarFromHabbiconBubble_Int_8)
         {
            return 0;
         }
         return int(Math.round(255 * Math.min(_loc3_,_loc2_)));
      }
      
      private function resolveBackgroundAlpha(param1:int) : int
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = Math.min(1,Math.max(0,(param1 - UnknownVarFromHabbiconBubble_Int_5) / 150));
         _loc2_ = param1 < UnknownVarFromHabbiconBubble_Int_9 ? 1 : 1 - Math.min(1,Math.max(0,(param1 - UnknownVarFromHabbiconBubble_Int_9) / 530));
         return int(Math.round(255 * Math.min(_loc3_,_loc2_)));
      }
      
      private function resolveFrameAnchorCompensationX() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_bitmap == null)
         {
            return 0;
         }
         if(UnknownVarFromHabbiconBubble_Object_1 == null)
         {
            return UnknownVarFromHabbiconBubble_Boolean_3 ? -7 : 0;
         }
         _loc1_ = resolveBaseDimension("baseWidth");
         _loc2_ = _bitmap.width;
         return int(Math.round((_loc1_ - _loc2_) * 0.5));
      }
      
      private function resolveFrameAnchorCompensationY() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_bitmap == null)
         {
            return 0;
         }
         if(UnknownVarFromHabbiconBubble_Object_1 == null)
         {
            return UnknownVarFromHabbiconBubble_Boolean_3 ? -7 : 0;
         }
         _loc2_ = resolveBaseDimension("baseHeight");
         _loc1_ = _bitmap.height;
         return _loc2_ - _loc1_ + (UnknownVarFromHabbiconBubble_Boolean_3 ? 7 : 0);
      }
      
      private function resolveBaseDimension(param1:String) : int
      {
         var _loc2_:int = int(UnknownVarFromHabbiconBubble_Object_1[param1]);
         if(UnknownVarFromHabbiconBubble_Number_1 < 48)
         {
            return Math.max(1,int(Math.round(_loc2_ * 0.5)));
         }
         return Math.max(1,_loc2_);
      }
      
      private function createBitmap(param1:int, param2:uint) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(param1,param1,true,0);
         var _loc4_:int = Math.max(2,param1 / 8);
         var _loc5_:int = Math.max(1,param1 / 4);
         _loc3_.fillRect(_loc3_.rect,0);
         _loc3_.fillRect(new Rectangle(_loc4_,_loc4_,param1 - _loc4_ * 2,param1 - _loc4_ * 2),4278190080 | param2);
         _loc3_.fillRect(new Rectangle(_loc5_,_loc5_,param1 - _loc5_ * 2,param1 - _loc5_ * 2),4294967295);
         return _loc3_;
      }
      
      private function createOutlineBitmapCacheKey(param1:Boolean) : String
      {
         var _loc2_:Boolean = UnknownVarFromHabbiconBubble_Object_1 != null && UnknownVarFromHabbiconBubble_Object_1.frames is Array && UnknownVarFromHabbiconBubble_Object_1.frames.length > 0;
         var _loc3_:String = _loc2_ ? (!!UnknownVarFromHabbiconBubble_Object_1.animated ? "animated" : "runtime") : "preview";
         return _habbiconId + ":" + _loc3_ + ":" + (param1 ? "small" : "large") + ":" + UnknownVarFromHabbiconBubble_Int_11;
      }
      
      private function shouldMirrorHabbicon() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(!UnknownVarFromHabbiconBubble_Boolean_9)
         {
            _loc2_ = int(UnknownVarFromHabbiconBubble_AvatarVisualization_1 != null ? UnknownVarFromHabbiconBubble_AvatarVisualization_1.habbiconFacingDirection : 0);
            _loc1_ = HabbiconAssetManager.getDirection(_habbiconId);
            UnknownVarFromHabbiconBubble_Boolean_10 = _loc2_ != 0 && _loc1_ != 0 && _loc2_ != _loc1_;
            UnknownVarFromHabbiconBubble_Boolean_9 = true;
         }
         return UnknownVarFromHabbiconBubble_Boolean_10;
      }
      
      private function composeBitmap(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:BitmapData, param5:int, param6:int) : BitmapData
      {
         var _loc7_:* = null;
         if(param4 != null && !UnknownVarFromHabbiconBubble_Boolean_2 && param4.width == param3.width && param4.height == param3.height)
         {
            _loc7_ = param4;
            _loc7_.fillRect(_loc7_.rect,0);
         }
         else
         {
            _loc7_ = new BitmapData(param3.width,param3.height,true,0);
         }
         drawBitmapLayer(_loc7_,param3,0,0,param6);
         drawBitmapLayer(_loc7_,param2,5,5,param6);
         drawBitmapLayer(_loc7_,param1,7,7,param5);
         return _loc7_;
      }
      
      private function seededColor(param1:int) : uint
      {
         switch(param1 % 6)
         {
            case 0:
               return 16371247;
            case 1:
               return 15964719;
            case 2:
               return 15695663;
            case 3:
               return 9358143;
            case 4:
               return 5095656;
            default:
               return 12813557;
         }
      }
   }
}

