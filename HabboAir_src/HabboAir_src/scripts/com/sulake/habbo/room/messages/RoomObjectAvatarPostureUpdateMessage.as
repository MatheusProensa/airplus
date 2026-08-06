package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _postureType:String;
      
      private var _parameter:String;
      
      public function RoomObjectAvatarPostureUpdateMessage(param1:String, param2:String = "")
      {
         super();
         _postureType = param1;
         _parameter = param2;
      }
      
      public function get postureType() : String
      {
         return _postureType;
      }
      
      public function get parameter() : String
      {
         return _parameter;
      }
   }
}

