package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import flash.display.BitmapData;
   
   public class PlaneTextureBitmap
   {
      public static const UnknownConstFromPlaneMaskVisualization_Number_1:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
      
      private var _bitmap:BitmapData = null;
      
      private var _normalMinX:Number = -1;
      
      private var _normalMaxX:Number = 1;
      
      private var _normalMinY:Number = -1;
      
      private var _normalMaxY:Number = 1;
      
      private var _assetName:String = null;
      
      public function PlaneTextureBitmap(param1:BitmapData, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1, param6:String = null)
      {
         super();
         _normalMinX = param2;
         _normalMaxX = param3;
         _normalMinY = param4;
         _normalMaxY = param5;
         _assetName = param6;
         _bitmap = param1;
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmap;
      }
      
      public function get normalMinX() : Number
      {
         return _normalMinX;
      }
      
      public function get normalMaxX() : Number
      {
         return _normalMaxX;
      }
      
      public function get normalMinY() : Number
      {
         return _normalMinY;
      }
      
      public function get normalMaxY() : Number
      {
         return _normalMaxY;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function dispose() : void
      {
         _bitmap = null;
      }
   }
}

