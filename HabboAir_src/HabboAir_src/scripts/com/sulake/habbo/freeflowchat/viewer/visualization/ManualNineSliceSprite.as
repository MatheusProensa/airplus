package com.sulake.habbo.freeflowchat.viewer.visualization
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ManualNineSliceSprite extends Sprite
   {
      private static const ZERO_POINT:Point = new Point();
      
      private var _bitmap:Bitmap;
      
      private var _patches:Vector.<BitmapData>;
      
      private var _leftWidth:int;
      
      private var _centerWidth:int;
      
      private var _rightWidth:int;
      
      private var UnknownVarFromManualNineSliceSprite_Int_1:int;
      
      private var UnknownVarFromManualNineSliceSprite_Int_2:int;
      
      private var UnknownVarFromManualNineSliceSprite_Int_3:int;
      
      private var _width:int;
      
      private var _height:int;
      
      public function ManualNineSliceSprite(param1:Rectangle, param2:BitmapData)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         _leftWidth = param1.x;
         _centerWidth = param1.width;
         _rightWidth = param2.width - int(param1.right);
         UnknownVarFromManualNineSliceSprite_Int_1 = param1.y;
         UnknownVarFromManualNineSliceSprite_Int_2 = param1.height;
         UnknownVarFromManualNineSliceSprite_Int_3 = param2.height - int(param1.bottom);
         _width = param2.width;
         _height = param2.height;
         _patches = createPatches(param2);
         _bitmap = new Bitmap(null,"always",false);
         addChild(_bitmap);
         redraw();
      }
      
      override public function get width() : Number
      {
         return _width;
      }
      
      override public function set width(param1:Number) : void
      {
         var _loc2_:int = Math.max(_leftWidth + _rightWidth,Math.round(param1));
         if(_width == _loc2_)
         {
            return;
         }
         _width = _loc2_;
         redraw();
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      override public function set height(param1:Number) : void
      {
         var _loc2_:int = Math.max(UnknownVarFromManualNineSliceSprite_Int_1 + UnknownVarFromManualNineSliceSprite_Int_3,Math.round(param1));
         if(_height == _loc2_)
         {
            return;
         }
         _height = _loc2_;
         redraw();
      }
      
      private function createPatches(param1:BitmapData) : Vector.<BitmapData>
      {
         var _loc2_:Vector.<BitmapData> = new Vector.<BitmapData>(9,true);
         _loc2_[0] = extractPatch(param1,0,0,_leftWidth,UnknownVarFromManualNineSliceSprite_Int_1);
         _loc2_[1] = extractPatch(param1,_leftWidth,0,_centerWidth,UnknownVarFromManualNineSliceSprite_Int_1);
         _loc2_[2] = extractPatch(param1,_leftWidth + _centerWidth,0,_rightWidth,UnknownVarFromManualNineSliceSprite_Int_1);
         _loc2_[3] = extractPatch(param1,0,UnknownVarFromManualNineSliceSprite_Int_1,_leftWidth,UnknownVarFromManualNineSliceSprite_Int_2);
         _loc2_[4] = extractPatch(param1,_leftWidth,UnknownVarFromManualNineSliceSprite_Int_1,_centerWidth,UnknownVarFromManualNineSliceSprite_Int_2);
         _loc2_[5] = extractPatch(param1,_leftWidth + _centerWidth,UnknownVarFromManualNineSliceSprite_Int_1,_rightWidth,UnknownVarFromManualNineSliceSprite_Int_2);
         _loc2_[6] = extractPatch(param1,0,UnknownVarFromManualNineSliceSprite_Int_1 + UnknownVarFromManualNineSliceSprite_Int_2,_leftWidth,UnknownVarFromManualNineSliceSprite_Int_3);
         _loc2_[7] = extractPatch(param1,_leftWidth,UnknownVarFromManualNineSliceSprite_Int_1 + UnknownVarFromManualNineSliceSprite_Int_2,_centerWidth,UnknownVarFromManualNineSliceSprite_Int_3);
         _loc2_[8] = extractPatch(param1,_leftWidth + _centerWidth,UnknownVarFromManualNineSliceSprite_Int_1 + UnknownVarFromManualNineSliceSprite_Int_2,_rightWidth,UnknownVarFromManualNineSliceSprite_Int_3);
         return _loc2_;
      }
      
      private function extractPatch(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : BitmapData
      {
         if(param4 <= 0 || param5 <= 0)
         {
            return null;
         }
         var _loc6_:BitmapData = new BitmapData(param4,param5,true,0);
         _loc6_.copyPixels(param1,new Rectangle(param2,param3,param4,param5),ZERO_POINT);
         return _loc6_;
      }
      
      private function redraw() : void
      {
         var _loc5_:int = Math.max(_leftWidth + _rightWidth,_width);
         var _loc1_:int = Math.max(UnknownVarFromManualNineSliceSprite_Int_1 + UnknownVarFromManualNineSliceSprite_Int_3,_height);
         var _loc2_:int = _loc5_ - _leftWidth - _rightWidth;
         var _loc3_:int = _loc1_ - UnknownVarFromManualNineSliceSprite_Int_1 - UnknownVarFromManualNineSliceSprite_Int_3;
         var _loc4_:BitmapData = new BitmapData(_loc5_,_loc1_,true,0);
         drawPatch(_loc4_,_patches[0],0,0,_leftWidth,UnknownVarFromManualNineSliceSprite_Int_1);
         drawPatch(_loc4_,_patches[1],_leftWidth,0,_loc2_,UnknownVarFromManualNineSliceSprite_Int_1);
         drawPatch(_loc4_,_patches[2],_leftWidth + _loc2_,0,_rightWidth,UnknownVarFromManualNineSliceSprite_Int_1);
         drawPatch(_loc4_,_patches[3],0,UnknownVarFromManualNineSliceSprite_Int_1,_leftWidth,_loc3_);
         drawPatch(_loc4_,_patches[4],_leftWidth,UnknownVarFromManualNineSliceSprite_Int_1,_loc2_,_loc3_);
         drawPatch(_loc4_,_patches[5],_leftWidth + _loc2_,UnknownVarFromManualNineSliceSprite_Int_1,_rightWidth,_loc3_);
         drawPatch(_loc4_,_patches[6],0,UnknownVarFromManualNineSliceSprite_Int_1 + _loc3_,_leftWidth,UnknownVarFromManualNineSliceSprite_Int_3);
         drawPatch(_loc4_,_patches[7],_leftWidth,UnknownVarFromManualNineSliceSprite_Int_1 + _loc3_,_loc2_,UnknownVarFromManualNineSliceSprite_Int_3);
         drawPatch(_loc4_,_patches[8],_leftWidth + _loc2_,UnknownVarFromManualNineSliceSprite_Int_1 + _loc3_,_rightWidth,UnknownVarFromManualNineSliceSprite_Int_3);
         if(_bitmap.bitmapData != null)
         {
            _bitmap.bitmapData.dispose();
         }
         _bitmap.bitmapData = _loc4_;
      }
      
      private function drawPatch(param1:BitmapData, param2:BitmapData, param3:int, param4:int, param5:int, param6:int) : void
      {
         if(param2 == null || param5 <= 0 || param6 <= 0)
         {
            return;
         }
         if(param2.width == param5 && param2.height == param6)
         {
            param1.copyPixels(param2,param2.rect,new Point(param3,param4));
            return;
         }
         var _loc7_:Matrix = new Matrix();
         _loc7_.scale(param5 / param2.width,param6 / param2.height);
         _loc7_.translate(param3,param4);
         param1.draw(param2,_loc7_,null,null,new Rectangle(param3,param4,param5,param6),false);
      }
   }
}

