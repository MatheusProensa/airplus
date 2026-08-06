package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationFrame
   {
      public static const FRAME_REPEAT_FOREVER:int = -1;
      
      public static const UnknownConstFromAnimationFrame_Int_1:int = -1;
      
      private static const POOL_SIZE_LIMIT:int = 6000;
      
      private static const UnknownConstFromAnimationFrame_Array_1:Array = [];
      
      private var UnknownVarFromAnimationFrame_Int_1:int = 0;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _repeats:int = 1;
      
      private var _frameRepeats:int = 1;
      
      private var UnknownVarFromAnimationFrame_Int_2:int = 1;
      
      private var _activeSequence:int = -1;
      
      private var _activeSequenceOffset:int = 0;
      
      private var _isLastFrame:Boolean = false;
      
      private var UnknownVarFromAnimationFrame_Boolean_1:Boolean = false;
      
      public function AnimationFrame()
      {
         super();
      }
      
      public static function allocate(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:int = -1, param8:int = 0) : AnimationFrame
      {
         var _loc9_:AnimationFrame = UnknownConstFromAnimationFrame_Array_1.length > 0 ? UnknownConstFromAnimationFrame_Array_1.pop() : new AnimationFrame();
         _loc9_.UnknownVarFromAnimationFrame_Boolean_1 = false;
         _loc9_.UnknownVarFromAnimationFrame_Int_1 = param1;
         _loc9_._x = param2;
         _loc9_._y = param3;
         _loc9_._isLastFrame = param6;
         if(param4 < 1)
         {
            param4 = 1;
         }
         _loc9_._repeats = param4;
         if(param5 < 0)
         {
            param5 = -1;
         }
         _loc9_._frameRepeats = param5;
         _loc9_.UnknownVarFromAnimationFrame_Int_2 = param5;
         if(param7 >= 0)
         {
            _loc9_._activeSequence = param7;
            _loc9_._activeSequenceOffset = param8;
         }
         return _loc9_;
      }
      
      public function get id() : int
      {
         if(UnknownVarFromAnimationFrame_Int_1 >= 0)
         {
            return UnknownVarFromAnimationFrame_Int_1;
         }
         return -UnknownVarFromAnimationFrame_Int_1 * Math.random();
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get repeats() : int
      {
         return _repeats;
      }
      
      public function get frameRepeats() : int
      {
         return _frameRepeats;
      }
      
      public function get isLastFrame() : Boolean
      {
         return _isLastFrame;
      }
      
      public function get remainingFrameRepeats() : int
      {
         if(_frameRepeats < 0)
         {
            return -1;
         }
         return UnknownVarFromAnimationFrame_Int_2;
      }
      
      public function set remainingFrameRepeats(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(_frameRepeats > 0 && param1 > _frameRepeats)
         {
            param1 = _frameRepeats;
         }
         UnknownVarFromAnimationFrame_Int_2 = param1;
      }
      
      public function get activeSequence() : int
      {
         return _activeSequence;
      }
      
      public function get activeSequenceOffset() : int
      {
         return _activeSequenceOffset;
      }
      
      public function recycle() : void
      {
         if(!UnknownVarFromAnimationFrame_Boolean_1)
         {
            UnknownVarFromAnimationFrame_Boolean_1 = true;
            if(UnknownConstFromAnimationFrame_Array_1.length < 6000)
            {
               UnknownConstFromAnimationFrame_Array_1.push(this);
            }
         }
      }
   }
}

