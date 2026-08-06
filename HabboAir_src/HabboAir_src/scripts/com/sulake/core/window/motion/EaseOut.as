package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class EaseOut extends EaseRate
   {
      public function EaseOut(param1:Interval, param2:Number)
      {
         super(param1,param2);
      }
      
      override friend function update(param1:Number) : void
      {
         UnknownVarFromEase_Interval_1.friend::update(Math.pow(param1,1 / UnknownVarFromEaseRate_Number_1));
      }
   }
}

