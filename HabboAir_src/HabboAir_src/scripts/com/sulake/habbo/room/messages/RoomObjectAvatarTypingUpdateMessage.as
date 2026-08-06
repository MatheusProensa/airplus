package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarTypingUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _isTyping:Boolean;
      
      public function RoomObjectAvatarTypingUpdateMessage(param1:Boolean = false)
      {
         super();
         _isTyping = param1;
      }
      
      public function get isTyping() : Boolean
      {
         return _isTyping;
      }
   }
}

