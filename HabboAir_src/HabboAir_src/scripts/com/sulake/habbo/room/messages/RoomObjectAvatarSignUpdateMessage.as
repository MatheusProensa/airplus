package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarSignUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _signType:int;
      
      public function RoomObjectAvatarSignUpdateMessage(param1:int)
      {
         super();
         _signType = param1;
      }
      
      public function get signType() : int
      {
         return _signType;
      }
   }
}

