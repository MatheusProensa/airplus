package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class PlaneVisualizationLayer implements IComponentInterfaceQueue
   {
      public static const DEFAULT_OFFSET:int = 0;
      
      public static const ALIGN_TOP:int = 1;
      
      public static const ALIGN_BOTTOM:int = 2;
      
      public static const ALIGN_DEFAULT:int = 1;
      
      private var _material:PlaneMaterial = null;
      
      private var _color:uint = 0;
      
      private var _offset:int = 0;
      
      private var _align:int = 1;
      
      private var _bitmapData:BitmapData = null;
      
      private var _disposed:Boolean = false;
      
      public function PlaneVisualizationLayer(param1:PlaneMaterial, param2:uint, param3:int, param4:int = 0)
      {
         super();
         _material = param1;
         _offset = param4;
         _align = param3;
         _color = param2;
      }
      
      public function get offset() : int
      {
         return _offset;
      }
      
      public function get align() : int
      {
         return _align;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _material = null;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
      
      public function clearCache() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
      
      public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean, param6:int, param7:int) : BitmapData
      {
         var _loc16_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc14_:ColorTransform = null;
         var _loc12_:uint = uint(_color >> 16);
         var _loc9_:uint = uint(_color >> 8 & 0xFF);
         var _loc8_:uint = uint(_color & 0xFF);
         var _loc11_:Boolean = false;
         if(_loc12_ < 255 || _loc9_ < 255 || _loc8_ < 255)
         {
            _loc11_ = true;
         }
         if(param1 == null || param1.width != param2 || param1.height != param3)
         {
            param1 = null;
         }
         var _loc15_:* = null;
         if(_material != null)
         {
            if(_loc11_)
            {
               _loc15_ = _material.render(null,param2,param3,param4,param5,param6,param7 + offset,align == 1);
            }
            else
            {
               _loc15_ = _material.render(param1,param2,param3,param4,param5,param6,param7 + offset,align == 1);
            }
         }
         else if(param1 == null)
         {
            if(_bitmapData != null && _bitmapData.width == param2 && _bitmapData.height == param3)
            {
               return _bitmapData;
            }
            if(_bitmapData != null)
            {
               _bitmapData.dispose();
            }
            _bitmapData = new BitmapData(param2,param3,true,4294967295);
            _loc15_ = _bitmapData;
         }
         else
         {
            param1.fillRect(param1.rect,4294967295);
            _loc15_ = param1;
         }
         if(_loc15_ != null)
         {
            if(_loc11_)
            {
               _loc16_ = _loc12_ / 255;
               _loc13_ = _loc9_ / 255;
               _loc10_ = _loc8_ / 255;
               _loc14_ = new ColorTransform(_loc16_,_loc13_,_loc10_);
               _loc15_.colorTransform(_loc15_.rect,_loc14_);
               if(param1 != null && _loc15_ != param1)
               {
                  param1.copyPixels(_loc15_,_loc15_.rect,new Point(0,0),null,null,true);
                  _loc15_ = param1;
               }
            }
         }
         return _loc15_;
      }
      
      public function getMaterial() : PlaneMaterial
      {
         return _material;
      }
      
      public function getColor() : uint
      {
         return _color;
      }
   }
}

