package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarGestureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _gesture:int = 0;
      
      public function RoomObjectAvatarGestureUpdateMessage(param1:int)
      {
         super();
         _gesture = param1;
      }
      
      public function get gesture() : int
      {
         return _gesture;
      }
   }
}

