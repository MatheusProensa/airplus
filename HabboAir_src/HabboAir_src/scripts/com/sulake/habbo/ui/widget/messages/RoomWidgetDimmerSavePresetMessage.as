package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage
   {
      public static const WIDGET_MESSAGE_SAVE_DIMMER_PRESET:String = "RWSDPM_SAVE_PRESET";
      
      private var _presetNumber:int;
      
      private var _effectTypeId:int;
      
      private var _color:uint;
      
      private var _brightness:int;
      
      private var _apply:Boolean;
      
      private var _objectId:int;
      
      public function RoomWidgetDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean, param6:int)
      {
         super("RWSDPM_SAVE_PRESET");
         _presetNumber = param1;
         _effectTypeId = param2;
         _color = param3;
         _brightness = param4;
         _apply = param5;
         _objectId = param6;
      }
      
      public function get presetNumber() : int
      {
         return _presetNumber;
      }
      
      public function get effectTypeId() : int
      {
         return _effectTypeId;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : int
      {
         return _brightness;
      }
      
      public function get apply() : Boolean
      {
         return _apply;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
   }
}

