package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetOpenProfileMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetOpenProfileMessage_String_1:String = "RWOPEM_OPEN_USER_PROFILE";
      
      private var _userId:int;
      
      private var _trackingLocation:String;
      
      public function RoomWidgetOpenProfileMessage(param1:String, param2:int, param3:String)
      {
         super(param1);
         _userId = param2;
         _trackingLocation = param3;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get trackingLocation() : String
      {
         return _trackingLocation;
      }
   }
}

