package com.sulake.habbo.room.object.logic
{
   import com.sulake.habbo.room.events.RoomObjectMoveEvent;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.object.logic.ObjectLogicBase;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.utils.getTimer;
   
   public class MovingObjectLogic extends ObjectLogicBase
   {
      public static const DEFAULT_UPDATE_INTERVAL:int = 500;
      
      private static var helper_vector:Vector3d = new Vector3d();
      
      private var UnknownVarFromMovingObjectLogic_Vector3d_1:Vector3d = new Vector3d();
      
      private var UnknownVarFromMovingObjectLogic_Vector3d_2:Vector3d = new Vector3d();
      
      private var _liftAmount:Number = 0;
      
      private var _lastUpdateTime:int = 0;
      
      private var _changeTime:int;
      
      private var UnknownVarFromMovingObjectLogic_Int_1:int = 500;
      
      private var _overshootTime:int = 0;
      
      private var _curveStrength:int = 0;
      
      public function MovingObjectLogic()
      {
         super();
      }
      
      protected function get lastUpdateTime() : int
      {
         return _lastUpdateTime;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromMovingObjectLogic_Vector3d_2 = null;
         UnknownVarFromMovingObjectLogic_Vector3d_1 = null;
      }
      
      override public function set object(param1:IRoomObjectController) : void
      {
         super.object = param1;
         if(param1 != null)
         {
            UnknownVarFromMovingObjectLogic_Vector3d_2.assign(param1.getLocation());
         }
      }
      
      protected function setMoveUpdateInterval(param1:int, param2:int = 0, param3:int = 0) : void
      {
         if(param1 <= 0)
         {
            param1 = 1;
         }
         UnknownVarFromMovingObjectLogic_Int_1 = param1;
         if(!isNaN(param2) && param2 == 0)
         {
            param2 = NaN;
         }
         _overshootTime = param2;
         if(!isNaN(param3) && param3 == 0)
         {
            _curveStrength = NaN;
         }
         _curveStrength = param3;
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc4_:IVector3d = null;
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         super.processUpdateMessage(param1);
         var _loc3_:RoomObjectMoveUpdateMessage = param1 as RoomObjectMoveUpdateMessage;
         if(_loc3_ != null && _loc3_.skipPositionUpdate)
         {
            return;
         }
         if(param1.loc != null)
         {
            UnknownVarFromMovingObjectLogic_Vector3d_2.assign(param1.loc);
         }
         if(param1.loc != null)
         {
            UnknownVarFromMovingObjectLogic_Vector3d_1.x = 0;
            UnknownVarFromMovingObjectLogic_Vector3d_1.y = 0;
            UnknownVarFromMovingObjectLogic_Vector3d_1.z = 0;
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(object != null)
         {
            if(param1.loc != null)
            {
               _loc4_ = _loc3_.targetLoc;
               _loc2_ = int(isNaN(_loc3_.animationTime) ? 500 : _loc3_.animationTime);
               setMoveUpdateInterval(_loc2_,_loc3_.overshootAnimationTime,getCurveStrength(_loc3_));
               _changeTime = _lastUpdateTime > 0 ? _lastUpdateTime : getTimer();
               UnknownVarFromMovingObjectLogic_Vector3d_1.assign(_loc4_);
               UnknownVarFromMovingObjectLogic_Vector3d_1.sub(UnknownVarFromMovingObjectLogic_Vector3d_2);
               fixDeltaAndIntervalForOvershooting();
            }
         }
      }
      
      protected function getCurveStrength(param1:RoomObjectMoveUpdateMessage) : int
      {
         return param1.curveStrength;
      }
      
      protected function getLocationOffset() : IVector3d
      {
         return null;
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROME_SLIDE_ANIMATION"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function update(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Number = NaN;
         var _loc6_:RoomObjectEvent = null;
         var _loc2_:IVector3d = getLocationOffset();
         var _loc5_:IRoomObjectModelController = object.getModelController();
         if(_loc5_ != null)
         {
            if(_loc2_ != null)
            {
               if(_liftAmount != _loc2_.z)
               {
                  _liftAmount = _loc2_.z;
                  _loc5_.setNumber("furniture_lift_amount",_liftAmount);
               }
            }
            else if(_liftAmount != 0)
            {
               _liftAmount = 0;
               _loc5_.setNumber("furniture_lift_amount",_liftAmount);
            }
         }
         if(UnknownVarFromMovingObjectLogic_Vector3d_1.length > 0 || _loc2_ != null)
         {
            _loc4_ = param1 - _changeTime;
            if(_loc4_ == UnknownVarFromMovingObjectLogic_Int_1 >> 1)
            {
               _loc4_++;
            }
            if(_loc4_ > UnknownVarFromMovingObjectLogic_Int_1)
            {
               _loc4_ = UnknownVarFromMovingObjectLogic_Int_1;
            }
            if(UnknownVarFromMovingObjectLogic_Vector3d_1.length > 0)
            {
               helper_vector.assign(UnknownVarFromMovingObjectLogic_Vector3d_1);
               helper_vector.mul(_loc4_ / UnknownVarFromMovingObjectLogic_Int_1);
               helper_vector.add(UnknownVarFromMovingObjectLogic_Vector3d_2);
            }
            else
            {
               helper_vector.assign(UnknownVarFromMovingObjectLogic_Vector3d_2);
            }
            if(_loc2_ != null)
            {
               helper_vector.add(_loc2_);
            }
            if(!isNaN(_curveStrength) && _curveStrength != 0)
            {
               _loc3_ = calculateCurveOffset(_loc4_,UnknownVarFromMovingObjectLogic_Int_1);
               helper_vector.z += _loc3_;
            }
            if(object != null)
            {
               object.setLocation(helper_vector);
            }
            if(_loc4_ == UnknownVarFromMovingObjectLogic_Int_1)
            {
               UnknownVarFromMovingObjectLogic_Vector3d_1.x = 0;
               UnknownVarFromMovingObjectLogic_Vector3d_1.y = 0;
               UnknownVarFromMovingObjectLogic_Vector3d_1.z = 0;
            }
            _loc6_ = new RoomObjectMoveEvent("ROME_SLIDE_ANIMATION",object);
            eventDispatcher.dispatchEvent(_loc6_);
         }
         _lastUpdateTime = param1;
      }
      
      private function calculateCurveOffset(param1:int, param2:int) : Number
      {
         if(isNaN(_curveStrength) || _curveStrength == 0)
         {
            return 0;
         }
         return 4 * (_curveStrength / 100 * (UnknownVarFromMovingObjectLogic_Vector3d_1.length / 4) / (param2 * param2)) * param1 * (param2 - param1);
      }
      
      private function fixDeltaAndIntervalForOvershooting() : void
      {
         var _loc1_:Number = NaN;
         if(!isNaN(_overshootTime) && _overshootTime != 0 && UnknownVarFromMovingObjectLogic_Int_1 != 0)
         {
            _loc1_ = UnknownVarFromMovingObjectLogic_Vector3d_1.z;
            UnknownVarFromMovingObjectLogic_Vector3d_1.mul((UnknownVarFromMovingObjectLogic_Int_1 + _overshootTime) / UnknownVarFromMovingObjectLogic_Int_1);
            UnknownVarFromMovingObjectLogic_Vector3d_1.z = _loc1_;
            UnknownVarFromMovingObjectLogic_Int_1 += _overshootTime;
         }
      }
   }
}

