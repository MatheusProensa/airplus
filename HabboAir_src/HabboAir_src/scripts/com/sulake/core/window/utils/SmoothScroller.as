package com.sulake.core.window.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class SmoothScroller
   {
      public static const DEFAULT_SCROLL_STEP:Number = 25;
      
      private static const DEFAULT_MAX_DURATION_MS:Number = 200;
      
      private static const INVERSE_DELTA_RAMP_START_PX:Number = 120;
      
      private static const INVERSE_DELTA_RAMP_END_PX:Number = 480;
      
      private static const INVERSE_DELTA_MIN_DURATION_SCALE:Number = 0.5;
      
      private static const VELOCITY_BOUND_FUDGE:Number = 2.5;
      
      private static const UnknownConstFromSmoothScroller_Number_1:Number = 0.01;
      
      private static const CURVE_X1:Number = 0.42;
      
      private static const CURVE_X2:Number = 0.58;
      
      private static const CURVE_Y2:Number = 1;
      
      private static const MAX_SLOPE:Number = 1000;
      
      private static const NEWTON_ITERATIONS:int = 4;
      
      private static const BINARY_SEARCH_ITERATIONS:int = 8;
      
      private var UnknownVarFromSmoothScroller_Function_1:Function;
      
      private var UnknownVarFromSmoothScroller_Function_2:Function;
      
      private var UnknownVarFromSmoothScroller_Function_3:Function;
      
      private var UnknownVarFromSmoothScroller_Function_4:Function;
      
      private var UnknownVarFromSmoothScroller_Number_1:Number = 25;
      
      private var _duration:Number = 200;
      
      private var UnknownVarFromSmoothScroller_Number_2:Number = 100;
      
      private var UnknownVarFromSmoothScroller_Boolean_1:Boolean = true;
      
      private var UnknownVarFromSmoothScroller_Boolean_2:Boolean = true;
      
      private var UnknownVarFromSmoothScroller_Timer_1:Timer;
      
      private var UnknownVarFromSmoothScroller_Number_3:Number = 16.666666666666668;
      
      private var UnknownVarFromSmoothScroller_Number_4:Number = 0;
      
      private var UnknownVarFromSmoothScroller_Number_5:Number = 0;
      
      private var UnknownVarFromSmoothScroller_Number_6:Number = 0;
      
      private var UnknownVarFromSmoothScroller_Number_7:Number = 0;
      
      private var _curveControlY1:Number = 0;
      
      public function SmoothScroller(param1:Function, param2:Function, param3:Function, param4:Number = 200, param5:int = 60, param6:Boolean = true, param7:Function = null, param8:Number = NaN, param9:Boolean = true)
      {
         super();
         if(!isNaN(param8))
         {
            UnknownVarFromSmoothScroller_Number_1 = param8;
         }
         duration = param4;
         UnknownVarFromSmoothScroller_Boolean_1 = param6;
         UnknownVarFromSmoothScroller_Boolean_2 = param9;
         UnknownVarFromSmoothScroller_Function_4 = param7;
         UnknownVarFromSmoothScroller_Function_1 = param1;
         UnknownVarFromSmoothScroller_Function_2 = param2;
         UnknownVarFromSmoothScroller_Function_3 = param3;
         UnknownVarFromSmoothScroller_Timer_1 = new Timer(UnknownVarFromSmoothScroller_Number_3 = int(1000 / param5));
         UnknownVarFromSmoothScroller_Timer_1.addEventListener("timer",updateScrolling);
      }
      
      private static function getBezierValue(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         param1 = clamp(param1,0,1);
         var _loc6_:Number = solveCurveTForX(param1,param2,param4);
         return sampleCurve(_loc6_,param3,param5);
      }
      
      private static function getBezierSlope(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         param1 = clamp(param1,0,1);
         var _loc6_:Number = solveCurveTForX(param1,param2,param4);
         var _loc7_:Number = sampleCurveDerivative(_loc6_,param2,param4);
         if(Math.abs(_loc7_) < 0.01)
         {
            return 0;
         }
         var _loc8_:Number = sampleCurveDerivative(_loc6_,param3,param5);
         return _loc8_ / _loc7_;
      }
      
      private static function solveCurveTForX(param1:Number, param2:Number, param3:Number) : Number
      {
         var _loc9_:int = 0;
         var _loc6_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = param1;
         _loc9_ = 0;
         while(_loc9_ < 4)
         {
            _loc6_ = sampleCurve(_loc5_,param2,param3) - param1;
            if(Math.abs(_loc6_) < 0.01)
            {
               return _loc5_;
            }
            _loc4_ = sampleCurveDerivative(_loc5_,param2,param3);
            if(Math.abs(_loc4_) < 0.01)
            {
               break;
            }
            _loc5_ -= _loc6_ / _loc4_;
            _loc9_++;
         }
         var _loc7_:* = 0;
         var _loc8_:* = 1;
         _loc5_ = param1;
         _loc9_ = 0;
         while(_loc9_ < 8)
         {
            _loc6_ = sampleCurve(_loc5_,param2,param3);
            if(Math.abs(_loc6_ - param1) < 0.01)
            {
               return _loc5_;
            }
            if(_loc6_ > param1)
            {
               _loc8_ = _loc5_;
            }
            else
            {
               _loc7_ = _loc5_;
            }
            _loc5_ = (_loc8_ + _loc7_) * 0.5;
            _loc9_++;
         }
         return _loc5_;
      }
      
      private static function sampleCurve(param1:Number, param2:Number, param3:Number) : Number
      {
         return ((getCurveA(param2,param3) * param1 + getCurveB(param2,param3)) * param1 + getCurveC(param2)) * param1;
      }
      
      private static function sampleCurveDerivative(param1:Number, param2:Number, param3:Number) : Number
      {
         return 3 * getCurveA(param2,param3) * param1 * param1 + 2 * getCurveB(param2,param3) * param1 + getCurveC(param2);
      }
      
      private static function getCurveA(param1:Number, param2:Number) : Number
      {
         return 1 - 3 * param2 + 3 * param1;
      }
      
      private static function getCurveB(param1:Number, param2:Number) : Number
      {
         return 3 * param2 - 6 * param1;
      }
      
      private static function getCurveC(param1:Number) : Number
      {
         return 3 * param1;
      }
      
      private static function clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public function dispose() : void
      {
         stop();
         if(UnknownVarFromSmoothScroller_Timer_1 != null)
         {
            UnknownVarFromSmoothScroller_Timer_1.removeEventListener("timer",updateScrolling);
            UnknownVarFromSmoothScroller_Timer_1 = null;
         }
         UnknownVarFromSmoothScroller_Function_1 = null;
         UnknownVarFromSmoothScroller_Function_2 = null;
         UnknownVarFromSmoothScroller_Function_3 = null;
         UnknownVarFromSmoothScroller_Function_4 = null;
      }
      
      public function get duration() : Number
      {
         return _duration;
      }
      
      public function set duration(param1:Number) : void
      {
         if(!isFinite(param1) || param1 <= 0)
         {
            param1 = 200;
         }
         _duration = param1;
         UnknownVarFromSmoothScroller_Number_2 = param1 * 0.5;
      }
      
      public function get isScrolling() : Boolean
      {
         return UnknownVarFromSmoothScroller_Timer_1 != null && UnknownVarFromSmoothScroller_Timer_1.running;
      }
      
      public function adjustStartPosition(param1:Number) : void
      {
         if(!isScrolling || !isFinite(param1) || param1 == 0)
         {
            return;
         }
         UnknownVarFromSmoothScroller_Number_4 = clampPosition(UnknownVarFromSmoothScroller_Number_4 + param1);
         UnknownVarFromSmoothScroller_Number_5 = clampPosition(UnknownVarFromSmoothScroller_Number_5 + param1);
      }
      
      public function scrollWithWheel(param1:Number) : Boolean
      {
         return scrollBySteps(param1);
      }
      
      public function scrollBySteps(param1:Number) : Boolean
      {
         if(!isFinite(param1) || param1 == 0)
         {
            return false;
         }
         var _loc6_:Number = getMaxScroll();
         if(UnknownVarFromSmoothScroller_Boolean_1 && (!isFinite(_loc6_) || _loc6_ <= 0))
         {
            stop();
            return false;
         }
         var _loc2_:Number = wheelDeltaToScrollDelta(param1,_loc6_);
         if(!isFinite(_loc2_) || _loc2_ == 0)
         {
            return false;
         }
         var _loc4_:Number = getTimer();
         var _loc3_:Number = getPosition();
         var _loc5_:Number = clampPosition((isScrolling ? UnknownVarFromSmoothScroller_Number_5 : _loc3_) + _loc2_);
         if(Math.abs(_loc5_ - _loc3_) < 0.01 && (!isScrolling || Math.abs(_loc5_ - UnknownVarFromSmoothScroller_Number_5) < 0.01))
         {
            if(_loc5_ != _loc3_)
            {
               setPosition(_loc5_);
               stop();
               return true;
            }
            stop();
            return false;
         }
         if(isScrolling)
         {
            updateTarget(_loc4_,_loc5_);
         }
         else
         {
            startAnimation(_loc4_,_loc3_,_loc5_);
         }
         if(UnknownVarFromSmoothScroller_Number_7 <= UnknownVarFromSmoothScroller_Number_6)
         {
            complete();
            return false;
         }
         UnknownVarFromSmoothScroller_Timer_1.reset();
         UnknownVarFromSmoothScroller_Timer_1.start();
         applyPositionAt(_loc4_ + UnknownVarFromSmoothScroller_Number_3);
         return true;
      }
      
      public function stop() : void
      {
         stopInternal(false);
      }
      
      public function complete() : void
      {
         if(UnknownVarFromSmoothScroller_Number_7 > UnknownVarFromSmoothScroller_Number_6)
         {
            setPosition(clampPosition(UnknownVarFromSmoothScroller_Number_5));
         }
         stopInternal(true);
      }
      
      private function stopInternal(param1:Boolean) : void
      {
         if(UnknownVarFromSmoothScroller_Timer_1 == null)
         {
            return;
         }
         var _loc2_:Boolean = UnknownVarFromSmoothScroller_Timer_1.running;
         UnknownVarFromSmoothScroller_Timer_1.reset();
         UnknownVarFromSmoothScroller_Number_6 = 0;
         UnknownVarFromSmoothScroller_Number_7 = 0;
         UnknownVarFromSmoothScroller_Number_4 = 0;
         UnknownVarFromSmoothScroller_Number_5 = 0;
         _curveControlY1 = 0;
         if(param1 && _loc2_ && UnknownVarFromSmoothScroller_Function_4 != null)
         {
            UnknownVarFromSmoothScroller_Function_4();
         }
      }
      
      private function startAnimation(param1:Number, param2:Number, param3:Number) : void
      {
         UnknownVarFromSmoothScroller_Number_4 = clampPosition(param2);
         UnknownVarFromSmoothScroller_Number_5 = clampPosition(param3);
         _curveControlY1 = 0;
         UnknownVarFromSmoothScroller_Number_6 = param1;
         UnknownVarFromSmoothScroller_Number_7 = param1 + getInverseDeltaDurationMs(UnknownVarFromSmoothScroller_Number_5 - UnknownVarFromSmoothScroller_Number_4);
      }
      
      private function updateTarget(param1:Number, param2:Number) : void
      {
         param2 = clampPosition(param2);
         if(Math.abs(UnknownVarFromSmoothScroller_Number_5 - param2) < 0.01)
         {
            UnknownVarFromSmoothScroller_Number_5 = param2;
            return;
         }
         var _loc4_:Number = getValueAt(param1);
         var _loc7_:Number = param2 - _loc4_;
         if(Math.abs(_loc7_) < 0.01)
         {
            UnknownVarFromSmoothScroller_Number_4 = _loc4_;
            UnknownVarFromSmoothScroller_Number_5 = param2;
            UnknownVarFromSmoothScroller_Number_6 = param1;
            UnknownVarFromSmoothScroller_Number_7 = param1;
            return;
         }
         if(UnknownVarFromSmoothScroller_Number_7 - UnknownVarFromSmoothScroller_Number_6 <= 0.01)
         {
            startAnimation(param1,_loc4_,param2);
            return;
         }
         var _loc5_:Number = calculateVelocity(param1);
         var _loc3_:Number = getBoundedDurationMs(_loc7_,_loc5_);
         if(!isFinite(_loc3_) || _loc3_ < 0.01)
         {
            UnknownVarFromSmoothScroller_Number_4 = _loc4_;
            UnknownVarFromSmoothScroller_Number_5 = param2;
            UnknownVarFromSmoothScroller_Number_6 = param1;
            UnknownVarFromSmoothScroller_Number_7 = param1;
            return;
         }
         var _loc6_:Number = _loc5_ * (_loc3_ / _loc7_);
         _loc6_ = clamp(_loc6_,-1000,1000);
         _curveControlY1 = _loc6_ * 0.42;
         UnknownVarFromSmoothScroller_Number_4 = _loc4_;
         UnknownVarFromSmoothScroller_Number_5 = param2;
         UnknownVarFromSmoothScroller_Number_6 = param1;
         UnknownVarFromSmoothScroller_Number_7 = param1 + _loc3_;
      }
      
      private function updateScrolling(param1:TimerEvent) : void
      {
         applyPositionAt(getTimer());
      }
      
      private function applyPositionAt(param1:Number) : void
      {
         setPosition(getValueAt(param1));
         if(param1 >= UnknownVarFromSmoothScroller_Number_7 || UnknownVarFromSmoothScroller_Number_7 - UnknownVarFromSmoothScroller_Number_6 <= 0.01)
         {
            complete();
         }
      }
      
      private function wheelDeltaToScrollDelta(param1:Number, param2:Number) : Number
      {
         if(UnknownVarFromSmoothScroller_Boolean_1)
         {
            return -param1 * UnknownVarFromSmoothScroller_Number_1 / param2;
         }
         return -param1 * UnknownVarFromSmoothScroller_Number_1;
      }
      
      private function getInverseDeltaDurationMs(param1:Number) : Number
      {
         var _loc3_:Number = Math.abs(param1);
         var _loc2_:Number = _duration;
         if(_loc3_ > 120)
         {
            _loc2_ += (_loc3_ - 120) * (UnknownVarFromSmoothScroller_Number_2 - _duration) / (480 - 120);
         }
         return clamp(_loc2_,UnknownVarFromSmoothScroller_Number_2,_duration);
      }
      
      private function getBoundedDurationMs(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = getInverseDeltaDurationMs(param1);
         var _loc4_:Number = getVelocityBasedDurationBoundMs(param1,param2);
         return Math.min(_loc3_,_loc4_);
      }
      
      private function getVelocityBasedDurationBoundMs(param1:Number, param2:Number) : Number
      {
         if(Math.abs(param1) < 0.01)
         {
            return 0;
         }
         if(Math.abs(param2) < 0.01)
         {
            return 1.7976931348623157e+308;
         }
         var _loc3_:Number = param1 / param2 * 2.5;
         return _loc3_ < 0 ? 1.7976931348623157e+308 : _loc3_;
      }
      
      private function getValueAt(param1:Number) : Number
      {
         var _loc4_:Number = UnknownVarFromSmoothScroller_Number_7 - UnknownVarFromSmoothScroller_Number_6;
         if(_loc4_ <= 0.01 || param1 >= UnknownVarFromSmoothScroller_Number_7)
         {
            return UnknownVarFromSmoothScroller_Number_5;
         }
         if(param1 <= UnknownVarFromSmoothScroller_Number_6)
         {
            return UnknownVarFromSmoothScroller_Number_4;
         }
         var _loc3_:Number = (param1 - UnknownVarFromSmoothScroller_Number_6) / _loc4_;
         var _loc2_:Number = getBezierValue(_loc3_,0.42,_curveControlY1,0.58,1);
         return UnknownVarFromSmoothScroller_Number_4 + (UnknownVarFromSmoothScroller_Number_5 - UnknownVarFromSmoothScroller_Number_4) * _loc2_;
      }
      
      private function calculateVelocity(param1:Number) : Number
      {
         var _loc4_:Number = UnknownVarFromSmoothScroller_Number_7 - UnknownVarFromSmoothScroller_Number_6;
         if(_loc4_ <= 0.01)
         {
            return 0;
         }
         var _loc2_:Number = clamp((param1 - UnknownVarFromSmoothScroller_Number_6) / _loc4_,0,1);
         var _loc3_:Number = getBezierSlope(_loc2_,0.42,_curveControlY1,0.58,1);
         return _loc3_ * ((UnknownVarFromSmoothScroller_Number_5 - UnknownVarFromSmoothScroller_Number_4) / _loc4_);
      }
      
      private function getPosition() : Number
      {
         return UnknownVarFromSmoothScroller_Function_1();
      }
      
      private function setPosition(param1:Number) : void
      {
         UnknownVarFromSmoothScroller_Function_2(param1);
      }
      
      private function getMaxScroll() : Number
      {
         return UnknownVarFromSmoothScroller_Function_3();
      }
      
      private function clampPosition(param1:Number) : Number
      {
         if(!UnknownVarFromSmoothScroller_Boolean_2 || !isFinite(param1))
         {
            return param1;
         }
         var _loc2_:Number = getMaxPosition();
         if(!isFinite(_loc2_))
         {
            return param1;
         }
         return clamp(param1,0,_loc2_);
      }
      
      private function getMaxPosition() : Number
      {
         if(UnknownVarFromSmoothScroller_Boolean_1)
         {
            return 1;
         }
         var _loc1_:Number = getMaxScroll();
         if(!isFinite(_loc1_) || _loc1_ < 0)
         {
            return NaN;
         }
         return _loc1_;
      }
   }
}

