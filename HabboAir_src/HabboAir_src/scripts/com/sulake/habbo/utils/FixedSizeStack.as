package com.sulake.habbo.utils
{
   public class FixedSizeStack
   {
      private var UnknownVarFromFixedSizeStack_Array_1:Array = [];
      
      private var UnknownVarFromFixedSizeStack_Int_1:int = 0;
      
      private var _index:int = 0;
      
      public function FixedSizeStack(param1:int)
      {
         super();
         UnknownVarFromFixedSizeStack_Int_1 = param1;
      }
      
      public function reset() : void
      {
         UnknownVarFromFixedSizeStack_Array_1 = [];
         _index = 0;
      }
      
      public function addValue(param1:int) : void
      {
         if(UnknownVarFromFixedSizeStack_Array_1.length < UnknownVarFromFixedSizeStack_Int_1)
         {
            UnknownVarFromFixedSizeStack_Array_1.push(param1);
         }
         else
         {
            UnknownVarFromFixedSizeStack_Array_1[_index] = param1;
         }
         _index = (_index + 1) % UnknownVarFromFixedSizeStack_Int_1;
      }
      
      public function getMax() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = -2147483648;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromFixedSizeStack_Int_1)
         {
            if(UnknownVarFromFixedSizeStack_Array_1[_loc1_] > _loc2_)
            {
               _loc2_ = int(UnknownVarFromFixedSizeStack_Array_1[_loc1_]);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function getMin() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 2147483647;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromFixedSizeStack_Int_1)
         {
            if(UnknownVarFromFixedSizeStack_Array_1[_loc1_] < _loc2_)
            {
               _loc2_ = int(UnknownVarFromFixedSizeStack_Array_1[_loc1_]);
            }
            _loc1_++;
         }
         return _loc2_;
      }
   }
}

