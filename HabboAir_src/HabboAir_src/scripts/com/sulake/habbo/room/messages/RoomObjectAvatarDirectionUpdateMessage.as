package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectAvatarDirectionUpdateMessage extends RoomObjectUpdateMessage
   {
      private var _dirHead:int;
      
      public function RoomObjectAvatarDirectionUpdateMessage(param1:IVector3d, param2:IVector3d, param3:int)
      {
         super(param1,param2);
         _dirHead = param3;
      }
      
      public function get dirHead() : int
      {
         return _dirHead;
      }
   }
}

