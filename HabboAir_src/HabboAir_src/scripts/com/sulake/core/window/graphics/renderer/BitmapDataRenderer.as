package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapDataRenderer extends SkinRenderer
   {
      protected static const UnknownConstFromBitmapDataRenderer_Number_1:Number = 0.212671;
      
      protected static const UnknownConstFromBitmapDataRenderer_Number_2:Number = 0.71516;
      
      protected static const B:Number = 0.072169;
      
      protected static const _MATRIX:Matrix = new Matrix();
      
      protected static const UnknownConstFromBitmapDataRenderer_ColorTransform_1:ColorTransform = new ColorTransform();
      
      protected static const UnknownConstFromBitmapDataRenderer_ColorTransform_2:ColorTransform = new ColorTransform(0,0,0,1,1,1,1,0);
      
      protected static const _GREYSCALE_FILTER:ColorMatrixFilter = new ColorMatrixFilter();
      
      public function BitmapDataRenderer(param1:String)
      {
         super(param1);
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc9_:BitmapData = null;
         var _loc11_:Matrix = null;
         var _loc18_:* = false;
         var _loc20_:* = false;
         var _loc22_:int = 0;
         var _loc14_:int = 0;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc13_:int = 0;
         var _loc15_:int = 0;
         var _loc26_:int = 0;
         var _loc25_:int = 0;
         var _loc19_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc24_:int = 0;
         var _loc23_:int = 0;
         var _loc6_:UnknownICoreWindowUtils4 = param1 as UnknownICoreWindowUtils4;
         var _loc21_:* = _loc6_.bitmapData;
         if(param2 != null && _loc21_ != null)
         {
            if(_loc6_.rotation != 0)
            {
               _loc8_ = _loc21_.width / 2;
               _loc7_ = _loc21_.height / 2;
               _loc9_ = new BitmapData(_loc21_.width,_loc21_.height,true,0);
               _loc11_ = new Matrix();
               _loc11_.translate(-_loc8_,-_loc7_);
               _loc11_.rotate(_loc6_.rotation / 180 * 3.141592653589793);
               _loc11_.translate(_loc8_,_loc7_);
               _loc9_.draw(_loc21_,_loc11_);
               _loc21_ = _loc9_;
            }
            _loc18_ = _loc6_.zoomX < 0 != _loc6_.flipX;
            _loc20_ = _loc6_.zoomY < 0 != _loc6_.flipY;
            _loc22_ = (_loc6_.stretchedX ? param1.width : _loc21_.width) * _loc6_.zoomX;
            _loc14_ = (_loc6_.stretchedY ? param1.height : _loc21_.height) * _loc6_.zoomY;
            _loc12_ = Math.abs(_loc22_);
            _loc10_ = Math.abs(_loc14_);
            _loc13_ = !_loc6_.wrapX ? 1 : param1.width / _loc12_ + 2;
            _loc15_ = !_loc6_.wrapY ? 1 : param1.height / _loc10_ + 2;
            _MATRIX.a = _loc12_ / _loc21_.width * (_loc18_ ? -1 : 1);
            _MATRIX.d = _loc10_ / _loc21_.height * (_loc20_ ? -1 : 1);
            switch(int(_loc6_.pivotPoint))
            {
               case 0:
               case 3:
               case 6:
                  _MATRIX.tx = _loc18_ ? _loc12_ : 0;
                  break;
               case 1:
               case 4:
               case 7:
                  _MATRIX.tx = int((param1.width - _loc12_) / 2) + (_loc18_ ? _loc12_ : 0);
                  break;
               case 2:
               case 5:
               case 8:
                  _MATRIX.tx = _loc18_ ? param1.width : param1.width - _loc12_;
            }
            _loc26_ = _MATRIX.tx;
            while(_loc6_.wrapX && _loc26_ > 0)
            {
               _loc26_ -= _loc12_;
            }
            switch(int(_loc6_.pivotPoint))
            {
               case 0:
               case 1:
               case 2:
                  _MATRIX.ty = _loc20_ ? _loc10_ : 0;
                  break;
               case 3:
               case 4:
               case 5:
                  _MATRIX.ty = int((param1.height - _loc10_) / 2) + (_loc20_ ? _loc10_ : 0);
                  break;
               case 6:
               case 7:
               case 8:
                  _MATRIX.ty = _loc20_ ? param1.height : param1.height - _loc10_;
            }
            _loc25_ = _MATRIX.ty;
            while(_loc6_.wrapY && _loc25_ > 0)
            {
               _loc25_ -= _loc10_;
            }
            _loc19_ = ((param1.color & 0xFF0000) >> 16) / 255;
            _loc17_ = ((param1.color & 0xFF00) >> 8) / 255;
            _loc16_ = (param1.color & 0xFF) / 255;
            UnknownConstFromBitmapDataRenderer_ColorTransform_2.alphaMultiplier = (_loc6_.etchingColor >> 24 & 0xFF) / 255;
            UnknownConstFromBitmapDataRenderer_ColorTransform_2.redOffset = _loc6_.etchingColor >> 16 & 0xFF;
            UnknownConstFromBitmapDataRenderer_ColorTransform_2.greenOffset = _loc6_.etchingColor >> 8 & 0xFF;
            UnknownConstFromBitmapDataRenderer_ColorTransform_2.blueOffset = _loc6_.etchingColor & 0xFF;
            param2.lock();
            _MATRIX.ty = _loc25_;
            _loc24_ = 0;
            while(_loc24_ < _loc15_)
            {
               _MATRIX.tx = _loc26_;
               _loc23_ = 0;
               while(_loc23_ < _loc13_)
               {
                  if(_loc6_.greyscale)
                  {
                     _GREYSCALE_FILTER.matrix = [_loc19_ * 0.212671,_loc19_ * 0.71516,_loc19_ * 0.072169,0,0,_loc17_ * 0.212671,_loc17_ * 0.71516,_loc17_ * 0.072169,0,0,_loc16_ * 0.212671,_loc16_ * 0.71516,_loc16_ * 0.072169,0,0,0,0,0,1,0];
                     if(UnknownConstFromBitmapDataRenderer_ColorTransform_2.alphaMultiplier >= 0.001)
                     {
                        _MATRIX.tx += _loc6_.etchingPoint.x;
                        _MATRIX.ty += _loc6_.etchingPoint.y;
                        param2.draw(_loc21_,_MATRIX,UnknownConstFromBitmapDataRenderer_ColorTransform_2,null,null,false);
                        _MATRIX.tx -= _loc6_.etchingPoint.x;
                        _MATRIX.ty -= _loc6_.etchingPoint.y;
                     }
                     param2.draw(_loc21_,_MATRIX,null,null,null,false);
                     param2.applyFilter(param2,param2.rect,new Point(),_GREYSCALE_FILTER);
                  }
                  else
                  {
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.redMultiplier = _loc19_;
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.greenMultiplier = _loc17_;
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.blueMultiplier = _loc16_;
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.alphaMultiplier = 1;
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.redOffset = 0;
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.greenOffset = 0;
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.blueOffset = 0;
                     UnknownConstFromBitmapDataRenderer_ColorTransform_1.alphaOffset = 0;
                     if(param1.dynamicStyleColor)
                     {
                        UnknownConstFromBitmapDataRenderer_ColorTransform_1.concat(param1.dynamicStyleColor);
                     }
                     if(UnknownConstFromBitmapDataRenderer_ColorTransform_2.alphaMultiplier >= 0.001)
                     {
                        _MATRIX.tx += _loc6_.etchingPoint.x;
                        _MATRIX.ty += _loc6_.etchingPoint.y;
                        param2.draw(_loc21_,_MATRIX,UnknownConstFromBitmapDataRenderer_ColorTransform_2,null,null,false);
                        _MATRIX.tx -= _loc6_.etchingPoint.x;
                        _MATRIX.ty -= _loc6_.etchingPoint.y;
                     }
                     param2.draw(_loc21_,_MATRIX,UnknownConstFromBitmapDataRenderer_ColorTransform_1,null,null,false);
                  }
                  _MATRIX.tx += _loc12_;
                  _loc23_++;
               }
               _MATRIX.ty += _loc10_;
               _loc24_++;
            }
            param2.unlock();
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}

