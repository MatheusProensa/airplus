package com.sulake.habbo.room.object.visualization.room
{
   public class RoomPlaneRectangleMask
   {
      private var _leftSideLoc:Number = 0;
      
      private var _rightSideLoc:Number = 0;
      
      private var _leftSideLength:Number = 0;
      
      private var _rightSideLength:Number = 0;
      
      public function RoomPlaneRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         _leftSideLoc = param1;
         _rightSideLoc = param2;
         _leftSideLength = param3;
         _rightSideLength = param4;
      }
      
      public function get leftSideLoc() : Number
      {
         return _leftSideLoc;
      }
      
      public function get rightSideLoc() : Number
      {
         return _rightSideLoc;
      }
      
      public function get leftSideLength() : Number
      {
         return _leftSideLength;
      }
      
      public function get rightSideLength() : Number
      {
         return _rightSideLength;
      }
   }
}

