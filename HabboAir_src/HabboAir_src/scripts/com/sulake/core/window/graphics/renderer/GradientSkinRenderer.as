package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.GradientController;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class GradientSkinRenderer extends SkinRenderer
   {
      private static const SHAPE:Shape = new Shape();
      
      private static const MATRIX:Matrix = new Matrix();
      
      public function GradientSkinRenderer(param1:String)
      {
         super(param1);
      }
      
      public static function angleForDirection(param1:String) : Number
      {
         switch(GradientController.normalizeDirection(param1))
         {
            case "right":
               return 0;
            case "down":
               return 3.141592653589793 / 2;
            case "left":
               return 3.141592653589793;
            case "up":
               return -1.5707963267948966;
            case "down_right":
               return 3.141592653589793 / 4;
            case "down_left":
               return 2.356194490192345;
            case "up_left":
               return -2.356194490192345;
            case "up_right":
               return -0.7853981633974483;
            default:
               return 3.141592653589793 / 2;
         }
      }
      
      public static function rgbFromColor(param1:uint) : uint
      {
         return param1 & 0xFFFFFF;
      }
      
      public static function alphaFromColor(param1:uint) : Number
      {
         var _loc2_:uint = uint(param1 >>> 24 & 0xFF);
         return _loc2_ == 0 ? 1 : _loc2_ / 255;
      }
      
      public static function drawGradient(param1:BitmapData, param2:Rectangle, param3:uint, param4:uint, param5:String, param6:String) : void
      {
         var _loc9_:String = GradientController.normalizeMode(param5) == "radial" ? "radial" : "linear";
         var _loc7_:Number = _loc9_ == "linear" ? angleForDirection(param6) : 0;
         MATRIX.createGradientBox(param2.width,param2.height,_loc7_,param2.x,param2.y);
         var _loc8_:Graphics = SHAPE.graphics;
         _loc8_.clear();
         _loc8_.beginGradientFill(_loc9_,[rgbFromColor(param3),rgbFromColor(param4)],[alphaFromColor(param3),alphaFromColor(param4)],[0,255],MATRIX,"pad","rgb");
         _loc8_.drawRect(param2.x,param2.y,param2.width,param2.height);
         _loc8_.endFill();
         param1.fillRect(param2,0);
         param1.draw(SHAPE,null,null,null,param2);
         _loc8_.clear();
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc6_:GradientController = param1 as GradientController;
         if(_loc6_ == null || param2 == null || param3 == null || param3.width <= 0 || param3.height <= 0)
         {
            return;
         }
         drawGradient(param2,param3,_loc6_.color1,_loc6_.color2,_loc6_.mode,_loc6_.direction);
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return true;
      }
   }
}

