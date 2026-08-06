package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDimmerUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetDimmerUpdateEvent_String_1:String = "RWDUE_PRESETS";
      
      public static const DIMMER_HIDE:String = "RWDUE_HIDE";
      
      private var _selectedPresetId:int = 0;
      
      private var _presets:Array = [];
      
      private var _itemId:int = 0;
      
      private var _isOn:Boolean = false;
      
      public function RoomWidgetDimmerUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function get selectedPresetId() : int
      {
         return _selectedPresetId;
      }
      
      public function get presetCount() : int
      {
         return _presets.length;
      }
      
      public function get presets() : Array
      {
         return _presets;
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
         var _loc5_:RoomWidgetDimmerUpdateEventPresetItem = new RoomWidgetDimmerUpdateEventPresetItem(param1,param2,param3,param4);
         _presets[param1 - 1] = _loc5_;
      }
      
      public function getPreset(param1:int) : RoomWidgetDimmerUpdateEventPresetItem
      {
         if(param1 < 0 || param1 >= _presets.count)
         {
            return null;
         }
         return _presets[param1];
      }
   }
}

