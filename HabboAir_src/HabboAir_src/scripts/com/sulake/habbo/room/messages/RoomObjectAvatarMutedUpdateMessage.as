package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarMutedUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _isMuted:Boolean;
      
      public function RoomObjectAvatarMutedUpdateMessage(param1:Boolean = false)
      {
         super();
         _isMuted = param1;
      }
      
      public function get isMuted() : Boolean
      {
         return _isMuted;
      }
   }
}

