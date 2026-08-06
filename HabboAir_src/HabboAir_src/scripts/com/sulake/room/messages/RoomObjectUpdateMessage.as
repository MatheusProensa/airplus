package com.sulake.room.messages
{
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectUpdateMessage
   {
      protected var _loc:IVector3d;
      
      protected var _dir:IVector3d;
      
      public function RoomObjectUpdateMessage(param1:IVector3d, param2:IVector3d)
      {
         super();
         _loc = param1;
         _dir = param2;
      }
      
      public function get loc() : IVector3d
      {
         return _loc;
      }
      
      public function get dir() : IVector3d
      {
         return _dir;
      }
   }
}

