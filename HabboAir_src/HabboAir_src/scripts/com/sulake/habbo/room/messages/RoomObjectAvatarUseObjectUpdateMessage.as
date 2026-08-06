package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarUseObjectUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _itemType:int;
      
      public function RoomObjectAvatarUseObjectUpdateMessage(param1:int)
      {
         super();
         _itemType = param1;
      }
      
      public function get itemType() : int
      {
         return _itemType;
      }
   }
}

