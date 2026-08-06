package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarChatUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _numberOfWords:int;
      
      public function RoomObjectAvatarChatUpdateMessage(param1:int)
      {
         super();
         _numberOfWords = param1;
      }
      
      public function get numberOfWords() : int
      {
         return _numberOfWords;
      }
   }
}

