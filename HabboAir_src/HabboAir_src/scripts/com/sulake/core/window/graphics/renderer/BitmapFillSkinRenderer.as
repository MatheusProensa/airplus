package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.BitmapFillController;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapFillSkinRenderer extends SkinRenderer
   {
      private static const UnknownConstFromBitmapFillSkinRenderer_Number_1:Number = 0.212671;
      
      private static const UnknownConstFromBitmapFillSkinRenderer_Number_2:Number = 0.71516;
      
      private static const B:Number = 0.072169;
      
      private static const SHAPE:Shape = new Shape();
      
      private static const MATRIX:Matrix = new Matrix();
      
      private static const COLOR_TRANSFORM:ColorTransform = new ColorTransform();
      
      private static const GREYSCALE_FILTER:ColorMatrixFilter = new ColorMatrixFilter();
      
      private static const ZERO_POINT:Point = new Point();
      
      private var UnknownVarFromBitmapFillSkinRenderer_BitmapData_1:BitmapData;
      
      private var UnknownVarFromBitmapFillSkinRenderer_BitmapData_2:BitmapData;
      
      private var UnknownVarFromBitmapFillSkinRenderer_Boolean_1:Boolean;
      
      private var _preparedTint:Boolean;
      
      private var _preparedColor:uint;
      
      private var UnknownVarFromBitmapFillSkinRenderer_BitmapData_3:BitmapData;
      
      private var UnknownVarFromBitmapFillSkinRenderer_BitmapData_4:BitmapData;
      
      private var UnknownVarFromBitmapFillSkinRenderer_Number_1:Number;
      
      private var UnknownVarFromBitmapFillSkinRenderer_Number_2:Number;
      
      private var UnknownVarFromBitmapFillSkinRenderer_Number_3:Number;
      
      public function BitmapFillSkinRenderer(param1:String)
      {
         super(param1);
      }
      
      public static function scaleForMode(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         if(param2 <= 0 || param3 <= 0 || param4 <= 0 || param5 <= 0)
         {
            return 1;
         }
         var _loc6_:Number = param4 / param2;
         var _loc7_:Number = param5 / param3;
         if(BitmapFillController.normalizeFillMode(param1) == "contain")
         {
            return Math.min(_loc6_,_loc7_);
         }
         return Math.max(_loc6_,_loc7_);
      }
      
      public static function tileStep(param1:Number, param2:Number, param3:Number) : Number
      {
         if(isNaN(param1) || param1 <= 0)
         {
            param1 = 1;
         }
         if(isNaN(param2) || param2 == 0)
         {
            param2 = 1;
         }
         return Math.max(1,param1 * Math.abs(param2) + BitmapFillController.normalizeSpacing(param3));
      }
      
      private static function drawStretch(param1:BitmapFillController, param2:BitmapData, param3:Rectangle, param4:BitmapData) : void
      {
         var _loc5_:Boolean = isFlippedX(param1);
         var _loc6_:Boolean = isFlippedY(param1);
         MATRIX.identity();
         MATRIX.a = param3.width / param4.width * (_loc5_ ? -1 : 1);
         MATRIX.d = param3.height / param4.height * (_loc6_ ? -1 : 1);
         MATRIX.tx = _loc5_ ? param3.right : param3.x;
         MATRIX.ty = _loc6_ ? param3.bottom : param3.y;
         param2.draw(param4,MATRIX,null,null,param3,false);
      }
      
      private static function drawFitted(param1:BitmapFillController, param2:BitmapData, param3:Rectangle, param4:BitmapData, param5:String) : void
      {
         var _loc8_:Number = normalizedZoom(param1.zoomX);
         var _loc7_:Number = normalizedZoom(param1.zoomY);
         var _loc6_:Number = scaleForMode(param5,param4.width * _loc8_,param4.height * _loc7_,param3.width,param3.height);
         drawScaled(param1,param2,param3,param4,scaleXForController(param1) * _loc6_,scaleYForController(param1) * _loc6_);
      }
      
      private static function drawScaled(param1:BitmapFillController, param2:BitmapData, param3:Rectangle, param4:BitmapData, param5:Number, param6:Number) : void
      {
         var _loc10_:Number = param4.width * Math.abs(param5);
         var _loc9_:Number = param4.height * Math.abs(param6);
         var _loc7_:Number = xForPivot(param3,_loc10_,param1.pivotPoint);
         var _loc8_:Number = yForPivot(param3,_loc9_,param1.pivotPoint);
         MATRIX.identity();
         MATRIX.a = param5;
         MATRIX.d = param6;
         MATRIX.tx = param5 < 0 ? _loc7_ + _loc10_ : _loc7_;
         MATRIX.ty = param6 < 0 ? _loc8_ + _loc9_ : _loc8_;
         param2.draw(param4,MATRIX,null,null,param3,false);
      }
      
      private static function scaleXForController(param1:BitmapFillController) : Number
      {
         return normalizedZoom(param1.zoomX) * (isFlippedX(param1) ? -1 : 1);
      }
      
      private static function scaleYForController(param1:BitmapFillController) : Number
      {
         return normalizedZoom(param1.zoomY) * (isFlippedY(param1) ? -1 : 1);
      }
      
      private static function normalizedZoom(param1:Number) : Number
      {
         return isNaN(param1) || param1 == 0 ? 1 : Math.abs(param1);
      }
      
      private static function isFlippedX(param1:BitmapFillController) : Boolean
      {
         return param1.zoomX < 0 != param1.flipX;
      }
      
      private static function isFlippedY(param1:BitmapFillController) : Boolean
      {
         return param1.zoomY < 0 != param1.flipY;
      }
      
      private static function xForPivot(param1:Rectangle, param2:Number, param3:uint) : Number
      {
         switch(int(param3) - 1)
         {
            case 0:
            case 3:
            case 6:
               return param1.x + (param1.width - param2) / 2;
            case 1:
            case 4:
            case 7:
               return param1.right - param2;
            default:
               return param1.x;
         }
      }
      
      private static function yForPivot(param1:Rectangle, param2:Number, param3:uint) : Number
      {
         switch(int(param3) - 3)
         {
            case 0:
            case 1:
            case 2:
               return param1.y + (param1.height - param2) / 2;
            case 3:
            case 4:
            case 5:
               return param1.bottom - param2;
            default:
               return param1.y;
         }
      }
      
      private static function colorTransformFor(param1:BitmapFillController) : ColorTransform
      {
         if(param1.tint)
         {
            COLOR_TRANSFORM.redMultiplier = ((param1.color & 0xFF0000) >> 16) / 255;
            COLOR_TRANSFORM.greenMultiplier = ((param1.color & 0xFF00) >> 8) / 255;
            COLOR_TRANSFORM.blueMultiplier = (param1.color & 0xFF) / 255;
         }
         else
         {
            COLOR_TRANSFORM.redMultiplier = 1;
            COLOR_TRANSFORM.greenMultiplier = 1;
            COLOR_TRANSFORM.blueMultiplier = 1;
         }
         COLOR_TRANSFORM.alphaMultiplier = 1;
         COLOR_TRANSFORM.redOffset = 0;
         COLOR_TRANSFORM.greenOffset = 0;
         COLOR_TRANSFORM.blueOffset = 0;
         COLOR_TRANSFORM.alphaOffset = 0;
         return COLOR_TRANSFORM;
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 != null)
         {
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.dispose();
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 = null;
         }
         disposeTileBitmap();
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_2 = null;
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_4 = null;
         super.dispose();
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc6_:BitmapFillController = param1 as BitmapFillController;
         if(_loc6_ == null || param2 == null || param3 == null || param3.width <= 0 || param3.height <= 0)
         {
            return;
         }
         param2.fillRect(param3,0);
         var _loc7_:BitmapData = _loc6_.bitmapData;
         if(_loc7_ == null || _loc7_.width <= 0 || _loc7_.height <= 0)
         {
            return;
         }
         _loc7_ = prepareBitmapData(_loc7_,_loc6_);
         switch(_loc6_.fillMode)
         {
            case "tile":
               drawTile(_loc6_,param2,param3,_loc7_);
               break;
            case "center":
               drawScaled(_loc6_,param2,param3,_loc7_,scaleXForController(_loc6_),scaleYForController(_loc6_));
               break;
            case "cover":
               drawFitted(_loc6_,param2,param3,_loc7_,"cover");
               break;
            case "contain":
               drawFitted(_loc6_,param2,param3,_loc7_,"contain");
               break;
            default:
               drawStretch(_loc6_,param2,param3,_loc7_);
         }
      }
      
      private function prepareBitmapData(param1:BitmapData, param2:BitmapFillController) : BitmapData
      {
         if(!param2.greyscale && !param2.tint)
         {
            if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 != null)
            {
               UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.dispose();
               UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 = null;
            }
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_2 = null;
            disposeTileBitmap();
            return param1;
         }
         var _loc3_:uint = uint(param2.tint ? param2.color : 0);
         if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 != null && UnknownVarFromBitmapFillSkinRenderer_BitmapData_2 == param1 && UnknownVarFromBitmapFillSkinRenderer_Boolean_1 == param2.greyscale && _preparedTint == param2.tint && _preparedColor == _loc3_)
         {
            return UnknownVarFromBitmapFillSkinRenderer_BitmapData_1;
         }
         if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 == null || UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.width != param1.width || UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.height != param1.height)
         {
            if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 != null)
            {
               UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.dispose();
            }
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_1 = new BitmapData(param1.width,param1.height,true,0);
         }
         else
         {
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.fillRect(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.rect,0);
         }
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.copyPixels(param1,param1.rect,ZERO_POINT,null,null,true);
         if(param2.greyscale)
         {
            GREYSCALE_FILTER.matrix = [0.212671,0.71516,0.072169,0,0,0.212671,0.71516,0.072169,0,0,0.212671,0.71516,0.072169,0,0,0,0,0,1,0];
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.applyFilter(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1,UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.rect,ZERO_POINT,GREYSCALE_FILTER);
         }
         if(param2.tint)
         {
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.colorTransform(UnknownVarFromBitmapFillSkinRenderer_BitmapData_1.rect,colorTransformFor(param2));
         }
         disposeTileBitmap();
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_2 = param1;
         UnknownVarFromBitmapFillSkinRenderer_Boolean_1 = param2.greyscale;
         _preparedTint = param2.tint;
         _preparedColor = _loc3_;
         return UnknownVarFromBitmapFillSkinRenderer_BitmapData_1;
      }
      
      private function disposeTileBitmap() : void
      {
         if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_3 != null)
         {
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_3.dispose();
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_3 = null;
         }
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_4 = null;
      }
      
      private function drawTile(param1:BitmapFillController, param2:BitmapData, param3:Rectangle, param4:BitmapData) : void
      {
         var _loc10_:Number = scaleXForController(param1);
         var _loc11_:Number = scaleYForController(param1);
         var _loc12_:Number = BitmapFillController.normalizeSpacing(param1.spacing);
         var _loc9_:* = param4;
         var _loc7_:Number = tileStep(param4.width,_loc10_,_loc12_);
         var _loc13_:Number = tileStep(param4.height,_loc11_,_loc12_);
         var _loc5_:Number = xForPivot(param3,_loc7_,param1.pivotPoint);
         var _loc6_:Number = yForPivot(param3,_loc13_,param1.pivotPoint);
         if(_loc12_ > 0)
         {
            _loc9_ = tileBitmapFor(param4,_loc10_,_loc11_,_loc12_);
            MATRIX.identity();
            MATRIX.tx = _loc5_;
            MATRIX.ty = _loc6_;
         }
         else
         {
            MATRIX.identity();
            MATRIX.a = _loc10_;
            MATRIX.d = _loc11_;
            MATRIX.tx = _loc10_ < 0 ? _loc5_ + _loc7_ : _loc5_;
            MATRIX.ty = _loc11_ < 0 ? _loc6_ + _loc13_ : _loc6_;
         }
         var _loc8_:Graphics = SHAPE.graphics;
         _loc8_.clear();
         _loc8_.beginBitmapFill(_loc9_,MATRIX,true,false);
         _loc8_.drawRect(param3.x,param3.y,param3.width,param3.height);
         _loc8_.endFill();
         param2.draw(SHAPE,null,null,null,param3,false);
         _loc8_.clear();
      }
      
      private function tileBitmapFor(param1:BitmapData, param2:Number, param3:Number, param4:Number) : BitmapData
      {
         var _loc5_:int = Math.ceil(tileStep(param1.width,param2,param4));
         var _loc6_:int = Math.ceil(tileStep(param1.height,param3,param4));
         if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_3 != null && UnknownVarFromBitmapFillSkinRenderer_BitmapData_4 == param1 && UnknownVarFromBitmapFillSkinRenderer_Number_1 == param2 && UnknownVarFromBitmapFillSkinRenderer_Number_2 == param3 && UnknownVarFromBitmapFillSkinRenderer_Number_3 == param4 && UnknownVarFromBitmapFillSkinRenderer_BitmapData_3.width == _loc5_ && UnknownVarFromBitmapFillSkinRenderer_BitmapData_3.height == _loc6_)
         {
            return UnknownVarFromBitmapFillSkinRenderer_BitmapData_3;
         }
         if(UnknownVarFromBitmapFillSkinRenderer_BitmapData_3 != null)
         {
            UnknownVarFromBitmapFillSkinRenderer_BitmapData_3.dispose();
         }
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_3 = new BitmapData(_loc5_,_loc6_,true,0);
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_4 = param1;
         UnknownVarFromBitmapFillSkinRenderer_Number_1 = param2;
         UnknownVarFromBitmapFillSkinRenderer_Number_2 = param3;
         UnknownVarFromBitmapFillSkinRenderer_Number_3 = param4;
         MATRIX.identity();
         MATRIX.a = param2;
         MATRIX.d = param3;
         MATRIX.tx = param2 < 0 ? param1.width * Math.abs(param2) : 0;
         MATRIX.ty = param3 < 0 ? param1.height * Math.abs(param3) : 0;
         UnknownVarFromBitmapFillSkinRenderer_BitmapData_3.draw(param1,MATRIX,null,null,null,false);
         return UnknownVarFromBitmapFillSkinRenderer_BitmapData_3;
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return true;
      }
   }
}

