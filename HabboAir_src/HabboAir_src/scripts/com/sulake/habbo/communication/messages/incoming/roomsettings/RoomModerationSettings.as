package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RoomModerationSettings
   {
      public static const UnknownConstFromRoomModerationSettings_Int_1:int = 0;
      
      public static const UnknownConstFromRoomModerationSettings_Int_2:int = 1;
      
      public static const UnknownConstFromRoomModerationSettings_Int_3:int = 2;
      
      public static const UnknownConstFromRoomModerationSettings_Int_4:int = 4;
      
      public static const UnknownConstFromRoomModerationSettings_Int_5:int = 5;
      
      private var _whoCanMute:int;
      
      private var _whoCanKick:int;
      
      private var _whoCanBan:int;
      
      public function RoomModerationSettings(param1:IMessageDataWrapper)
      {
         super();
         _whoCanMute = param1.readInteger();
         _whoCanKick = param1.readInteger();
         _whoCanBan = param1.readInteger();
      }
      
      public function get whoCanMute() : int
      {
         return _whoCanMute;
      }
      
      public function get whoCanKick() : int
      {
         return _whoCanKick;
      }
      
      public function get whoCanBan() : int
      {
         return _whoCanBan;
      }
   }
}

