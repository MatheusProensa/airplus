package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class WiredFurniMoveMessageData
   {
      private var _furniId:int;
      
      private var _source:Vector3d;
      
      private var _target:Vector3d;
      
      private var _animationTime:Number;
      
      private var _rotation:Number;
      
      private var _overshootingDistance:Number;
      
      private var _curveStrength:Number;
      
      public function WiredFurniMoveMessageData(param1:int, param2:Vector3d, param3:Vector3d, param4:Number, param5:Number, param6:Number, param7:Number)
      {
         super();
         _furniId = param1;
         _source = param2;
         _target = param3;
         _animationTime = param4;
         _rotation = param5;
         _overshootingDistance = param6;
         _curveStrength = param7;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get source() : Vector3d
      {
         return _source;
      }
      
      public function get target() : Vector3d
      {
         return _target;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
      
      public function get rotation() : Number
      {
         return _rotation;
      }
      
      public function get overshootingDistance() : Number
      {
         return _overshootingDistance;
      }
      
      public function get curveStrength() : Number
      {
         return _curveStrength;
      }
   }
}

