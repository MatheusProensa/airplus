package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarBlockedUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _isBlocked:Boolean = false;
      
      public function RoomObjectAvatarBlockedUpdateMessage(param1:Boolean)
      {
         super();
         _isBlocked = param1;
      }
      
      public function get isBlocked() : Boolean
      {
         return _isBlocked;
      }
   }
}

