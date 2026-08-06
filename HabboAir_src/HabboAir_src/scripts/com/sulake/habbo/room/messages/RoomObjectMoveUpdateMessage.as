package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectMoveUpdateMessage extends RoomObjectUpdateMessage
   {
      private var _realTargetLoc:IVector3d;
      
      private var _isSlideUpdate:Boolean;
      
      private var _animationTime:Number;
      
      private var _skipPositionUpdate:Boolean;
      
      private var _overshootAnimationTime:Number;
      
      private var _curveStrength:Number;
      
      public function RoomObjectMoveUpdateMessage(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:Number = NaN, param5:Boolean = false, param6:Boolean = false, param7:Number = NaN, param8:Number = NaN)
      {
         super(param1,param3);
         _isSlideUpdate = param5;
         _realTargetLoc = param2;
         _animationTime = param4;
         _skipPositionUpdate = param6;
         _overshootAnimationTime = param7;
         _curveStrength = param8;
      }
      
      public function get targetLoc() : IVector3d
      {
         if(_realTargetLoc == null)
         {
            return loc;
         }
         return _realTargetLoc;
      }
      
      public function get realTargetLoc() : IVector3d
      {
         return _realTargetLoc;
      }
      
      public function get isSlideUpdate() : Boolean
      {
         return _isSlideUpdate;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
      
      public function get skipPositionUpdate() : Boolean
      {
         return _skipPositionUpdate;
      }
      
      public function get overshootAnimationTime() : Number
      {
         return _overshootAnimationTime;
      }
      
      public function get curveStrength() : Number
      {
         return _curveStrength;
      }
   }
}

