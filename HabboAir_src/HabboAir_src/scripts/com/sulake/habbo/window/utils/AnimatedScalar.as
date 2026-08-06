package com.sulake.habbo.window.utils
{
   public class AnimatedScalar
   {
      private static const MAX_INTEGRATION_STEP_MS:Number = 8;
      
      private var UnknownVarFromAnimatedScalar_Number_1:Number;
      
      private var UnknownVarFromAnimatedScalar_Number_2:Number;
      
      private var UnknownVarFromAnimatedScalar_Number_3:Number;
      
      private var _lastUpdateTimeMs:Number = 0;
      
      private var UnknownVarFromAnimatedScalar_Number_4:Number = 0;
      
      private var UnknownVarFromAnimatedScalar_Number_5:Number = 0;
      
      private var _value:Number = 0;
      
      public function AnimatedScalar(param1:Number, param2:Number, param3:Number)
      {
         super();
         UnknownVarFromAnimatedScalar_Number_1 = Math.max(0,param1);
         UnknownVarFromAnimatedScalar_Number_2 = Math.max(0,param2);
         UnknownVarFromAnimatedScalar_Number_3 = Math.max(0,param3);
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function snapTo(param1:Number, param2:Number) : void
      {
         _lastUpdateTimeMs = param2;
         UnknownVarFromAnimatedScalar_Number_4 = 0;
         UnknownVarFromAnimatedScalar_Number_5 = param1;
         _value = param1;
      }
      
      public function setTarget(param1:Number, param2:Number) : void
      {
         update(param2);
         UnknownVarFromAnimatedScalar_Number_5 = param1;
         _lastUpdateTimeMs = param2;
         var _loc3_:Number = resolveDirectionToTarget();
         if(_loc3_ == 0)
         {
            settle();
            return;
         }
         UnknownVarFromAnimatedScalar_Number_4 = _loc3_ * Math.min(Math.abs(UnknownVarFromAnimatedScalar_Number_4),UnknownVarFromAnimatedScalar_Number_2);
      }
      
      public function needsUpdate(param1:Number, param2:Number = 1) : Boolean
      {
         if(param2 > 0 && int(UnknownVarFromAnimatedScalar_Number_5 * param2) != int(_value * param2))
         {
            return true;
         }
         return Math.abs(UnknownVarFromAnimatedScalar_Number_5 - _value) > UnknownVarFromAnimatedScalar_Number_3 || Math.abs(UnknownVarFromAnimatedScalar_Number_4) > UnknownVarFromAnimatedScalar_Number_3;
      }
      
      public function update(param1:Number) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = Math.max(0,param1 - _lastUpdateTimeMs);
         if(_loc2_ <= 0 || isSettled())
         {
            _lastUpdateTimeMs = param1;
            return false;
         }
         var _loc3_:Number = _value;
         while(_loc2_ > 0 && !isSettled())
         {
            _loc4_ = Math.min(_loc2_,8);
            integrateStep(_loc4_);
            _loc2_ -= _loc4_;
         }
         _lastUpdateTimeMs = param1;
         return _value != _loc3_;
      }
      
      private function settle() : Boolean
      {
         var _loc1_:Boolean = _value != UnknownVarFromAnimatedScalar_Number_5 || UnknownVarFromAnimatedScalar_Number_4 != 0;
         _value = UnknownVarFromAnimatedScalar_Number_5;
         UnknownVarFromAnimatedScalar_Number_4 = 0;
         return _loc1_;
      }
      
      private function integrateStep(param1:Number) : void
      {
         var _loc3_:Number = UnknownVarFromAnimatedScalar_Number_5 - _value;
         var _loc6_:Number = sign(_loc3_);
         if(_loc6_ == 0 || Math.abs(_loc3_) <= UnknownVarFromAnimatedScalar_Number_3)
         {
            settle();
            return;
         }
         var _loc2_:Number = resolveAcceleration(_loc6_);
         var _loc5_:Number = _value + UnknownVarFromAnimatedScalar_Number_4 * param1 + 0.5 * _loc2_ * param1 * param1;
         var _loc4_:Number = UnknownVarFromAnimatedScalar_Number_4 + _loc2_ * param1;
         if(sign(UnknownVarFromAnimatedScalar_Number_5 - _loc5_) != _loc6_ || Math.abs(UnknownVarFromAnimatedScalar_Number_5 - _loc5_) <= UnknownVarFromAnimatedScalar_Number_3)
         {
            settle();
            return;
         }
         if(UnknownVarFromAnimatedScalar_Number_2 > 0 && Math.abs(_loc4_) > UnknownVarFromAnimatedScalar_Number_2)
         {
            _loc4_ = sign(_loc4_) * UnknownVarFromAnimatedScalar_Number_2;
         }
         if(UnknownVarFromAnimatedScalar_Number_4 != 0 && sign(_loc4_) != sign(UnknownVarFromAnimatedScalar_Number_4) && sign(_loc2_) != _loc6_)
         {
            _loc4_ = 0;
         }
         _value = _loc5_;
         UnknownVarFromAnimatedScalar_Number_4 = _loc4_;
      }
      
      private function resolveAcceleration(param1:Number) : Number
      {
         if(UnknownVarFromAnimatedScalar_Number_1 <= 0)
         {
            return 0;
         }
         var _loc3_:Number = UnknownVarFromAnimatedScalar_Number_4 * param1;
         if(_loc3_ < 0)
         {
            return param1 * UnknownVarFromAnimatedScalar_Number_1;
         }
         var _loc2_:Number = _loc3_ * _loc3_ / (2 * UnknownVarFromAnimatedScalar_Number_1);
         if(_loc2_ >= Math.abs(UnknownVarFromAnimatedScalar_Number_5 - _value))
         {
            return -param1 * UnknownVarFromAnimatedScalar_Number_1;
         }
         if(UnknownVarFromAnimatedScalar_Number_2 > 0 && _loc3_ >= UnknownVarFromAnimatedScalar_Number_2)
         {
            return 0;
         }
         return param1 * UnknownVarFromAnimatedScalar_Number_1;
      }
      
      private function resolveDirectionToTarget() : Number
      {
         var _loc1_:Number = UnknownVarFromAnimatedScalar_Number_5 - _value;
         return Math.abs(_loc1_) <= UnknownVarFromAnimatedScalar_Number_3 ? 0 : sign(_loc1_);
      }
      
      private function isSettled() : Boolean
      {
         return Math.abs(UnknownVarFromAnimatedScalar_Number_5 - _value) <= UnknownVarFromAnimatedScalar_Number_3 && Math.abs(UnknownVarFromAnimatedScalar_Number_4) <= UnknownVarFromAnimatedScalar_Number_3;
      }
      
      private function sign(param1:Number) : Number
      {
         if(param1 > 0)
         {
            return 1;
         }
         if(param1 < 0)
         {
            return -1;
         }
         return 0;
      }
   }
}

