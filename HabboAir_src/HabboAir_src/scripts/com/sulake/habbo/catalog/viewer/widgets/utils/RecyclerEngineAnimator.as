package com.sulake.habbo.catalog.viewer.widgets.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RecyclerEngineAnimator implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromRecyclerEngineAnimator_Int_1:int = -88;
      
      private static const MAX_ANGLE:int = 88;
      
      private static const UnknownConstFromRecyclerEngineAnimator_Int_2:int = 82;
      
      private static const UnknownConstFromRecyclerEngineAnimator_Int_3:int = 68;
      
      private static const ANGLE_BUFFER:int = 5;
      
      private static const UnknownConstFromRecyclerEngineAnimator_Number_1:Number = 0.00008;
      
      private static const BASE_BIAS:Number = 0.35;
      
      private static const FIRST_BIAS:Number = 0.2;
      
      private static const UnknownConstFromRecyclerEngineAnimator_Int_4:int = 16;
      
      private static const RESET_TIME:int = 250;
      
      private static const SHAKE_TIMEOUT:int = 50;
      
      private static const SHAKE_PIXELS:int = 3;
      
      private static const MIN_TIME_ACTIVE:Number = 3000;
      
      private static const SHAKE_PIXELS_E:int = 24;
      
      private static const STEP_SIZE_E:int = 70;
      
      private static const STEP_DURATION_E:int = 20;
      
      private static const TOTAL_DURATION_E:int = 5000;
      
      private static const STEP_DURATION_MIN:int = 400;
      
      private static const STEP_DURATION_MAX:int = 200;
      
      private static const STEP_SIZE_MIN:int = 20;
      
      private static const STEP_SIZE_MAX:int = 55;
      
      private var _arrow:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromRecyclerEngineAnimator_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var _onFinish:Function;
      
      private var _startTime:int;
      
      private var _stepBeginTime:int;
      
      private var UnknownVarFromRecyclerEngineAnimator_Int_1:int;
      
      private var UnknownVarFromRecyclerEngineAnimator_Int_2:int;
      
      private var _animationTime:int;
      
      private var _shakeLastTime:int;
      
      private var UnknownVarFromRecyclerEngineAnimator_Timer_1:Timer;
      
      private var UnknownVarFromRecyclerEngineAnimator_Boolean_1:Boolean = false;
      
      private var UnknownVarFromRecyclerEngineAnimator_Int_3:int;
      
      private var UnknownVarFromRecyclerEngineAnimator_Int_4:int;
      
      private var _easterEggMode:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function RecyclerEngineAnimator(param1:IStaticBitmapWrapperWindow, param2:IStaticBitmapWrapperWindow, param3:Function)
      {
         super();
         _arrow = param1;
         UnknownVarFromRecyclerEngineAnimator_IStaticBitmapWrapperWindow_1 = param2;
         UnknownVarFromRecyclerEngineAnimator_Int_3 = param2.x;
         UnknownVarFromRecyclerEngineAnimator_Int_4 = param2.y;
         _onFinish = param3;
         setRotation(0);
      }
      
      private static function rand(param1:int, param2:int) : int
      {
         return param1 + Math.random() * (param2 - param1);
      }
      
      public function start(param1:Boolean = false) : void
      {
         stopTimer();
         UnknownVarFromRecyclerEngineAnimator_Boolean_1 = false;
         _easterEggMode = param1;
         _startTime = getTimer();
         setRotation(0);
         setShake(0,0);
         nextStep(false,true);
         startTimer();
      }
      
      public function stop() : void
      {
         stopTimer();
         setShake(0,0);
         UnknownVarFromRecyclerEngineAnimator_Boolean_1 = false;
      }
      
      public function reset() : void
      {
         stopTimer();
         UnknownVarFromRecyclerEngineAnimator_Boolean_1 = true;
         UnknownVarFromRecyclerEngineAnimator_Int_1 = _arrow.rotation;
         setRotation(UnknownVarFromRecyclerEngineAnimator_Int_1 % 360);
         UnknownVarFromRecyclerEngineAnimator_Int_2 = 0;
         _stepBeginTime = getTimer();
         _animationTime = 250;
         setShake(0,0);
         startTimer();
      }
      
      private function startTimer() : void
      {
         UnknownVarFromRecyclerEngineAnimator_Timer_1 = new Timer(16);
         UnknownVarFromRecyclerEngineAnimator_Timer_1.addEventListener("timer",onTimerTick);
         UnknownVarFromRecyclerEngineAnimator_Timer_1.start();
      }
      
      private function stopTimer() : void
      {
         if(UnknownVarFromRecyclerEngineAnimator_Timer_1)
         {
            UnknownVarFromRecyclerEngineAnimator_Timer_1.stop();
            UnknownVarFromRecyclerEngineAnimator_Timer_1.removeEventListener("timer",onTimerTick);
            UnknownVarFromRecyclerEngineAnimator_Timer_1 = null;
         }
      }
      
      private function setRotation(param1:int) : void
      {
         _arrow.rotation = param1;
         _arrow.invalidate();
      }
      
      private function setShake(param1:int, param2:int) : void
      {
         UnknownVarFromRecyclerEngineAnimator_IStaticBitmapWrapperWindow_1.x = UnknownVarFromRecyclerEngineAnimator_Int_3 + param1;
         UnknownVarFromRecyclerEngineAnimator_IStaticBitmapWrapperWindow_1.y = UnknownVarFromRecyclerEngineAnimator_Int_4 + param2;
      }
      
      private function onTimerTick(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = getTimer();
         var _loc6_:int = _loc2_ - _stepBeginTime;
         var _loc5_:Number = Math.max(0,Math.min(1,_loc6_ / _animationTime));
         var _loc4_:int = (UnknownVarFromRecyclerEngineAnimator_Int_2 - UnknownVarFromRecyclerEngineAnimator_Int_1) * _loc5_ + UnknownVarFromRecyclerEngineAnimator_Int_1;
         setRotation(_loc4_);
         if(isBusy() && _loc2_ > _shakeLastTime + 50)
         {
            _shakeLastTime = _loc2_;
            _loc3_ = _easterEggMode ? 24 : 3;
            setShake(rand(-_loc3_,_loc3_),rand(-_loc3_,_loc3_));
         }
         if(_loc6_ >= _animationTime)
         {
            if(UnknownVarFromRecyclerEngineAnimator_Boolean_1)
            {
               stopTimer();
               UnknownVarFromRecyclerEngineAnimator_Boolean_1 = false;
            }
            else if(_loc4_ >= 82 && !_easterEggMode && _loc2_ - _startTime > 3000 || _easterEggMode && _loc2_ - _startTime > 5000)
            {
               stopTimer();
               setShake(0,0);
               _onFinish();
            }
            else
            {
               nextStep(_loc4_ >= 68 && _loc2_ - _startTime > 3000 - 300 && !_easterEggMode);
            }
         }
      }
      
      private function nextStep(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = false;
         var _loc6_:Number = NaN;
         var _loc5_:int = 0;
         UnknownVarFromRecyclerEngineAnimator_Int_1 = _arrow.rotation;
         _stepBeginTime = getTimer();
         if(param1)
         {
            UnknownVarFromRecyclerEngineAnimator_Int_2 = 88;
         }
         else if(_easterEggMode)
         {
            UnknownVarFromRecyclerEngineAnimator_Int_2 = UnknownVarFromRecyclerEngineAnimator_Int_1 - 70;
         }
         else
         {
            _loc4_ = getTimer() - _startTime;
            if(UnknownVarFromRecyclerEngineAnimator_Int_1 <= -88 + 5)
            {
               _loc3_ = false;
            }
            else if(UnknownVarFromRecyclerEngineAnimator_Int_1 >= 88 - 5)
            {
               _loc3_ = true;
            }
            else
            {
               _loc6_ = param2 ? 0.2 : 0.35 + _loc4_ * 0.00008;
               _loc3_ = Math.random() > _loc6_;
            }
            _loc5_ = (_loc3_ ? -1 : 1) * rand(20,55);
            UnknownVarFromRecyclerEngineAnimator_Int_2 = Math.max(-88,Math.min(88,UnknownVarFromRecyclerEngineAnimator_Int_1 + _loc5_));
         }
         _animationTime = _easterEggMode ? 20 : rand(400,200);
      }
      
      public function isBusy() : Boolean
      {
         return UnknownVarFromRecyclerEngineAnimator_Timer_1 != null && !UnknownVarFromRecyclerEngineAnimator_Boolean_1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         stopTimer();
         _arrow = null;
         _onFinish = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

