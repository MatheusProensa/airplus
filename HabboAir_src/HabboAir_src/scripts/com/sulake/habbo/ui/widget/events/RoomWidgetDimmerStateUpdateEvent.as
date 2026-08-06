package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDimmerStateUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomEngineDimmerStateEvent_String_1:String = "RWDSUE_DIMMER_STATE";
      
      private var _state:int;
      
      private var _presetId:int;
      
      private var _effectId:int;
      
      private var _color:uint;
      
      private var _brightness:int;
      
      private var _objectId:int;
      
      public function RoomWidgetDimmerStateUpdateEvent(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:uint, param7:Boolean = false, param8:Boolean = false)
      {
         super("RWDSUE_DIMMER_STATE",param7,param8);
         _objectId = param1;
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
      
      public function get objectId() : uint
      {
         return _objectId;
      }
   }
}

