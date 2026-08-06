package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPetGestureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _gesture:String;
      
      public function RoomObjectAvatarPetGestureUpdateMessage(param1:String)
      {
         super();
         _gesture = param1;
      }
      
      public function get gesture() : String
      {
         return _gesture;
      }
   }
}

