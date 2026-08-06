package com.sulake.habbo.ui.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const ROOM_VIEW_SIZE_CHANGED:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
      
      public static const ROOM_VIEW_SCALE_CHANGED:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
      
      public static const ROOM_VIEW_POSITION_CHANGED:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
      
      private var UnknownVarFromRoomWidgetRoomViewUpdateEvent_Rectangle_1:Rectangle;
      
      private var UnknownVarFromRoomWidgetRoomViewUpdateEvent_Point_1:Point;
      
      private var _scale:Number = 0;
      
      public function RoomWidgetRoomViewUpdateEvent(param1:String, param2:Rectangle = null, param3:Point = null, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         UnknownVarFromRoomWidgetRoomViewUpdateEvent_Rectangle_1 = param2;
         UnknownVarFromRoomWidgetRoomViewUpdateEvent_Point_1 = param3;
         _scale = param4;
      }
      
      public function get rect() : Rectangle
      {
         if(UnknownVarFromRoomWidgetRoomViewUpdateEvent_Rectangle_1 != null)
         {
            return UnknownVarFromRoomWidgetRoomViewUpdateEvent_Rectangle_1.clone();
         }
         return null;
      }
      
      public function get positionDelta() : Point
      {
         if(UnknownVarFromRoomWidgetRoomViewUpdateEvent_Point_1 != null)
         {
            return UnknownVarFromRoomWidgetRoomViewUpdateEvent_Point_1.clone();
         }
         return null;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
   }
}

