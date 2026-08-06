package com.sulake.habbo.room.object.visualization.room.utils
{
   import flash.display.BitmapData;
   
   public class PlaneBitmapData
   {
      private var _bitmap:BitmapData = null;
      
      private var _timeStamp:int = 0;
      
      public function PlaneBitmapData(param1:BitmapData, param2:int)
      {
         super();
         _bitmap = param1;
         _timeStamp = param2;
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmap;
      }
      
      public function get timeStamp() : int
      {
         return _timeStamp;
      }
      
      public function dispose() : void
      {
         _bitmap = null;
      }
   }
}

