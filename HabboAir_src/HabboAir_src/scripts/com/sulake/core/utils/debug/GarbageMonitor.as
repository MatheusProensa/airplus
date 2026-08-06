package com.sulake.core.utils.debug
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.utils.Dictionary;
   
   public class GarbageMonitor implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromGarbageMonitor_Dictionary_1:Dictionary;
      
      public function GarbageMonitor()
      {
         super();
         UnknownVarFromGarbageMonitor_Dictionary_1 = new Dictionary(true);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            for each(var _loc1_ in UnknownVarFromGarbageMonitor_Dictionary_1)
            {
               delete UnknownVarFromGarbageMonitor_Dictionary_1[_loc1_];
            }
            UnknownVarFromGarbageMonitor_Dictionary_1 = null;
            _disposed = true;
         }
      }
      
      public function insert(param1:Object, param2:String = null) : void
      {
         UnknownVarFromGarbageMonitor_Dictionary_1[param1] = param2 == null ? param1.toString() : param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get list() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in UnknownVarFromGarbageMonitor_Dictionary_1)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
   }
}

