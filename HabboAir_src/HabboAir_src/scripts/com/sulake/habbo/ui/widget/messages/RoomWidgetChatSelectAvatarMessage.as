package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetChatSelectAvatarMessage extends RoomWidgetMessage
   {
      public static const WIDGET_MESSAGE_SELECT_AVATAR:String = "RWCSAM_MESSAGE_SELECT_AVATAR";
      
      private var _objectId:int;
      
      private var _userName:String;
      
      private var _roomId:int;
      
      public function RoomWidgetChatSelectAvatarMessage(param1:String, param2:int, param3:String, param4:int)
      {
         super(param1);
         _objectId = param2;
         _roomId = param4;
         _userName = param3;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}

