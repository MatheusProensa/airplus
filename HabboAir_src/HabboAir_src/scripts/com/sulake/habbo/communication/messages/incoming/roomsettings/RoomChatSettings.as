package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   [SecureSWF(rename="true")]
   public class RoomChatSettings
   {
      public static const UnknownConstFromRoomChatSettings_Int_1:int = 0;
      
      public static const UnknownConstFromRoomChatSettings_Int_2:int = 1;
      
      public static const UnknownConstFromRoomChatSettings_Int_3:int = 0;
      
      public static const UnknownConstFromRoomChatSettings_Int_4:int = 1;
      
      public static const UnknownConstFromRoomChatSettings_Int_5:int = 2;
      
      public static const UnknownConstFromRoomChatSettings_Int_6:int = 0;
      
      public static const UnknownConstFromRoomChatSettings_Int_7:int = 1;
      
      public static const UnknownConstFromRoomChatSettings_Int_8:int = 2;
      
      public static const UnknownConstFromRoomChatSettings_Int_9:int = 0;
      
      public static const UnknownConstFromRoomChatSettings_Int_10:int = 1;
      
      public static const UnknownConstFromRoomChatSettings_Int_11:int = 2;
      
      private var _mode:int = 0;
      
      private var _bubbleWidth:int = 1;
      
      private var _scrollSpeed:int = 1;
      
      private var _floodSensitivity:int = 1;
      
      public function RoomChatSettings(param1:int = 0, param2:int = 1, param3:int = 1, param4:int = 1)
      {
         super();
         _mode = param1;
         _bubbleWidth = param2;
         _scrollSpeed = param3;
         _floodSensitivity = param4;
      }
      
      public static function fromFloodSensitivity(param1:int) : RoomChatSettings
      {
         return new RoomChatSettings(0,1,1,param1);
      }
      
      public function get mode() : int
      {
         return _mode;
      }
      
      public function get bubbleWidth() : int
      {
         return _bubbleWidth;
      }
      
      public function get scrollSpeed() : int
      {
         return _scrollSpeed;
      }
      
      public function get floodSensitivity() : int
      {
         return _floodSensitivity;
      }
   }
}

