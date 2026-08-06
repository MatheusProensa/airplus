package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetUpdateEffectsUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetUpdateEffectsUpdateEvent_String_1:String = "RWUEUE_UPDATE_EFFECTS";
      
      private var _effects:Array;
      
      public function RoomWidgetUpdateEffectsUpdateEvent(param1:Array = null, param2:Boolean = false, param3:Boolean = false)
      {
         super("RWUEUE_UPDATE_EFFECTS",param2,param3);
         _effects = param1;
      }
      
      public function get effects() : Array
      {
         return _effects;
      }
   }
}

