package com.sulake.habbo.utils.animation
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DelayedCall extends EventDispatcher implements IDelayedCall
   {
      private static var UnknownVarFromDelayedCall_Vector_1:Vector.<DelayedCall> = new Vector.<DelayedCall>(0);
      
      private var mCurrentTime:Number;
      
      private var mTotalTime:Number;
      
      private var mCall:Function;
      
      private var UnknownVarFromDelayedCall_Array_1:Array;
      
      private var _repeatCount:int;
      
      public function DelayedCall(param1:Function, param2:Number, param3:Array = null)
      {
         super();
         reset(param1,param2,param3);
      }
      
      internal static function fromPool(param1:Function, param2:Number, param3:Array = null) : DelayedCall
      {
         if(UnknownVarFromDelayedCall_Vector_1.length)
         {
            return UnknownVarFromDelayedCall_Vector_1.pop().reset(param1,param2,param3);
         }
         return new DelayedCall(param1,param2,param3);
      }
      
      internal static function toPool(param1:DelayedCall) : void
      {
         param1.mCall = null;
         param1.UnknownVarFromDelayedCall_Array_1 = null;
         param1.removeEventListeners();
         UnknownVarFromDelayedCall_Vector_1.push(param1);
      }
      
      public function reset(param1:Function, param2:Number, param3:Array = null) : DelayedCall
      {
         mCurrentTime = 0;
         mTotalTime = Math.max(param2,0.0001);
         mCall = param1;
         UnknownVarFromDelayedCall_Array_1 = param3;
         _repeatCount = 1;
         return this;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Array = null;
         var _loc4_:Number = mCurrentTime;
         mCurrentTime += param1;
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(_loc4_ < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(_repeatCount == 0 || _repeatCount > 1)
            {
               mCall.apply(null,UnknownVarFromDelayedCall_Array_1);
               if(_repeatCount > 0)
               {
                  _repeatCount -= 1;
               }
               mCurrentTime = 0;
               advanceTime(_loc4_ + param1 - mTotalTime);
            }
            else
            {
               _loc2_ = mCall;
               _loc3_ = UnknownVarFromDelayedCall_Array_1;
               dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
               _loc2_.apply(null,_loc3_);
            }
         }
      }
      
      public function complete() : void
      {
         var _loc1_:Number = mTotalTime - mCurrentTime;
         if(_loc1_ > 0)
         {
            advanceTime(_loc1_);
         }
      }
      
      public function get isComplete() : Boolean
      {
         return _repeatCount == 1 && mCurrentTime >= mTotalTime;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get repeatCount() : int
      {
         return _repeatCount;
      }
      
      public function set repeatCount(param1:int) : void
      {
         _repeatCount = param1;
      }
      
      private function removeEventListeners() : void
      {
      }
   }
}

