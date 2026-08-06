package com.sulake.habbo.ui.widget.events
{
   import flash.events.Event;
   
   public class HideRoomWidgetEvent extends Event
   {
      public static const HIDE_ROOM_WIDGET:String = "hrwe_hide_room_widget";
      
      private var _widgetType:String;
      
      public function HideRoomWidgetEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("hrwe_hide_room_widget",param2,param3);
         _widgetType = param1;
      }
      
      public function get widgetType() : String
      {
         return _widgetType;
      }
   }
}

