package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionDimmerPresetsEvent extends RoomSessionEvent
   {
      public static const ROOM_DIMMER_PRESETS:String = "RSDPE_PRESETS";
      
      private var _selectedPresetId:int = 0;
      
      private var UnknownVarFromRoomSessionDimmerPresetsEvent_Array_1:Array = [];
      
      private var _itemId:int;
      
      private var _isOn:Boolean;
      
      public function RoomSessionDimmerPresetsEvent(param1:String, param2:IRoomSession, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get selectedPresetId() : int
      {
         return _selectedPresetId;
      }
      
      public function get presetCount() : int
      {
         return UnknownVarFromRoomSessionDimmerPresetsEvent_Array_1.length;
      }
      
      public function set selectedPresetId(param1:int) : void
      {
         _selectedPresetId = param1;
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function set itemId(param1:int) : void
      {
         _itemId = param1;
      }
      
      public function get isOn() : Boolean
      {
         return _isOn;
      }
      
      public function set isOn(param1:Boolean) : void
      {
         _isOn = param1;
      }
      
      public function storePreset(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:RoomSessionDimmerPresetsEventPresetItem = new RoomSessionDimmerPresetsEventPresetItem(param1,param2,param3,param4);
         UnknownVarFromRoomSessionDimmerPresetsEvent_Array_1[param1 - 1] = _loc5_;
      }
      
      public function getPreset(param1:int) : RoomSessionDimmerPresetsEventPresetItem
      {
         if(param1 < 0 || param1 >= UnknownVarFromRoomSessionDimmerPresetsEvent_Array_1.count)
         {
            return null;
         }
         return UnknownVarFromRoomSessionDimmerPresetsEvent_Array_1[param1];
      }
   }
}

