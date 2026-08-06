package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationFrameSequenceData
   {
      private var _frames:Array = [];
      
      private var _frameIndexes:Array = [];
      
      private var UnknownVarFromAnimationFrameSequenceData_Array_1:Array = [];
      
      private var _isRandom:Boolean = false;
      
      private var UnknownVarFromAnimationFrameSequenceData_Int_1:int = 1;
      
      public function AnimationFrameSequenceData(param1:int, param2:Boolean)
      {
         super();
         if(param1 < 1)
         {
            param1 = 1;
         }
         UnknownVarFromAnimationFrameSequenceData_Int_1 = param1;
         _isRandom = param2;
      }
      
      public function get isRandom() : Boolean
      {
         return _isRandom;
      }
      
      public function get frameCount() : int
      {
         return _frameIndexes.length * UnknownVarFromAnimationFrameSequenceData_Int_1;
      }
      
      public function dispose() : void
      {
         _frames = [];
      }
      
      public function initialize() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 1;
         var _loc2_:int = -1;
         _loc3_ = _frameIndexes.length - 1;
         while(_loc3_ >= 0)
         {
            if(_frameIndexes[_loc3_] == _loc2_)
            {
               _loc1_++;
            }
            else
            {
               _loc2_ = int(_frameIndexes[_loc3_]);
               _loc1_ = 1;
            }
            UnknownVarFromAnimationFrameSequenceData_Array_1[_loc3_] = _loc1_;
            _loc3_--;
         }
      }
      
      public function addFrame(param1:int, param2:int, param3:int, param4:int, param5:int, param6:DirectionalOffsetData) : void
      {
         var _loc8_:AnimationFrameData = null;
         var _loc7_:int = 1;
         if(_frames.length > 0)
         {
            _loc8_ = _frames[_frames.length - 1];
            if(_loc8_.id == param1 && !_loc8_.hasDirectionalOffsets() && _loc8_.x == param2 && _loc8_.y == param3 && _loc8_.randomX == param4 && param4 == 0 && _loc8_.randomY == param5 && param5 == 0)
            {
               _loc7_ += _loc8_.repeats;
               _frames.pop();
            }
         }
         var _loc9_:AnimationFrameData = null;
         if(param6 == null)
         {
            _loc9_ = new AnimationFrameData(param1,param2,param3,param4,param5,_loc7_);
         }
         else
         {
            _loc9_ = new AnimationFrameDirectionalData(param1,param2,param3,param4,param5,param6,_loc7_);
         }
         _frames.push(_loc9_);
         _frameIndexes.push(_frames.length - 1);
         UnknownVarFromAnimationFrameSequenceData_Array_1.push(1);
      }
      
      public function getFrame(param1:int) : AnimationFrameData
      {
         if(_frames.length == 0 || param1 < 0 || param1 >= frameCount)
         {
            return null;
         }
         param1 = int(_frameIndexes[param1 % _frameIndexes.length]);
         return _frames[param1] as AnimationFrameData;
      }
      
      public function getFrameIndex(param1:int) : int
      {
         if(param1 < 0 || param1 >= frameCount)
         {
            return -1;
         }
         if(_isRandom)
         {
            param1 = Math.random() * _frameIndexes.length;
            if(param1 == _frameIndexes.length)
            {
               param1--;
            }
         }
         return param1;
      }
      
      public function getRepeats(param1:int) : int
      {
         if(param1 < 0 || param1 >= frameCount)
         {
            return 0;
         }
         return UnknownVarFromAnimationFrameSequenceData_Array_1[param1 % UnknownVarFromAnimationFrameSequenceData_Array_1.length];
      }
   }
}

