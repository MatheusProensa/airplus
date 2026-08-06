package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ShapeController;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Rectangle;
   
   public class ShapeSkinRenderer extends SkinRenderer
   {
      private static const SHAPE:Shape = new Shape();
      
      public function ShapeSkinRenderer(param1:String)
      {
         super(param1);
      }
      
      public static function alphaFromColor(param1:uint) : Number
      {
         var _loc2_:uint = uint(param1 >>> 24 & 0xFF);
         return _loc2_ == 0 ? 1 : _loc2_ / 255;
      }
      
      private static function cornerRadius(param1:Number, param2:Number, param3:Number) : int
      {
         if(isNaN(param1) || isNaN(param2) || isNaN(param3) || param1 <= 0 || param2 <= 0 || param3 <= 0)
         {
            return 0;
         }
         return int(Math.min(Math.round(param1),Math.floor(param2 / 2),Math.floor(param3 / 2)));
      }
      
      private static function snap(param1:Number) : int
      {
         return isNaN(param1) ? 0 : int(Math.round(param1));
      }
      
      private static function snappedThickness(param1:Number) : int
      {
         return isNaN(param1) || param1 <= 0 ? 0 : int(Math.max(1,Math.round(param1)));
      }
      
      private static function roundRectContainsPixel(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : Boolean
      {
         var _loc12_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc10_:Number = param7;
         var _loc8_:Number = param1 + 0.5;
         var _loc9_:Number = param2 + 0.5;
         if(_loc8_ < param3 || _loc9_ < param4 || _loc8_ >= param5 || _loc9_ >= param6)
         {
            return false;
         }
         if(_loc10_ <= 0)
         {
            return true;
         }
         _loc12_ = _loc8_ < param3 + _loc10_ ? param3 + _loc10_ : (_loc8_ >= param5 - _loc10_ ? param5 - _loc10_ : _loc8_);
         _loc11_ = _loc9_ < param4 + _loc10_ ? param4 + _loc10_ : (_loc9_ >= param6 - _loc10_ ? param6 - _loc10_ : _loc9_);
         _loc13_ = _loc8_ - _loc12_;
         _loc14_ = _loc9_ - _loc11_;
         return _loc13_ * _loc13_ + _loc14_ * _loc14_ <= _loc10_ * _loc10_;
      }
      
      private static function argbFromColor(param1:uint) : uint
      {
         var _loc2_:uint = uint(param1 >>> 24 & 0xFF);
         return (_loc2_ == 0 ? 255 : _loc2_) << 24 | param1 & 0xFFFFFF;
      }
      
      private static function blendPixel(param1:BitmapData, param2:int, param3:int, param4:uint, param5:Number) : void
      {
         if(param5 <= 0)
         {
            return;
         }
         if(param5 > 1)
         {
            param5 = 1;
         }
         var _loc6_:uint = uint(param4 >>> 24 & 0xFF);
         var _loc8_:Number = (_loc6_ == 0 ? 255 : _loc6_) / 255 * param5;
         if(_loc8_ >= 1)
         {
            param1.setPixel32(param2,param3,4278190080 | param4 & 0xFFFFFF);
            return;
         }
         var _loc13_:uint = param1.getPixel32(param2,param3);
         var _loc18_:Number = (_loc13_ >>> 24 & 0xFF) / 255;
         var _loc14_:Number = _loc8_ + _loc18_ * (1 - _loc8_);
         if(_loc14_ <= 0)
         {
            param1.setPixel32(param2,param3,0);
            return;
         }
         var _loc16_:Number = param4 >>> 16 & 0xFF;
         var _loc9_:Number = param4 >>> 8 & 0xFF;
         var _loc12_:Number = param4 & 0xFF;
         var _loc7_:Number = _loc13_ >>> 16 & 0xFF;
         var _loc20_:Number = _loc13_ >>> 8 & 0xFF;
         var _loc17_:Number = _loc13_ & 0xFF;
         var _loc19_:uint = Math.min(255,Math.round((_loc16_ * _loc8_ + _loc7_ * _loc18_ * (1 - _loc8_)) / _loc14_));
         var _loc11_:uint = Math.min(255,Math.round((_loc9_ * _loc8_ + _loc20_ * _loc18_ * (1 - _loc8_)) / _loc14_));
         var _loc15_:uint = Math.min(255,Math.round((_loc12_ * _loc8_ + _loc17_ * _loc18_ * (1 - _loc8_)) / _loc14_));
         var _loc10_:uint = Math.min(255,Math.round(_loc14_ * 255));
         param1.setPixel32(param2,param3,_loc10_ << 24 | _loc19_ << 16 | _loc11_ << 8 | _loc15_);
      }
      
      private static function fillPixelRect(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:uint) : void
      {
         param2 = Math.max(0,param2);
         param3 = Math.max(0,param3);
         param4 = Math.min(param1.width,param4);
         param5 = Math.min(param1.height,param5);
         if(param4 <= param2 || param5 <= param3)
         {
            return;
         }
         param1.fillRect(new Rectangle(param2,param3,param4 - param2,param5 - param3),argbFromColor(param6));
      }
      
      private static function drawRectFill(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint) : void
      {
         fillPixelRect(param1,snap(param2),snap(param3),snap(param2 + param4),snap(param3 + param5),param6);
      }
      
      private static function drawRectStroke(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint) : void
      {
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc15_:int = snap(param2);
         var _loc13_:int = snap(param3);
         var _loc12_:int = snap(param2 + param4);
         var _loc8_:int = snap(param3 + param5);
         var _loc14_:int = snappedThickness(param6);
         var _loc9_:int = Math.max(0,_loc15_);
         var _loc16_:int = Math.max(0,_loc13_);
         var _loc18_:int = Math.min(param1.width,_loc12_);
         var _loc17_:int = Math.min(param1.height,_loc8_);
         if(_loc14_ <= 0 || _loc12_ <= _loc15_ || _loc8_ <= _loc13_)
         {
            return;
         }
         _loc11_ = _loc16_;
         while(_loc11_ < _loc17_)
         {
            _loc10_ = _loc9_;
            while(_loc10_ < _loc18_)
            {
               if(_loc10_ < _loc15_ + _loc14_ || _loc10_ >= _loc12_ - _loc14_ || _loc11_ < _loc13_ + _loc14_ || _loc11_ >= _loc8_ - _loc14_)
               {
                  blendPixel(param1,_loc10_,_loc11_,param7,1);
               }
               _loc10_++;
            }
            _loc11_++;
         }
      }
      
      public static function drawRectStrokeSides(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean) : void
      {
         var _loc16_:int = snap(param2);
         var _loc14_:int = snap(param3);
         var _loc13_:int = snap(param2 + param4);
         var _loc12_:int = snap(param3 + param5);
         var _loc15_:int = snappedThickness(param6);
         if(param1 == null || _loc15_ <= 0 || _loc13_ <= _loc16_ || _loc12_ <= _loc14_)
         {
            return;
         }
         if(param8)
         {
            fillPixelRect(param1,_loc16_,_loc14_,_loc13_,_loc14_ + _loc15_,param7);
         }
         if(param9)
         {
            fillPixelRect(param1,_loc13_ - _loc15_,_loc14_,_loc13_,_loc12_,param7);
         }
         if(param10)
         {
            fillPixelRect(param1,_loc16_,_loc12_ - _loc15_,_loc13_,_loc12_,param7);
         }
         if(param11)
         {
            fillPixelRect(param1,_loc16_,_loc14_,_loc16_ + _loc15_,_loc12_,param7);
         }
      }
      
      private static function drawRoundRectFill(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint) : void
      {
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc15_:int = snap(param2);
         var _loc14_:int = snap(param3);
         var _loc12_:int = snap(param2 + param4);
         var _loc8_:int = snap(param3 + param5);
         var _loc13_:int = cornerRadius(param6,_loc12_ - _loc15_,_loc8_ - _loc14_);
         var _loc9_:int = Math.max(0,_loc15_);
         var _loc16_:int = Math.max(0,_loc14_);
         var _loc18_:int = Math.min(param1.width,_loc12_);
         var _loc17_:int = Math.min(param1.height,_loc8_);
         if(_loc12_ <= _loc15_ || _loc8_ <= _loc14_)
         {
            return;
         }
         _loc11_ = _loc16_;
         while(_loc11_ < _loc17_)
         {
            _loc10_ = _loc9_;
            while(_loc10_ < _loc18_)
            {
               if(roundRectContainsPixel(_loc10_,_loc11_,_loc15_,_loc14_,_loc12_,_loc8_,_loc13_))
               {
                  blendPixel(param1,_loc10_,_loc11_,param7,1);
               }
               _loc10_++;
            }
            _loc11_++;
         }
      }
      
      public static function drawRoundRectStroke(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:uint) : void
      {
         var _loc9_:int = 0;
         var _loc23_:int = 0;
         var _loc14_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc22_:int = snap(param2);
         var _loc12_:int = snap(param3);
         var _loc19_:int = snap(param2 + param4);
         var _loc18_:int = snap(param3 + param5);
         var _loc21_:int = snappedThickness(param7);
         var _loc17_:int = cornerRadius(param6,_loc19_ - _loc22_,_loc18_ - _loc12_);
         var _loc24_:int = _loc22_ + _loc21_;
         var _loc16_:int = _loc12_ + _loc21_;
         var _loc25_:int = _loc19_ - _loc21_;
         var _loc20_:int = _loc18_ - _loc21_;
         var _loc15_:int = cornerRadius(Math.max(0,param6 - _loc21_),_loc25_ - _loc24_,_loc20_ - _loc16_);
         if(param1 == null || _loc21_ <= 0 || _loc19_ <= _loc22_ || _loc18_ <= _loc12_)
         {
            return;
         }
         _loc9_ = Math.max(0,_loc22_);
         _loc23_ = Math.max(0,_loc12_);
         _loc14_ = Math.min(param1.width,_loc19_);
         _loc13_ = Math.min(param1.height,_loc18_);
         _loc11_ = _loc23_;
         while(_loc11_ < _loc13_)
         {
            _loc10_ = _loc9_;
            while(_loc10_ < _loc14_)
            {
               if(roundRectContainsPixel(_loc10_,_loc11_,_loc22_,_loc12_,_loc19_,_loc18_,_loc17_) && !roundRectContainsPixel(_loc10_,_loc11_,_loc24_,_loc16_,_loc25_,_loc20_,_loc15_))
               {
                  blendPixel(param1,_loc10_,_loc11_,param8,1);
               }
               _loc10_++;
            }
            _loc11_++;
         }
      }
      
      private static function rhombusContainsPixel(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : Boolean
      {
         var _loc11_:int = param5 - param3;
         var _loc14_:int = param6 - param4;
         if(param1 < param3 || param2 < param4 || param1 >= param5 || param2 >= param6 || _loc11_ <= 0 || _loc14_ <= 0)
         {
            return false;
         }
         var _loc9_:Number = _loc11_ / 2;
         var _loc7_:Number = _loc14_ / 2;
         var _loc13_:Number = _loc11_ / 2;
         var _loc12_:Number = _loc14_ / 2;
         var _loc8_:Number = param1 - param3 + 0.5;
         var _loc10_:Number = param2 - param4 + 0.5;
         return Math.abs(_loc8_ - _loc9_) / _loc13_ + Math.abs(_loc10_ - _loc7_) / _loc12_ <= 1;
      }
      
      private static function drawRhombusFill(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint) : void
      {
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc13_:int = snap(param2);
         var _loc12_:int = snap(param3);
         var _loc11_:int = snap(param2 + param4);
         var _loc7_:int = snap(param3 + param5);
         var _loc8_:int = Math.max(0,_loc13_);
         var _loc14_:int = Math.max(0,_loc12_);
         var _loc16_:int = Math.min(param1.width,_loc11_);
         var _loc15_:int = Math.min(param1.height,_loc7_);
         if(_loc11_ <= _loc13_ || _loc7_ <= _loc12_)
         {
            return;
         }
         _loc10_ = _loc14_;
         while(_loc10_ < _loc15_)
         {
            _loc9_ = _loc8_;
            while(_loc9_ < _loc16_)
            {
               if(rhombusContainsPixel(_loc9_,_loc10_,_loc13_,_loc12_,_loc11_,_loc7_))
               {
                  blendPixel(param1,_loc9_,_loc10_,param6,1);
               }
               _loc9_++;
            }
            _loc10_++;
         }
      }
      
      private static function drawRhombusStroke(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint) : void
      {
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc16_:int = snap(param2);
         var _loc14_:int = snap(param3);
         var _loc12_:int = snap(param2 + param4);
         var _loc8_:int = snap(param3 + param5);
         var _loc15_:int = snappedThickness(param6);
         var _loc19_:int = _loc16_ + _loc15_;
         var _loc21_:int = _loc14_ + _loc15_;
         var _loc22_:int = _loc12_ - _loc15_;
         var _loc13_:int = _loc8_ - _loc15_;
         var _loc9_:int = Math.max(0,_loc16_);
         var _loc17_:int = Math.max(0,_loc14_);
         var _loc20_:int = Math.min(param1.width,_loc12_);
         var _loc18_:int = Math.min(param1.height,_loc8_);
         if(_loc15_ <= 0 || _loc12_ <= _loc16_ || _loc8_ <= _loc14_)
         {
            return;
         }
         _loc11_ = _loc17_;
         while(_loc11_ < _loc18_)
         {
            _loc10_ = _loc9_;
            while(_loc10_ < _loc20_)
            {
               if(rhombusContainsPixel(_loc10_,_loc11_,_loc16_,_loc14_,_loc12_,_loc8_) && !rhombusContainsPixel(_loc10_,_loc11_,_loc19_,_loc21_,_loc22_,_loc13_))
               {
                  blendPixel(param1,_loc10_,_loc11_,param7,1);
               }
               _loc10_++;
            }
            _loc11_++;
         }
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc9_:ShapeController = param1 as ShapeController;
         if(_loc9_ == null || param2 == null || param3 == null || param3.width <= 0 || param3.height <= 0)
         {
            return;
         }
         var _loc6_:int = snappedThickness(_loc9_.strokeThickness);
         var _loc8_:uint = _loc9_.strokeHsvShade != 0 ? HsvLayerColor.deriveColor(param1.color,_loc9_.strokeHsvShade) : _loc9_.strokeColor;
         var _loc7_:Graphics = SHAPE.graphics;
         param2.fillRect(param3,0);
         if(_loc9_.shape == "round_rectangle")
         {
            drawRoundRectFill(param2,param3.x,param3.y,param3.width,param3.height,_loc9_.radius,param1.color);
            if(_loc6_ > 0)
            {
               drawRoundRectStroke(param2,param3.x,param3.y,param3.width,param3.height,_loc9_.radius,_loc6_,_loc8_);
            }
            return;
         }
         if(_loc9_.shape == "rectangle")
         {
            drawRectFill(param2,param3.x,param3.y,param3.width,param3.height,param1.color);
            if(_loc6_ > 0)
            {
               drawRectStroke(param2,param3.x,param3.y,param3.width,param3.height,_loc6_,_loc8_);
            }
            return;
         }
         if(_loc9_.shape == "rhombus")
         {
            drawRhombusFill(param2,param3.x,param3.y,param3.width,param3.height,param1.color);
            if(_loc6_ > 0)
            {
               drawRhombusStroke(param2,param3.x,param3.y,param3.width,param3.height,_loc6_,_loc8_);
            }
            return;
         }
         _loc7_.clear();
         _loc7_.beginFill(param1.color & 0xFFFFFF,alphaFromColor(param1.color));
         if(_loc6_ > 0)
         {
            _loc7_.lineStyle(_loc6_,_loc8_ & 0xFFFFFF,alphaFromColor(_loc8_));
         }
         var _loc10_:* = _loc9_.shape;
         if("ellipse" !== _loc10_)
         {
            _loc7_.drawRect(param3.x,param3.y,param3.width,param3.height);
         }
         else
         {
            _loc7_.drawEllipse(param3.x + _loc6_ / 2,param3.y + _loc6_ / 2,Math.max(0,param3.width - _loc6_),Math.max(0,param3.height - _loc6_));
         }
         _loc7_.endFill();
         param2.draw(SHAPE,null,null,null,param3);
         _loc7_.clear();
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return true;
      }
   }
}

