package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationLayerData
   {
      private var _frameSequences:Array = [];
      
      private var UnknownVarFromAnimationLayerData_Int_1:int = -1;
      
      private var UnknownVarFromAnimationLayerData_Int_2:int = 1;
      
      private var UnknownVarFromAnimationLayerData_Int_3:int = 1;
      
      private var UnknownVarFromAnimationLayerData_Boolean_1:Boolean = false;
      
      public function AnimationLayerData(param1:int, param2:int, param3:Boolean)
      {
         super();
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         UnknownVarFromAnimationLayerData_Int_2 = param1;
         UnknownVarFromAnimationLayerData_Int_3 = param2;
         UnknownVarFromAnimationLayerData_Boolean_1 = param3;
      }
      
      public function get frameCount() : int
      {
         if(UnknownVarFromAnimationLayerData_Int_1 < 0)
         {
            calculateLength();
         }
         return UnknownVarFromAnimationLayerData_Int_1;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AnimationFrameSequenceData = null;
         _loc2_ = 0;
         while(_loc2_ < _frameSequences.length)
         {
            _loc1_ = _frameSequences[_loc2_] as AnimationFrameSequenceData;
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
            _loc2_++;
         }
         _frameSequences = [];
      }
      
      public function addFrameSequence(param1:int, param2:Boolean) : AnimationFrameSequenceData
      {
         var _loc3_:AnimationFrameSequenceData = new AnimationFrameSequenceData(param1,param2);
         _frameSequences.push(_loc3_);
         return _loc3_;
      }
      
      public function calculateLength() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AnimationFrameSequenceData = null;
         UnknownVarFromAnimationLayerData_Int_1 = 0;
         _loc2_ = 0;
         while(_loc2_ < _frameSequences.length)
         {
            _loc1_ = _frameSequences[_loc2_] as AnimationFrameSequenceData;
            if(_loc1_ != null)
            {
               UnknownVarFromAnimationLayerData_Int_1 += _loc1_.frameCount;
            }
            _loc2_++;
         }
      }
      
      public function getFrame(param1:int, param2:int) : AnimationFrame
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(UnknownVarFromAnimationLayerData_Int_1 < 1)
         {
            return null;
         }
         var _loc4_:AnimationFrameSequenceData = null;
         param2 /= UnknownVarFromAnimationLayerData_Int_3;
         var _loc5_:Boolean = false;
         var _loc3_:int = 0;
         if(!UnknownVarFromAnimationLayerData_Boolean_1)
         {
            _loc7_ = param2 / UnknownVarFromAnimationLayerData_Int_1;
            param2 %= UnknownVarFromAnimationLayerData_Int_1;
            if(UnknownVarFromAnimationLayerData_Int_2 > 0 && _loc7_ >= UnknownVarFromAnimationLayerData_Int_2 || UnknownVarFromAnimationLayerData_Int_2 <= 0 && UnknownVarFromAnimationLayerData_Int_1 == 1)
            {
               param2 = UnknownVarFromAnimationLayerData_Int_1 - 1;
               _loc5_ = true;
            }
            _loc6_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _frameSequences.length)
            {
               _loc4_ = _frameSequences[_loc3_] as AnimationFrameSequenceData;
               if(_loc4_ != null)
               {
                  if(param2 < _loc6_ + _loc4_.frameCount)
                  {
                     break;
                  }
                  _loc6_ += _loc4_.frameCount;
               }
               _loc3_++;
            }
            return getFrameFromSpecificSequence(param1,_loc4_,_loc3_,param2 - _loc6_,_loc5_);
         }
         _loc3_ = _frameSequences.length * Math.random();
         _loc4_ = _frameSequences[_loc3_] as AnimationFrameSequenceData;
         if(_loc4_.frameCount < 1)
         {
            return null;
         }
         param2 = 0;
         return getFrameFromSpecificSequence(param1,_loc4_,_loc3_,param2,false);
      }
      
      public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int) : AnimationFrame
      {
         if(param2 < 0 || param2 >= _frameSequences.length)
         {
            return null;
         }
         var _loc5_:AnimationFrameSequenceData = _frameSequences[param2] as AnimationFrameSequenceData;
         if(_loc5_ != null)
         {
            if(param3 >= _loc5_.frameCount)
            {
               return getFrame(param1,param4);
            }
            return getFrameFromSpecificSequence(param1,_loc5_,param2,param3,false);
         }
         return null;
      }
      
      private function getFrameFromSpecificSequence(param1:int, param2:AnimationFrameSequenceData, param3:int, param4:int, param5:Boolean) : AnimationFrame
      {
         var _loc10_:int = 0;
         var _loc8_:AnimationFrameData = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:Boolean = false;
         var _loc15_:* = null;
         if(param2 != null)
         {
            _loc10_ = param2.getFrameIndex(param4);
            _loc8_ = param2.getFrame(_loc10_);
            if(_loc8_ == null)
            {
               return null;
            }
            _loc11_ = _loc8_.getX(param1);
            _loc12_ = _loc8_.getY(param1);
            _loc13_ = _loc8_.randomX;
            _loc14_ = _loc8_.randomY;
            if(_loc13_ != 0)
            {
               _loc11_ += _loc13_ * Math.random();
            }
            if(_loc14_ != 0)
            {
               _loc12_ += _loc14_ * Math.random();
            }
            _loc7_ = _loc8_.repeats;
            if(_loc7_ > 1)
            {
               _loc7_ = param2.getRepeats(_loc10_);
            }
            _loc6_ = UnknownVarFromAnimationLayerData_Int_3 * _loc7_;
            if(param5)
            {
               _loc6_ = -1;
            }
            _loc9_ = false;
            if(!UnknownVarFromAnimationLayerData_Boolean_1 && !param2.isRandom)
            {
               if(param3 == _frameSequences.length - 1 && param4 == param2.frameCount - 1)
               {
                  _loc9_ = true;
               }
            }
            return AnimationFrame.allocate(_loc8_.id,_loc11_,_loc12_,_loc7_,_loc6_,_loc9_,param3,param4);
         }
         return null;
      }
   }
}

