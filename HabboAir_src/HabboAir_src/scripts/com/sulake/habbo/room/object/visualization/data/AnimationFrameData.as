package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationFrameData
   {
      private var _id:int = 0;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _randomX:int = 0;
      
      private var _randomY:int = 0;
      
      private var _repeats:int = 1;
      
      public function AnimationFrameData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super();
         _id = param1;
         _x = param2;
         _y = param3;
         _randomX = param4;
         _randomY = param5;
         _repeats = param6;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function hasDirectionalOffsets() : Boolean
      {
         return false;
      }
      
      public function getX(param1:int) : int
      {
         return _x;
      }
      
      public function getY(param1:int) : int
      {
         return _y;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _x;
      }
      
      public function get randomX() : int
      {
         return _randomX;
      }
      
      public function get randomY() : int
      {
         return _randomY;
      }
      
      public function get repeats() : int
      {
         return _repeats;
      }
   }
}

