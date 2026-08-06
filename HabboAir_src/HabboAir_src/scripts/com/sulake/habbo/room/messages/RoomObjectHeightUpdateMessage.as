package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectHeightUpdateMessage extends RoomObjectUpdateMessage
   {
      private var _height:Number;
      
      public function RoomObjectHeightUpdateMessage(param1:IVector3d, param2:IVector3d, param3:Number)
      {
         super(param1,param2);
         _height = param3;
      }
      
      public function get height() : Number
      {
         return _height;
      }
   }
}

