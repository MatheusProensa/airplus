package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomObjectUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetRoomObjectUpdateEvent_String_1:String = "RWROUE_OBJECT_SELECTED";
      
      public static const UnknownConstFromRoomWidgetRoomObjectUpdateEvent_String_2:String = "RWROUE_OBJECT_DESELECTED";
      
      public static const USER_REMOVED:String = "RWROUE_USER_REMOVED";
      
      public static const UnknownConstFromRoomWidgetRoomObjectUpdateEvent_String_3:String = "RWROUE_FURNI_REMOVED";
      
      public static const UnknownConstFromRoomWidgetRoomObjectUpdateEvent_String_4:String = "RWROUE_FURNI_ADDED";
      
      public static const USER_ADDED:String = "RWROUE_USER_ADDED";
      
      public static const OBJECT_ROLL_OVER:String = "RWROUE_OBJECT_ROLL_OVER";
      
      public static const UnknownConstFromRoomWidgetRoomObjectUpdateEvent_String_5:String = "RWROUE_OBJECT_ROLL_OUT";
      
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var _roomId:int = 0;
      
      public function RoomWidgetRoomObjectUpdateEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         _id = param2;
         _category = param3;
         _roomId = param4;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}

