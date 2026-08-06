package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPresentOpenMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetPresentOpenMessage_String_1:String = "RWPOM_OPEN_PRESENT";
      
      private var _objectId:int;
      
      public function RoomWidgetPresentOpenMessage(param1:String, param2:int)
      {
         super(param1);
         _objectId = param2;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
   }
}

