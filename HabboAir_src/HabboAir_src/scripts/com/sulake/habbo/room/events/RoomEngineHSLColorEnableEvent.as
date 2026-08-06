package com.sulake.habbo.room.events
{
   public class RoomEngineHSLColorEnableEvent extends RoomEngineEvent
   {
      public static const ROOM_BACKGROUND_COLOR:String = "ROHSLCEE_ROOM_BACKGROUND_COLOR";
      
      private var _enable:Boolean;
      
      private var _hue:int;
      
      private var _saturation:int;
      
      private var _lightness:int;
      
      public function RoomEngineHSLColorEnableEvent(param1:String, param2:int, param3:Boolean, param4:int, param5:int, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param2,param7,param8);
         _enable = param3;
         _hue = param4;
         _saturation = param5;
         _lightness = param6;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function get hue() : int
      {
         return _hue;
      }
      
      public function get saturation() : int
      {
         return _saturation;
      }
      
      public function get lightness() : int
      {
         return _lightness;
      }
   }
}

