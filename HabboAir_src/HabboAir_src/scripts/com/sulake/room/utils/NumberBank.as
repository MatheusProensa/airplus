package com.sulake.room.utils
{
   public class NumberBank
   {
      private var UnknownVarFromNumberBank_Int_1:int = 0;
      
      private var _reservedNumbers:Array;
      
      private var _freeNumbers:Array;
      
      public function NumberBank(param1:int)
      {
         var _loc2_:int = 0;
         _reservedNumbers = [];
         _freeNumbers = [];
         super();
         if(param1 < 0)
         {
            param1 = 0;
         }
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            _freeNumbers.push(_loc2_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         _reservedNumbers = null;
         _freeNumbers = null;
         UnknownVarFromNumberBank_Int_1 = 0;
      }
      
      public function reserveNumber() : int
      {
         var _loc1_:int = 0;
         if(_freeNumbers.length > 0)
         {
            _loc1_ = _freeNumbers.pop() as int;
            _reservedNumbers.push(_loc1_);
            return _loc1_;
         }
         return -1;
      }
      
      public function freeNumber(param1:int) : void
      {
         var _loc2_:int = int(_reservedNumbers.indexOf(param1));
         if(_loc2_ >= 0)
         {
            _reservedNumbers.splice(_loc2_,1);
            _freeNumbers.push(param1);
         }
      }
   }
}

