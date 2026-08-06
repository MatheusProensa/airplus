package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectDimmerStateUpdateEvent extends RoomObjectEvent
   {
      public static const UnknownConstFromRoomEngineDimmerStateEvent_String_1:String = "RODSUE_DIMMER_STATE";
      
      private var _state:int;
      
      private var _presetId:int;
      
      private var _effectId:int;
      
      private var _color:uint;
      
      private var _brightness:int;
      
      public function RoomObjectDimmerStateUpdateEvent(param1:IRoomObject, param2:int, param3:int, param4:int, param5:uint, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super("RODSUE_DIMMER_STATE",param1,param7,param8);
         _state = param2;
         _presetId = param3;
         _effectId = param4;
         _color = param5;
         _brightness = param6;
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
   }
}

