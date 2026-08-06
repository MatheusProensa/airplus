package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Combo extends Motion
   {
      private var UnknownVarFromCombo_Vector_1:Vector.<Motion> = new Vector.<Motion>();
      
      private var UnknownVarFromCombo_Vector_2:Vector.<Motion> = new Vector.<Motion>();
      
      public function Combo(... rest)
      {
         for each(var _loc2_ in rest)
         {
            UnknownVarFromCombo_Vector_1.push(_loc2_);
         }
         super(UnknownVarFromCombo_Vector_1.length > 0 ? UnknownVarFromCombo_Vector_1[0].target : null);
      }
      
      override friend function start() : void
      {
         super.friend::start();
         for each(var _loc1_ in UnknownVarFromCombo_Vector_1)
         {
            _loc1_.friend::start();
         }
      }
      
      override friend function tick(param1:int) : void
      {
         var _loc2_:Motion = null;
         super.friend::tick(param1);
         while(true)
         {
            _loc2_ = UnknownVarFromCombo_Vector_2.pop();
            if(_loc2_ == null)
            {
               break;
            }
            UnknownVarFromCombo_Vector_1.splice(UnknownVarFromCombo_Vector_2.indexOf(_loc2_),1);
            if(_loc2_.running)
            {
               _loc2_.friend::stop();
            }
         }
         for each(_loc2_ in UnknownVarFromCombo_Vector_1)
         {
            if(_loc2_.running)
            {
               _loc2_.friend::tick(param1);
            }
            if(_loc2_.complete)
            {
               UnknownVarFromCombo_Vector_2.push(_loc2_);
            }
         }
         if(UnknownVarFromCombo_Vector_1.length > 0)
         {
            for each(_loc2_ in UnknownVarFromCombo_Vector_1)
            {
               _target = _loc2_.target;
               if(_target && !_target.disposed)
               {
                  break;
               }
            }
            _complete = false;
         }
         else
         {
            _complete = true;
         }
      }
   }
}

