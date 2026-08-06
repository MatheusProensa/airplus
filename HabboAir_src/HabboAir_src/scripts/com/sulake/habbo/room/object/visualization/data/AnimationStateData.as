package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationStateData
   {
      private var _animationId:int = -1;
      
      private var _animationAfterTransitionId:int = 0;
      
      private var _animationOver:Boolean = false;
      
      private var _frameCounter:int = 0;
      
      private var _frames:Array = [];
      
      private var UnknownVarFromAnimationStateData_Array_1:Array = [];
      
      private var UnknownVarFromAnimationStateData_Array_2:Array = [];
      
      private var UnknownVarFromAnimationStateData_Int_1:int = 0;
      
      public function AnimationStateData()
      {
         super();
      }
      
      public function get animationOver() : Boolean
      {
         return _animationOver;
      }
      
      public function set animationOver(param1:Boolean) : void
      {
         _animationOver = param1;
      }
      
      public function get frameCounter() : int
      {
         return _frameCounter;
      }
      
      public function set frameCounter(param1:int) : void
      {
         _frameCounter = param1;
      }
      
      public function get animationId() : int
      {
         return _animationId;
      }
      
      public function set animationId(param1:int) : void
      {
         if(param1 != _animationId)
         {
            _animationId = param1;
            resetAnimationFrames(false);
         }
      }
      
      public function get animationAfterTransitionId() : int
      {
         return _animationAfterTransitionId;
      }
      
      public function set animationAfterTransitionId(param1:int) : void
      {
         _animationAfterTransitionId = param1;
      }
      
      public function dispose() : void
      {
         recycleFrames();
         _frames = null;
         UnknownVarFromAnimationStateData_Array_1 = null;
         UnknownVarFromAnimationStateData_Array_2 = null;
      }
      
      public function setLayerCount(param1:int) : void
      {
         UnknownVarFromAnimationStateData_Int_1 = param1;
         resetAnimationFrames();
      }
      
      public function resetAnimationFrames(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AnimationFrame = null;
         if(param1 || _frames == null)
         {
            recycleFrames();
            _frames = [];
         }
         UnknownVarFromAnimationStateData_Array_1 = [];
         UnknownVarFromAnimationStateData_Array_2 = [];
         _animationOver = false;
         _frameCounter = 0;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromAnimationStateData_Int_1)
         {
            if(param1 || _frames.length <= _loc2_)
            {
               _frames[_loc2_] = null;
            }
            else
            {
               _loc3_ = _frames[_loc2_];
               if(_loc3_ != null)
               {
                  _loc3_.recycle();
                  _frames[_loc2_] = AnimationFrame.allocate(_loc3_.id,_loc3_.x,_loc3_.y,_loc3_.repeats,0,_loc3_.isLastFrame);
               }
            }
            UnknownVarFromAnimationStateData_Array_1[_loc2_] = false;
            UnknownVarFromAnimationStateData_Array_2[_loc2_] = false;
            _loc2_++;
         }
      }
      
      private function recycleFrames() : void
      {
         if(_frames != null)
         {
            for each(var _loc1_ in _frames)
            {
               if(_loc1_ != null)
               {
                  _loc1_.recycle();
               }
            }
         }
      }
      
      public function getFrame(param1:int) : AnimationFrame
      {
         if(param1 >= 0 && param1 < UnknownVarFromAnimationStateData_Int_1)
         {
            return _frames[param1];
         }
         return null;
      }
      
      public function setFrame(param1:int, param2:AnimationFrame) : void
      {
         var _loc3_:AnimationFrame = null;
         if(param1 >= 0 && param1 < UnknownVarFromAnimationStateData_Int_1)
         {
            _loc3_ = _frames[param1];
            if(_loc3_ != null)
            {
               _loc3_.recycle();
            }
            _frames[param1] = param2;
         }
      }
      
      public function getAnimationPlayed(param1:int) : Boolean
      {
         if(param1 >= 0 && param1 < UnknownVarFromAnimationStateData_Int_1)
         {
            return UnknownVarFromAnimationStateData_Array_2[param1];
         }
         return true;
      }
      
      public function setAnimationPlayed(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < UnknownVarFromAnimationStateData_Int_1)
         {
            UnknownVarFromAnimationStateData_Array_2[param1] = param2;
         }
      }
      
      public function getLastFramePlayed(param1:int) : Boolean
      {
         if(param1 >= 0 && param1 < UnknownVarFromAnimationStateData_Int_1)
         {
            return UnknownVarFromAnimationStateData_Array_1[param1];
         }
         return true;
      }
      
      public function setLastFramePlayed(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < UnknownVarFromAnimationStateData_Int_1)
         {
            UnknownVarFromAnimationStateData_Array_1[param1] = param2;
         }
      }
   }
}

