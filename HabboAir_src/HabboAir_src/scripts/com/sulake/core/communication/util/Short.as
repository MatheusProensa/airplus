package com.sulake.core.communication.util
{
   import flash.utils.ByteArray;
   
   public class Short
   {
      private var UnknownVarFromShort_ByteArray_1:ByteArray;
      
      public function Short(param1:int)
      {
         super();
         UnknownVarFromShort_ByteArray_1 = new ByteArray();
         UnknownVarFromShort_ByteArray_1.writeShort(param1);
         UnknownVarFromShort_ByteArray_1.position = 0;
      }
      
      public function get value() : int
      {
         var _loc1_:int = 0;
         UnknownVarFromShort_ByteArray_1.position = 0;
         if(UnknownVarFromShort_ByteArray_1.bytesAvailable)
         {
            _loc1_ = UnknownVarFromShort_ByteArray_1.readShort();
            UnknownVarFromShort_ByteArray_1.position = 0;
         }
         return _loc1_;
      }
   }
}

