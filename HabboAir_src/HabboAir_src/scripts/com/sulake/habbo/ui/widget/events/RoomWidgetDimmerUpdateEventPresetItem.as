package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDimmerUpdateEventPresetItem
   {
      private var _id:int = 0;
      
      private var _type:int = 0;
      
      private var _color:uint = 0;
      
      private var _light:uint = 0;
      
      public function RoomWidgetDimmerUpdateEventPresetItem(param1:int, param2:int, param3:uint, param4:uint)
      {
         super();
         _id = param1;
         _type = param2;
         _color = param3;
         _light = param4;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get light() : int
      {
         return _light;
      }
   }
}

