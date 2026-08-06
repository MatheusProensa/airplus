package com.sulake.habbo.room.object
{
   public class RoomFloorHole
   {
      private var _x:int;
      
      private var _y:int;
      
      private var _width:int;
      
      private var _height:int;
      
      public function RoomFloorHole(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         _x = param1;
         _y = param2;
         _width = param3;
         _height = param4;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
   }
}

