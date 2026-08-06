package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarCarryObjectUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _itemType:int;
      
      private var _itemName:String;
      
      public function RoomObjectAvatarCarryObjectUpdateMessage(param1:int, param2:String)
      {
         super();
         _itemType = param1;
         _itemName = param2;
      }
      
      public function get itemType() : int
      {
         return _itemType;
      }
      
      public function get itemName() : String
      {
         return _itemName;
      }
   }
}

