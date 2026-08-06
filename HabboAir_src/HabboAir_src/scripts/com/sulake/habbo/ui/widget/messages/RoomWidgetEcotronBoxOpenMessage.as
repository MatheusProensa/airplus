package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetEcotronBoxOpenMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetEcotronBoxOpenMessage_String_1:String = "RWEBOM_OPEN_ECOTRONBOX";
      
      private var _objectId:int;
      
      public function RoomWidgetEcotronBoxOpenMessage(param1:String, param2:int)
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

