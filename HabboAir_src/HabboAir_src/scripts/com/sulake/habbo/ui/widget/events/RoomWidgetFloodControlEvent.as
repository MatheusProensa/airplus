package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetFloodControlEvent_String_1:String = "RWFCE_FLOOD_CONTROL";
      
      private var _seconds:int = 0;
      
      public function RoomWidgetFloodControlEvent(param1:int)
      {
         super("RWFCE_FLOOD_CONTROL",false,false);
         _seconds = param1;
      }
      
      public function get seconds() : int
      {
         return _seconds;
      }
   }
}

