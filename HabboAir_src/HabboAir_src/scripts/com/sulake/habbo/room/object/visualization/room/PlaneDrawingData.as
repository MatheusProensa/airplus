package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.room.object.visualization.IRoomObjectSprite_1;
   import flash.geom.Point;
   
   public class PlaneDrawingData implements IRoomObjectSprite_1
   {
      private var _z:Number;
      
      private var _cornerPoints:Vector.<Point>;
      
      private var _color:uint;
      
      private var _maskAssetNames:Array;
      
      private var _maskAssetLocations:Array;
      
      private var _maskAssetFlipHs:Array;
      
      private var _maskAssetFlipVs:Array;
      
      private var _isBottomAligned:Boolean = false;
      
      private var _assetNames:Array = [];
      
      public function PlaneDrawingData(param1:PlaneDrawingData = null, param2:uint = 0, param3:Boolean = false)
      {
         super();
         _maskAssetNames = [];
         _maskAssetLocations = [];
         _maskAssetFlipHs = [];
         _maskAssetFlipVs = [];
         if(param1 != null)
         {
            _maskAssetNames = param1._maskAssetNames;
            _maskAssetLocations = param1._maskAssetLocations;
            _maskAssetFlipHs = param1._maskAssetFlipHs;
            _maskAssetFlipVs = param1._maskAssetFlipVs;
         }
         _color = param2;
         _isBottomAligned = param3;
      }
      
      public function addMask(param1:String, param2:Point, param3:Boolean, param4:Boolean) : void
      {
         _maskAssetNames.push(param1);
         _maskAssetLocations.push(param2);
         _maskAssetFlipHs.push(param3);
         _maskAssetFlipVs.push(param4);
      }
      
      public function addAssetColumn(param1:Array) : void
      {
         _assetNames.push(param1);
      }
      
      public function set z(param1:Number) : void
      {
         _z = param1;
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set cornerPoints(param1:Vector.<Point>) : void
      {
         _cornerPoints = param1;
      }
      
      public function get cornerPoints() : Vector.<Point>
      {
         return _cornerPoints;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get maskAssetNames() : Array
      {
         return _maskAssetNames;
      }
      
      public function get maskAssetLocations() : Array
      {
         return _maskAssetLocations;
      }
      
      public function get maskAssetFlipHs() : Array
      {
         return _maskAssetFlipHs;
      }
      
      public function get maskAssetFlipVs() : Array
      {
         return _maskAssetFlipVs;
      }
      
      public function isBottomAligned() : Boolean
      {
         return _isBottomAligned;
      }
      
      public function get assetNameColumns() : Array
      {
         return _assetNames;
      }
   }
}

