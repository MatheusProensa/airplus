package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetFurniToWidgetMessage extends RoomWidgetMessage
   {
      public static const WIDGET_MESSAGE_REQUEST_CREDITFURNI_WIDGET:String = "RWFWM_MESSAGE_REQUEST_CREDITFURNI";
      
      public static const WIDGET_MESSAGE_REQUEST_STICKIE_WIDGET:String = "RWFWM_MESSAGE_REQUEST_STICKIE";
      
      public static const WIDGET_MESSAGE_REQUEST_PRESENT_WIDGET:String = "RWFWM_MESSAGE_REQUEST_PRESENT";
      
      public static const WIDGET_MESSAGE_REQUEST_TROPHY_WIDGET:String = "RWFWM_MESSAGE_REQUEST_TROPHY";
      
      public static const WIDGET_MESSAGE_REQUEST_TEASER_WIDGET:String = "RWFWM_MESSAGE_REQUEST_TEASER";
      
      public static const WIDGET_MESSAGE_REQUEST_ECOTRONBOX_WIDGET:String = "RWFWM_MESSAGE_REQUEST_ECOTRONBOX";
      
      public static const WIDGET_MESSAGE_REQUEST_DIMMER_WIDGET:String = "RWFWM_MESSAGE_REQUEST_DIMMER";
      
      public static const WIDGET_MESSAGE_REQUEST_PLACEHOLDER_WIDGET:String = "RWFWM_MESSAGE_REQUEST_PLACEHOLDER";
      
      public static const WIDGET_MESSAGE_REQUEST_CLOTHING_CHANGE_WIDGET:String = "RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE";
      
      public static const WIDGET_MESSAGE_REQUEST_PLAYLIST_EDITOR_WIDGET:String = "RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR";
      
      public static const WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING:String = "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING";
      
      public static const UnknownConstFromRoomWidgetFurniToWidgetMessage_String_1:String = "RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED";
      
      public static const WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING:String = "RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING";
      
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var _roomId:int = 0;
      
      public function RoomWidgetFurniToWidgetMessage(param1:String, param2:int, param3:int, param4:int)
      {
         super(param1);
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

