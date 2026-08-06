package com.sulake.habbo.room.events
{
   public class RoomEngineDimmerStateEvent extends RoomEngineEvent
   {
      public static const UnknownConstFromRoomEngineDimmerStateEvent_String_1:String = "REDSE_ROOM_COLOR";
      
      private var _state:int;
      
      private var _presetId:int;
      
      private var _effectId:int;
      
      private var _color:uint;
      
      private var _brightness:int;
      
      private var _objectId:int;
      
      public function RoomEngineDimmerStateEvent(param1:int, param2:int, param3:int, param4:int, param5:int, param6:uint, param7:uint, param8:Boolean = false, param9:Boolean = false)
      {
         super("REDSE_ROOM_COLOR",param1,param8,param9);
         _objectId = param2;
         _state = param3;
         _presetId = param4;
         _effectId = param5;
         _color = param6;
         _brightness = param7;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get presetId() : int
      {
         return _presetId;
      }
      
      public function get effectId() : int
      {
         return _effectId;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : uint
      {
         return _brightness;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
   }
}

