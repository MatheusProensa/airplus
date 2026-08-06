package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarExpressionUpdateMessage extends RoomObjectUpdateStateMessage
   {
      private var _expressionType:int = -1;
      
      public function RoomObjectAvatarExpressionUpdateMessage(param1:int = -1)
      {
         super();
         _expressionType = param1;
      }
      
      public function get expressionType() : int
      {
         return _expressionType;
      }
   }
}

