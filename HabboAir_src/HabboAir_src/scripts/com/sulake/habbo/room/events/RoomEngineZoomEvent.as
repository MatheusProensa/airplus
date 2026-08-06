package com.sulake.habbo.room.events
{
   public class RoomEngineZoomEvent extends RoomEngineEvent
   {
      public static const ROOM_ZOOM:String = "REE_ROOM_ZOOM";
      
      private var _level:Number = 1;
      
      private var _isFlipForced:Boolean = false;
      
      public function RoomEngineZoomEvent(param1:int, param2:Number, param3:* = false, param4:Boolean = false, param5:Boolean = false)
      {
         super("REE_ROOM_ZOOM",param1,param4,param5);
         _level = param2;
         _isFlipForced = param3;
      }
      
      public function get level() : Number
      {
         return _level;
      }
      
      public function get isFlipForced() : Boolean
      {
         return _isFlipForced;
      }
   }
}

