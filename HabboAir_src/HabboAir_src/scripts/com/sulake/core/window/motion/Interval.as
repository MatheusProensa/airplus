package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindowModel;
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class Interval extends Motion
   {
      private var UnknownVarFromInterval_Int_1:int;
      
      private var _duration:int;
      
      public function Interval(param1:IWindowModel, param2:int)
      {
         super(param1);
         _complete = false;
         _duration = param2;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         _complete = false;
         UnknownVarFromInterval_Int_1 = getTimer();
      }
      
      final override friend function tick(param1:int) : void
      {
         var _loc2_:Number = (param1 - UnknownVarFromInterval_Int_1) / _duration;
         if(_loc2_ < 1)
         {
            friend::update(_loc2_);
         }
         else
         {
            friend::update(1);
            _complete = true;
         }
      }
   }
}

