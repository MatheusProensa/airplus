package com.sulake.habbo.room.messages
{
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectAvatarUpdateMessage extends RoomObjectMoveUpdateMessage
   {
      private var _dirHead:int;
      
      private var _canStandUp:Boolean;
      
      private var _baseY:Number;
      
      private var _jumpingPower:Number;
      
      public function RoomObjectAvatarUpdateMessage(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:int, param5:Boolean, param6:Number, param7:Number = NaN, param8:* = false, param9:Number = NaN)
      {
         super(param1,param2,param3,param7,false,param8);
         _dirHead = param4;
         _canStandUp = param5;
         _baseY = param6;
         _jumpingPower = param9;
      }
      
      public function get dirHead() : int
      {
         return _dirHead;
      }
      
      public function get canStandUp() : Boolean
      {
         return _canStandUp;
      }
      
      public function get baseY() : Number
      {
         return _baseY;
      }
      
      public function get jumpingPower() : Number
      {
         return _jumpingPower;
      }
   }
}

