package com.sulake.core.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class Set implements IComponentInterfaceQueue
   {
      private var _length:uint;
      
      private var UnknownVarFromSet_Dictionary_1:Dictionary;
      
      public function Set()
      {
         super();
         _length = 0;
         UnknownVarFromSet_Dictionary_1 = new Dictionary();
      }
      
      public function get length() : uint
      {
         return _length;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromSet_Dictionary_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromSet_Dictionary_1 = null;
         _length = 0;
      }
      
      public function reset() : void
      {
         UnknownVarFromSet_Dictionary_1 = new Dictionary();
         _length = 0;
      }
      
      public function isEmpty() : Boolean
      {
         return _length == 0;
      }
      
      public function add(param1:*) : Boolean
      {
         if(param1 in UnknownVarFromSet_Dictionary_1)
         {
            return false;
         }
         UnknownVarFromSet_Dictionary_1[param1] = true;
         _length++;
         return true;
      }
      
      public function remove(param1:*) : Boolean
      {
         if(!(param1 in UnknownVarFromSet_Dictionary_1))
         {
            return false;
         }
         delete UnknownVarFromSet_Dictionary_1[param1];
         _length--;
         return true;
      }
      
      public function contains(param1:*) : Boolean
      {
         return param1 in UnknownVarFromSet_Dictionary_1;
      }
      
      public function toArray() : Array
      {
         var _loc1_:Array = [];
         for(var _loc2_ in UnknownVarFromSet_Dictionary_1)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
   }
}

