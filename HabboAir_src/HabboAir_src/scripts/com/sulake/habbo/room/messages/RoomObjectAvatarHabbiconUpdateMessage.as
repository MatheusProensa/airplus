package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarHabbiconUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _habbiconId:int;
      
      public function RoomObjectAvatarHabbiconUpdateMessage(param1:int)
      {
         super();
         _habbiconId = param1;
      }
      
      public function get habbiconId() : int
      {
         return _habbiconId;
      }
   }
}

