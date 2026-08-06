package com.sulake.habbo.utils.animation
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Tween extends EventDispatcher implements IDelayedCall
   {
      private static const HINT_MARKER:String = "#";
      
      private static var UnknownVarFromTween_Vector_1:Vector.<Tween> = new Vector.<Tween>(0);
      
      private var _target:Object;
      
      private var _transitionFunc:Function;
      
      private var mTransitionName:String;
      
      private var mProperties:Vector.<String>;
      
      private var mStartValues:Vector.<Number>;
      
      private var mEndValues:Vector.<Number>;
      
      private var UnknownVarFromTween_Vector_2:Vector.<Function>;
      
      private var _onStart:Function;
      
      private var mOnUpdate:Function;
      
      private var _onRepeat:Function;
      
      private var _onComplete:Function;
      
      private var _onStartArgs:Array;
      
      private var _onUpdateArgs:Array;
      
      private var _onRepeatArgs:Array;
      
      private var _onCompleteArgs:Array;
      
      private var mTotalTime:Number;
      
      private var mCurrentTime:Number;
      
      private var mProgress:Number;
      
      private var _delay:Number;
      
      private var _roundToInt:Boolean;
      
      private var mNextTween:Tween;
      
      private var _repeatCount:int;
      
      private var _repeatDelay:Number;
      
      private var _reverse:Boolean;
      
      private var UnknownVarFromTween_Int_1:int;
      
      private const REMOVE_FROM_JUGGLER:String = "REMOVE_FROM_JUGGLER";
      
      public function Tween(param1:Object, param2:Number, param3:Object = "linear")
      {
         super();
         reset(param1,param2,param3);
      }
      
      internal static function getPropertyHint(param1:String) : String
      {
         if(param1.indexOf("color") != -1 || param1.indexOf("Color") != -1)
         {
            return "rgb";
         }
         var _loc2_:int = int(param1.indexOf("#"));
         if(_loc2_ != -1)
         {
            return param1.substr(_loc2_ + 1);
         }
         return null;
      }
      
      internal static function getPropertyName(param1:String) : String
      {
         var _loc2_:int = int(param1.indexOf("#"));
         if(_loc2_ != -1)
         {
            return param1.substring(0,_loc2_);
         }
         return param1;
      }
      
      internal static function fromPool(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         if(UnknownVarFromTween_Vector_1.length)
         {
            return UnknownVarFromTween_Vector_1.pop().reset(param1,param2,param3);
         }
         return new Tween(param1,param2,param3);
      }
      
      internal static function toPool(param1:Tween) : void
      {
         param1._onStart = param1.mOnUpdate = param1._onRepeat = param1._onComplete = null;
         param1._onStartArgs = param1._onUpdateArgs = param1._onRepeatArgs = param1._onCompleteArgs = null;
         param1._target = null;
         param1._transitionFunc = null;
         UnknownVarFromTween_Vector_1.push(param1);
      }
      
      public function reset(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         _target = param1;
         mCurrentTime = 0;
         mTotalTime = Math.max(0.0001,param2);
         mProgress = 0;
         _delay = _repeatDelay = 0;
         _onStart = mOnUpdate = _onRepeat = _onComplete = null;
         _onStartArgs = _onUpdateArgs = _onRepeatArgs = _onCompleteArgs = null;
         _roundToInt = _reverse = false;
         _repeatCount = 1;
         UnknownVarFromTween_Int_1 = -1;
         mNextTween = null;
         if(param3 is String)
         {
            this.transition = param3 as String;
         }
         else
         {
            if(!(param3 is Function))
            {
               throw new ArgumentError("Transition must be either a string or a function");
            }
            this.transitionFunc = param3 as Function;
         }
         if(mProperties)
         {
            mProperties.length = 0;
         }
         else
         {
            mProperties = new Vector.<String>(0);
         }
         if(mStartValues)
         {
            mStartValues.length = 0;
         }
         else
         {
            mStartValues = new Vector.<Number>(0);
         }
         if(mEndValues)
         {
            mEndValues.length = 0;
         }
         else
         {
            mEndValues = new Vector.<Number>(0);
         }
         if(UnknownVarFromTween_Vector_2)
         {
            UnknownVarFromTween_Vector_2.length = 0;
         }
         else
         {
            UnknownVarFromTween_Vector_2 = new Vector.<Function>(0);
         }
         return this;
      }
      
      public function animate(param1:String, param2:Number) : void
      {
         if(_target == null)
         {
            return;
         }
         var _loc3_:int = int(mProperties.length);
         var _loc4_:Function = getUpdateFuncFromProperty(param1);
         mProperties[_loc3_] = getPropertyName(param1);
         mStartValues[_loc3_] = NaN;
         mEndValues[_loc3_] = param2;
         UnknownVarFromTween_Vector_2[_loc3_] = _loc4_;
      }
      
      public function scaleTo(param1:Number) : void
      {
         animate("scaleX",param1);
         animate("scaleY",param1);
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         animate("x",param1);
         animate("y",param2);
      }
      
      public function fadeTo(param1:Number) : void
      {
         animate("alpha",param1);
      }
      
      public function rotateTo(param1:Number, param2:String = "rad") : void
      {
         animate("rotation#" + param2,param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Function = null;
         var _loc5_:Function = null;
         var _loc8_:Array = null;
         if(param1 == 0 || _repeatCount == 1 && mCurrentTime == mTotalTime)
         {
            return;
         }
         var _loc3_:Number = mCurrentTime;
         var _loc2_:Number = mTotalTime - mCurrentTime;
         var _loc10_:Number = param1 > _loc2_ ? param1 - _loc2_ : 0;
         mCurrentTime += param1;
         if(mCurrentTime <= 0)
         {
            return;
         }
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(UnknownVarFromTween_Int_1 < 0 && _loc3_ <= 0 && mCurrentTime > 0)
         {
            UnknownVarFromTween_Int_1++;
            if(_onStart != null)
            {
               _onStart.apply(this,_onStartArgs);
            }
         }
         var _loc11_:Number = mCurrentTime / mTotalTime;
         var _loc9_:Boolean = _reverse && UnknownVarFromTween_Int_1 % 2 == 1;
         var _loc4_:int = int(mStartValues.length);
         mProgress = _loc9_ ? _transitionFunc(1 - _loc11_) : _transitionFunc(_loc11_);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(mStartValues[_loc6_] != mStartValues[_loc6_])
            {
               mStartValues[_loc6_] = _target[mProperties[_loc6_]] as Number;
            }
            _loc7_ = UnknownVarFromTween_Vector_2[_loc6_] as Function;
            _loc7_(mProperties[_loc6_],mStartValues[_loc6_],mEndValues[_loc6_]);
            _loc6_++;
         }
         if(mOnUpdate != null)
         {
            mOnUpdate.apply(this,_onUpdateArgs);
         }
         if(_loc3_ < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(_repeatCount == 0 || _repeatCount > 1)
            {
               mCurrentTime = -_repeatDelay;
               UnknownVarFromTween_Int_1++;
               if(_repeatCount > 1)
               {
                  _repeatCount--;
               }
               if(_onRepeat != null)
               {
                  _onRepeat.apply(this,_onRepeatArgs);
               }
            }
            else
            {
               _loc5_ = _onComplete;
               _loc8_ = _onCompleteArgs;
               dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
               if(_loc5_ != null)
               {
                  _loc5_.apply(this,_loc8_);
               }
               if(mCurrentTime == 0)
               {
                  _loc10_ = 0;
               }
            }
         }
         if(_loc10_)
         {
            advanceTime(_loc10_);
         }
      }
      
      private function getUpdateFuncFromProperty(param1:String) : Function
      {
         var _loc3_:Function = null;
         var _loc2_:String = getPropertyHint(param1);
         switch(_loc2_)
         {
            case null:
               _loc3_ = updateStandard;
               break;
            case "rgb":
               _loc3_ = updateRgb;
               break;
            case "rad":
               _loc3_ = updateRad;
               break;
            case "deg":
               _loc3_ = updateDeg;
               break;
            default:
               _loc3_ = updateStandard;
         }
         return _loc3_;
      }
      
      private function updateStandard(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = param2 + mProgress * (param3 - param2);
         if(_roundToInt)
         {
            _loc4_ = Math.round(_loc4_);
         }
         _target[param1] = _loc4_;
      }
      
      private function updateRgb(param1:String, param2:Number, param3:Number) : void
      {
         var _loc11_:uint = param2;
         var _loc6_:uint = param3;
         var _loc13_:uint = uint(_loc11_ >> 24 & 0xFF);
         var _loc17_:uint = uint(_loc11_ >> 16 & 0xFF);
         var _loc7_:uint = uint(_loc11_ >> 8 & 0xFF);
         var _loc10_:uint = uint(_loc11_ & 0xFF);
         var _loc9_:uint = uint(_loc6_ >> 24 & 0xFF);
         var _loc16_:uint = uint(_loc6_ >> 16 & 0xFF);
         var _loc5_:uint = uint(_loc6_ >> 8 & 0xFF);
         var _loc8_:uint = uint(_loc6_ & 0xFF);
         var _loc14_:uint = _loc13_ + (_loc9_ - _loc13_) * mProgress;
         var _loc4_:uint = _loc17_ + (_loc16_ - _loc17_) * mProgress;
         var _loc15_:uint = _loc7_ + (_loc5_ - _loc7_) * mProgress;
         var _loc12_:uint = _loc10_ + (_loc8_ - _loc10_) * mProgress;
         _target[param1] = _loc14_ << 24 | _loc4_ << 16 | _loc15_ << 8 | _loc12_;
      }
      
      private function updateRad(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(3.141592653589793,param1,param2,param3);
      }
      
      private function updateDeg(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(180,param1,param2,param3);
      }
      
      private function updateAngle(param1:Number, param2:String, param3:Number, param4:Number) : void
      {
         while(Math.abs(param4 - param3) > param1)
         {
            if(param3 < param4)
            {
               param4 -= 2 * param1;
            }
            else
            {
               param4 += 2 * param1;
            }
         }
         updateStandard(param2,param3,param4);
      }
      
      public function getEndValue(param1:String) : Number
      {
         var _loc2_:int = int(mProperties.indexOf(param1));
         if(_loc2_ == -1)
         {
            throw new ArgumentError("The property \'" + param1 + "\' is not animated");
         }
         return mEndValues[_loc2_] as Number;
      }
      
      public function get isComplete() : Boolean
      {
         return mCurrentTime >= mTotalTime && _repeatCount == 1;
      }
      
      public function get target() : Object
      {
         return _target;
      }
      
      public function get transition() : String
      {
         return mTransitionName;
      }
      
      public function set transition(param1:String) : void
      {
         mTransitionName = param1;
         _transitionFunc = Transitions.getTransition(param1);
         if(_transitionFunc == null)
         {
            throw new ArgumentError("Invalid transiton: " + param1);
         }
      }
      
      public function get transitionFunc() : Function
      {
         return _transitionFunc;
      }
      
      public function set transitionFunc(param1:Function) : void
      {
         mTransitionName = "custom";
         _transitionFunc = param1;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get progress() : Number
      {
         return mProgress;
      }
      
      public function get delay() : Number
      {
         return _delay;
      }
      
      public function set delay(param1:Number) : void
      {
         mCurrentTime = mCurrentTime + _delay - param1;
         _delay = param1;
      }
      
      public function get repeatCount() : int
      {
         return _repeatCount;
      }
      
      public function set repeatCount(param1:int) : void
      {
         _repeatCount = param1;
      }
      
      public function get repeatDelay() : Number
      {
         return _repeatDelay;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         _repeatDelay = param1;
      }
      
      public function get reverse() : Boolean
      {
         return _reverse;
      }
      
      public function set reverse(param1:Boolean) : void
      {
         _reverse = param1;
      }
      
      public function get roundToInt() : Boolean
      {
         return _roundToInt;
      }
      
      public function set roundToInt(param1:Boolean) : void
      {
         _roundToInt = param1;
      }
      
      public function get onStart() : Function
      {
         return _onStart;
      }
      
      public function set onStart(param1:Function) : void
      {
         _onStart = param1;
      }
      
      public function get onUpdate() : Function
      {
         return mOnUpdate;
      }
      
      public function set onUpdate(param1:Function) : void
      {
         mOnUpdate = param1;
      }
      
      public function get onRepeat() : Function
      {
         return _onRepeat;
      }
      
      public function set onRepeat(param1:Function) : void
      {
         _onRepeat = param1;
      }
      
      public function get onComplete() : Function
      {
         return _onComplete;
      }
      
      public function set onComplete(param1:Function) : void
      {
         _onComplete = param1;
      }
      
      public function get onStartArgs() : Array
      {
         return _onStartArgs;
      }
      
      public function set onStartArgs(param1:Array) : void
      {
         _onStartArgs = param1;
      }
      
      public function get onUpdateArgs() : Array
      {
         return _onUpdateArgs;
      }
      
      public function set onUpdateArgs(param1:Array) : void
      {
         _onUpdateArgs = param1;
      }
      
      public function get onRepeatArgs() : Array
      {
         return _onRepeatArgs;
      }
      
      public function set onRepeatArgs(param1:Array) : void
      {
         _onRepeatArgs = param1;
      }
      
      public function get onCompleteArgs() : Array
      {
         return _onCompleteArgs;
      }
      
      public function set onCompleteArgs(param1:Array) : void
      {
         _onCompleteArgs = param1;
      }
      
      public function get nextTween() : Tween
      {
         return mNextTween;
      }
      
      public function set nextTween(param1:Tween) : void
      {
         mNextTween = param1;
      }
   }
}

