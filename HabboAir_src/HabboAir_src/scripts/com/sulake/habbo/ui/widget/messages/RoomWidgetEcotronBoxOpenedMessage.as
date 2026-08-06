package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetEcotronBoxOpenedMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetEcotronBoxOpenedMessage_String_1:String = "RWEBOM_ECOTRONBOX_OPENED";
      
      private var _itemType:String;
      
      private var _classId:int;
      
      public function RoomWidgetEcotronBoxOpenedMessage(param1:String, param2:String, param3:int)
      {
         super(param1);
         _itemType = param2;
         _classId = param3;
      }
      
      public function get itemType() : String
      {
         return _itemType;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
   }
}

