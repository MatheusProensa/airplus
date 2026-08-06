package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectVisibilityUpdateMessage extends RoomObjectUpdateMessage
   {
      public static const UnknownConstFromRoomDesktopMouseZoomEnableEvent_String_1:String = "ROVUM_ENABLED";
      
      public static const UnknownConstFromRoomObjectVisibilityUpdateMessage_String_1:String = "ROVUM_DISABLED";
      
      private var _type:String;
      
      public function RoomObjectVisibilityUpdateMessage(param1:String)
      {
         super(null,null);
         _type = param1;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}

