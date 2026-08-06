package com.sulake.habbo.communication.messages.outgoing.camera.json
{
   [SecureSWF(rename="false")]
   public class JsonPlaneDrawingData
   {
      private var _z:Number;
      
      private var _cornerPoints:Vector.<JsonPoint> = new Vector.<JsonPoint>();
      
      private var _color:uint;
      
      private var _masks:Array = [];
      
      private var _bottomAligned:Boolean;
      
      private var _texCols:Array = [];
      
      public function JsonPlaneDrawingData()
      {
         super();
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set z(param1:Number) : void
      {
         _z = param1;
      }
      
      public function get cornerPoints() : Vector.<JsonPoint>
      {
         return _cornerPoints;
      }
      
      public function addCornerPoint(param1:int, param2:int) : void
      {
         _cornerPoints.push(new JsonPoint(param1,param2));
      }
      
      public function get masks() : Array
      {
         return _masks;
      }
      
      public function addMask(param1:JsonMaskDrawingData) : void
      {
         _masks.push(param1);
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get bottomAligned() : Boolean
      {
         return _bottomAligned;
      }
      
      public function setBottomAligned(param1:Boolean) : void
      {
         _bottomAligned = param1;
      }
      
      public function get texCols() : Array
      {
         return _texCols;
      }
      
      public function addTexCol(param1:JsonTextureColumnData) : void
      {
         _texCols.push(param1);
      }
   }
}

