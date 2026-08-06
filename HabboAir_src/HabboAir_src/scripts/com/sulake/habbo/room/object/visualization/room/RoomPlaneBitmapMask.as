package com.sulake.habbo.room.object.visualization.room
{
   public class RoomPlaneBitmapMask
   {
      private var _type:String = null;
      
      private var _leftSideLoc:Number = 0;
      
      private var _rightSideLoc:Number = 0;
      
      public function RoomPlaneBitmapMask(param1:String, param2:Number, param3:Number)
      {
         super();
         _type = param1;
         _leftSideLoc = param2;
         _rightSideLoc = param3;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get leftSideLoc() : Number
      {
         return _leftSideLoc;
      }
      
      public function get rightSideLoc() : Number
      {
         return _rightSideLoc;
      }
   }
}

