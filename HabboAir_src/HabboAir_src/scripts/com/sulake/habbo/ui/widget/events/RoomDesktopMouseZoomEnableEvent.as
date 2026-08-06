package com.sulake.habbo.ui.widget.events
{
   import flash.events.Event;
   
   public class RoomDesktopMouseZoomEnableEvent extends Event
   {
      public static const UnknownConstFromRoomDesktopMouseZoomEnableEvent_String_1:String = "RDMZEE_ENABLED";
      
      private var UnknownVarFromRoomDesktopMouseZoomEnableEvent_Boolean_1:Boolean;
      
      public function RoomDesktopMouseZoomEnableEvent(param1:Boolean)
      {
         super("RDMZEE_ENABLED");
         UnknownVarFromRoomDesktopMouseZoomEnableEvent_Boolean_1 = param1;
      }
   }
}

