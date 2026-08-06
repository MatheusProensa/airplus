package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetStickieSendUpdateMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetStickieSendUpdateMessage_String_1:String = "RWSUM_STICKIE_SEND_UPDATE";
      
      public static const UnknownConstFromRoomWidgetStickieSendUpdateMessage_String_2:String = "RWSUM_STICKIE_SEND_DELETE";
      
      private var _objectId:int;
      
      private var _text:String;
      
      private var _colorHex:String;
      
      public function RoomWidgetStickieSendUpdateMessage(param1:String, param2:int, param3:String = "", param4:String = "")
      {
         super(param1);
         _objectId = param2;
         _text = param3;
         _colorHex = param4;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get colorHex() : String
      {
         return _colorHex;
      }
   }
}

