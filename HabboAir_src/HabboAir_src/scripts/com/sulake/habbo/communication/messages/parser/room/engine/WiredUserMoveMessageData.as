package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class WiredUserMoveMessageData
   {
      private var _userIndex:int;
      
      private var _source:Vector3d;
      
      private var _target:Vector3d;
      
      private var _moveType:String;
      
      private var _animationTime:Number;
      
      private var _bodyDirection:Number;
      
      private var _headDirection:Number;
      
      private var _jumpPower:Number;
      
      public function WiredUserMoveMessageData(param1:int, param2:Vector3d, param3:Vector3d, param4:String, param5:Number, param6:Number, param7:Number, param8:Number)
      {
         super();
         _userIndex = param1;
         _source = param2;
         _target = param3;
         _moveType = param4;
         _animationTime = param5;
         _bodyDirection = param6;
         _headDirection = param7;
         _jumpPower = param8;
      }
      
      public function get userIndex() : int
      {
         return _userIndex;
      }
      
      public function get source() : Vector3d
      {
         return _source;
      }
      
      public function get target() : Vector3d
      {
         return _target;
      }
      
      public function get moveType() : String
      {
         return _moveType;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
      
      public function get bodyDirection() : Number
      {
         return _bodyDirection;
      }
      
      public function get headDirection() : Number
      {
         return _headDirection;
      }
      
      public function get jumpPower() : Number
      {
         return _jumpPower;
      }
   }
}

