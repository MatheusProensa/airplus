package com.sulake.core.window.graphics.renderer
{
   import flash.geom.ColorTransform;
   
   public class HsvLayerColor
   {
      public function HsvLayerColor()
      {
         super();
      }
      
      public static function configureTransform(param1:ColorTransform, param2:uint, param3:Number) : void
      {
         var _loc4_:uint = deriveColor(param2,param3);
         param1.redMultiplier = ((_loc4_ & 0xFF0000) >> 16) / 255;
         param1.greenMultiplier = ((_loc4_ & 0xFF00) >> 8) / 255;
         param1.blueMultiplier = (_loc4_ & 0xFF) / 255;
         param1.alphaMultiplier = 1;
         param1.redOffset = 0;
         param1.greenOffset = 0;
         param1.blueOffset = 0;
         param1.alphaOffset = 0;
      }
      
      public static function deriveColor(param1:uint, param2:Number) : uint
      {
         if(isNaN(param2))
         {
            param2 = 0;
         }
         var _loc3_:Number = ((param1 & 0xFF0000) >> 16) / 255;
         var _loc5_:Number = ((param1 & 0xFF00) >> 8) / 255;
         var _loc4_:Number = (param1 & 0xFF) / 255;
         var _loc6_:Object = rgbToHsv(_loc3_,_loc5_,_loc4_);
         var _loc7_:* = _loc6_.s == 0;
         if(_loc7_)
         {
            _loc6_.s = 0;
            _loc6_.v -= param2;
         }
         else
         {
            _loc6_.s = clamp01(_loc6_.s + param2);
            _loc6_.v = clamp01(_loc6_.v - param2 / 2);
         }
         return hsvToRgb(_loc6_.h,_loc6_.s,_loc6_.v);
      }
      
      private static function rgbToHsv(param1:Number, param2:Number, param3:Number) : Object
      {
         var _loc6_:Number = Math.max(param1,Math.max(param2,param3));
         var _loc4_:Number = Math.min(param1,Math.min(param2,param3));
         var _loc7_:Number = _loc6_ - _loc4_;
         var _loc8_:Number = 0;
         var _loc5_:Number = _loc6_ == 0 ? 0 : _loc7_ / _loc6_;
         if(_loc7_ != 0)
         {
            if(_loc6_ == param1)
            {
               _loc8_ = (param2 - param3) / _loc7_;
               if(param2 < param3)
               {
                  _loc8_ += 6;
               }
            }
            else if(_loc6_ == param2)
            {
               _loc8_ = (param3 - param1) / _loc7_ + 2;
            }
            else
            {
               _loc8_ = (param1 - param2) / _loc7_ + 4;
            }
            _loc8_ /= 6;
         }
         return {
            "h":_loc8_,
            "s":_loc5_,
            "v":_loc6_
         };
      }
      
      private static function hsvToRgb(param1:Number, param2:Number, param3:Number) : uint
      {
         param1 -= Math.floor(param1);
         if(param2 == 0)
         {
            return toColor(param3,param3,param3);
         }
         var _loc9_:Number = param1 * 6;
         var _loc8_:int = Math.floor(_loc9_);
         var _loc7_:Number = _loc9_ - _loc8_;
         var _loc4_:Number = param3 * (1 - param2);
         var _loc5_:Number = param3 * (1 - param2 * _loc7_);
         var _loc6_:Number = param3 * (1 - param2 * (1 - _loc7_));
         switch(_loc8_ % 6)
         {
            case 0:
               return toColor(param3,_loc6_,_loc4_);
            case 1:
               return toColor(_loc5_,param3,_loc4_);
            case 2:
               return toColor(_loc4_,param3,_loc6_);
            case 3:
               return toColor(_loc4_,_loc5_,param3);
            case 4:
               return toColor(_loc6_,_loc4_,param3);
            default:
               return toColor(param3,_loc4_,_loc5_);
         }
      }
      
      private static function toColor(param1:Number, param2:Number, param3:Number) : uint
      {
         return toByte(param1) << 16 | toByte(param2) << 8 | toByte(param3);
      }
      
      private static function toByte(param1:Number) : uint
      {
         return uint(Math.round(clamp01(param1) * 255));
      }
      
      private static function clamp01(param1:Number) : Number
      {
         if(isNaN(param1) || param1 < 0)
         {
            return 0;
         }
         if(param1 > 1)
         {
            return 1;
         }
         return param1;
      }
   }
}

