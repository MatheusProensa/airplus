package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Ease extends Interval
   {
      protected var UnknownVarFromEase_Interval_1:Interval;
      
      public function Ease(param1:Interval)
      {
         super(param1.target,param1.duration);
         UnknownVarFromEase_Interval_1 = param1;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         UnknownVarFromEase_Interval_1.friend::start();
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         UnknownVarFromEase_Interval_1.friend::update(param1);
      }
      
      override friend function stop() : void
      {
         super.friend::stop();
         UnknownVarFromEase_Interval_1.friend::stop();
      }
   }
}

