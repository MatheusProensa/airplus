package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class UserUpdateMessageData
   {
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _z:Number = 0;
      
      private var _localZ:Number = 0;
      
      private var _targetX:Number = 0;
      
      private var _targetY:Number = 0;
      
      private var _targetZ:Number = 0;
      
      private var _dir:int = 0;
      
      private var _dirHead:int = 0;
      
      private var UnknownVarFromUserUpdateMessageData_Array_1:Array = [];
      
      private var _isMoving:Boolean = false;
      
      private var _canStandUp:Boolean = false;
      
      private var _skipPositionUpdate:Boolean = false;
      
      private var _jumpingPower:int = 0;
      
      public function UserUpdateMessageData(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Boolean, param13:Array, param14:Boolean, param15:int)
      {
         super();
         _id = param1;
         _x = param2;
         _y = param3;
         _z = param4;
         _localZ = param5;
         _dir = param6;
         _dirHead = param7;
         _targetX = param8;
         _targetY = param9;
         _targetZ = param10;
         _isMoving = param11;
         _canStandUp = param12;
         UnknownVarFromUserUpdateMessageData_Array_1 = param13;
         _skipPositionUpdate = param14;
         _jumpingPower = param15;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function get localZ() : Number
      {
         return _localZ;
      }
      
      public function get targetX() : Number
      {
         return _targetX;
      }
      
      public function get targetY() : Number
      {
         return _targetY;
      }
      
      public function get targetZ() : Number
      {
         return _targetZ;
      }
      
      public function get dir() : int
      {
         return _dir;
      }
      
      public function get dirHead() : int
      {
         return _dirHead;
      }
      
      public function get isMoving() : Boolean
      {
         return _isMoving;
      }
      
      public function get canStandUp() : Boolean
      {
         return _canStandUp;
      }
      
      public function get actions() : Array
      {
         return UnknownVarFromUserUpdateMessageData_Array_1.slice();
      }
      
      public function get skipPositionUpdate() : Boolean
      {
         return _skipPositionUpdate;
      }
      
      public function get jumpingPower() : int
      {
         return _jumpingPower;
      }
   }
}

