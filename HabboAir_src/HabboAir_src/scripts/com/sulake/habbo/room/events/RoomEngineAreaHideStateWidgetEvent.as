package com.sulake.habbo.room.events
{
   public class RoomEngineAreaHideStateWidgetEvent extends RoomEngineToWidgetEvent
   {
      public static const UPDATE_STATE_AREA_HIDE:String = "RETWE_UPDATE_STATE_AREA_HIDE";
      
      private var _isOn:Boolean;
      
      public function RoomEngineAreaHideStateWidgetEvent(param1:int, param2:int, param3:int, param4:Boolean)
      {
         super("RETWE_UPDATE_STATE_AREA_HIDE",param1,param2,param3,null,null,null);
         _isOn = param4;
      }
      
      public function get isOn() : Boolean
      {
         return _isOn;
      }
   }
}

