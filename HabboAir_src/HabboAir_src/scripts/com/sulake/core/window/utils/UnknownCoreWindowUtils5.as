package com.sulake.core.window.utils
{
   public class UnknownCoreWindowUtils5 implements IUnknownCoreWindowUtils5
   {
      protected var UnknownVarFromUnknownCoreWindowUtils5_Vector_1:Vector.<UnknownICoreWindowUtils3> = new Vector.<UnknownICoreWindowUtils3>();
      
      public function UnknownCoreWindowUtils5()
      {
         super();
      }
      
      public function get numChildren() : int
      {
         return UnknownVarFromUnknownCoreWindowUtils5_Vector_1.length;
      }
      
      public function getChildAt(param1:int) : UnknownICoreWindowUtils3
      {
         return UnknownVarFromUnknownCoreWindowUtils5_Vector_1[param1];
      }
      
      public function getChildByID(param1:int) : UnknownICoreWindowUtils3
      {
         var _loc2_:* = null;
         for each(_loc2_ in UnknownVarFromUnknownCoreWindowUtils5_Vector_1)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildByName(param1:String) : UnknownICoreWindowUtils3
      {
         var _loc2_:* = null;
         for each(_loc2_ in UnknownVarFromUnknownCoreWindowUtils5_Vector_1)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildIndex(param1:UnknownICoreWindowUtils3) : int
      {
         return UnknownVarFromUnknownCoreWindowUtils5_Vector_1.indexOf(param1);
      }
      
      public function groupChildrenWithID(param1:uint, param2:Array) : uint
      {
         var _loc4_:* = null;
         var _loc3_:uint = 0;
         for each(_loc4_ in UnknownVarFromUnknownCoreWindowUtils5_Vector_1)
         {
            if(_loc4_.id == param1)
            {
               param2.push(_loc4_);
               _loc3_++;
            }
         }
         return _loc3_;
      }
   }
}

