package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   
   public class PlaneMaskBitmap
   {
      public static const UnknownConstFromPlaneMaskVisualization_Number_1:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
      
      private var _asset:IGraphicAsset = null;
      
      private var _normalMinX:Number = -1;
      
      private var _normalMaxX:Number = 1;
      
      private var _normalMinY:Number = -1;
      
      private var _normalMaxY:Number = 1;
      
      public function PlaneMaskBitmap(param1:IGraphicAsset, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1)
      {
         super();
         _normalMinX = param2;
         _normalMaxX = param3;
         _normalMinY = param4;
         _normalMaxY = param5;
         _asset = param1;
      }
      
      public function get asset() : IGraphicAsset
      {
         return _asset;
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
      
      public function dispose() : void
      {
         _asset = null;
      }
   }
}

