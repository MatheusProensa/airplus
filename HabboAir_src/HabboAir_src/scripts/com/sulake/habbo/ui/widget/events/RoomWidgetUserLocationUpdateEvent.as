package com.sulake.habbo.ui.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetUserLocationUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const USER_LOCATION_UPDATE:String = "RWULUE_USER_LOCATION_UPDATE";
      
      private var _userId:int;
      
      private var _rectangle:Rectangle;
      
      private var _screenLocation:Point;
      
      public function RoomWidgetUserLocationUpdateEvent(param1:int, param2:Rectangle, param3:Point, param4:Boolean = false, param5:Boolean = false)
      {
         super("RWULUE_USER_LOCATION_UPDATE",param4,param5);
         _userId = param1;
         _rectangle = param2;
         _screenLocation = param3;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get rectangle() : Rectangle
      {
         return _rectangle;
      }
      
      public function get screenLocation() : Point
      {
         return _screenLocation;
      }
   }
}

