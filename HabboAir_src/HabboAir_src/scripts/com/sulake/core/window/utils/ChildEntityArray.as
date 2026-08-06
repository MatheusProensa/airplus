package com.sulake.core.window.utils
{
   public class ChildEntityArray extends UnknownCoreWindowUtils5 implements IChildEntityArray
   {
      public function ChildEntityArray()
      {
         super();
      }
      
      public function removeChild(param1:UnknownICoreWindowUtils3) : UnknownICoreWindowUtils3
      {
         var _loc2_:int = int(UnknownVarFromUnknownCoreWindowUtils5_Vector_1.indexOf(param1));
         if(_loc2_ < 0)
         {
            return null;
         }
         UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(_loc2_,1);
         return param1;
      }
      
      public function addChild(param1:UnknownICoreWindowUtils3) : UnknownICoreWindowUtils3
      {
         UnknownVarFromUnknownCoreWindowUtils5_Vector_1.push(param1);
         return param1;
      }
      
      public function addChildAt(param1:UnknownICoreWindowUtils3, param2:int) : UnknownICoreWindowUtils3
      {
         UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(param2,0,param1);
         return param1;
      }
      
      public function removeChildAt(param1:int) : UnknownICoreWindowUtils3
      {
         var _loc2_:UnknownICoreWindowUtils3 = UnknownVarFromUnknownCoreWindowUtils5_Vector_1[param1];
         if(_loc2_ != null)
         {
            UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(param1,1);
            return _loc2_;
         }
         return null;
      }
      
      public function setChildIndex(param1:UnknownICoreWindowUtils3, param2:int) : void
      {
         var _loc3_:int = int(UnknownVarFromUnknownCoreWindowUtils5_Vector_1.indexOf(param1));
         if(_loc3_ > -1 && param2 != _loc3_)
         {
            UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(_loc3_,1);
            UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(param2,0,param1);
         }
      }
      
      public function swapChildren(param1:UnknownICoreWindowUtils3, param2:UnknownICoreWindowUtils3) : void
      {
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = null;
         var _loc4_:* = 0;
         if(param1 != null && param2 != null && param1 != param2)
         {
            _loc3_ = int(UnknownVarFromUnknownCoreWindowUtils5_Vector_1.indexOf(param1));
            if(_loc3_ < 0)
            {
               return;
            }
            _loc6_ = int(UnknownVarFromUnknownCoreWindowUtils5_Vector_1.indexOf(param2));
            if(_loc6_ < 0)
            {
               return;
            }
            if(_loc6_ < _loc3_)
            {
               _loc5_ = param1;
               param1 = param2;
               param2 = _loc5_;
               _loc4_ = _loc3_;
               _loc3_ = _loc6_;
               _loc6_ = _loc4_;
            }
            UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(_loc6_,1);
            UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(_loc3_,1);
            UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(_loc3_,0,param2);
            UnknownVarFromUnknownCoreWindowUtils5_Vector_1.splice(_loc6_,0,param1);
         }
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         swapChildren(UnknownVarFromUnknownCoreWindowUtils5_Vector_1[param1],UnknownVarFromUnknownCoreWindowUtils5_Vector_1[param2]);
      }
   }
}

