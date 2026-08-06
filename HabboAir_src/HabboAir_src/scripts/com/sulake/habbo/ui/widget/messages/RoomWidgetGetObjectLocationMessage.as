package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetGetObjectLocationMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetGetObjectLocationMessage_String_1:String = "RWGOI_MESSAGE_GET_OBJECT_LOCATION";
      
      public static const UnknownConstFromRoomWidgetGetObjectLocationMessage_String_2:String = "RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION";
      
      private var _objectId:int;
      
      private var _objectType:int;
      
      public function RoomWidgetGetObjectLocationMessage(param1:String, param2:int, param3:int)
      {
         super(param1);
         _objectId = param2;
         _objectType = param3;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectType() : int
      {
         return _objectType;
      }
   }
}

