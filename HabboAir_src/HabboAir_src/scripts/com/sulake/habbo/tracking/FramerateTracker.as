package com.sulake.habbo.tracking
{
   public class FramerateTracker
   {
      private var _lastReport:int;
      
      private var UnknownVarFromFramerateTracker_Int_1:int;
      
      private var UnknownVarFromFramerateTracker_Number_1:Number;
      
      private var UnknownVarFromFramerateTracker_Int_2:int;
      
      private var _habboTracking:HabboTracking;
      
      public function FramerateTracker(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function get frameRate() : int
      {
         return Math.round(1000 / UnknownVarFromFramerateTracker_Number_1);
      }
      
      public function trackUpdate(param1:uint, param2:int) : void
      {
         var _loc3_:Number = NaN;
         UnknownVarFromFramerateTracker_Int_1++;
         if(UnknownVarFromFramerateTracker_Int_1 == 1)
         {
            UnknownVarFromFramerateTracker_Number_1 = param1;
            _lastReport = param2;
         }
         else
         {
            _loc3_ = UnknownVarFromFramerateTracker_Int_1;
            UnknownVarFromFramerateTracker_Number_1 = UnknownVarFromFramerateTracker_Number_1 * (_loc3_ - 1) / _loc3_ + param1 / _loc3_;
         }
         if(param2 - _lastReport >= _habboTracking.getInteger("tracking.framerate.reportInterval.seconds",300) * 1000)
         {
            UnknownVarFromFramerateTracker_Int_1 = 0;
            if(UnknownVarFromFramerateTracker_Int_2 < _habboTracking.getInteger("tracking.framerate.maximumEvents",5))
            {
               _habboTracking.trackGoogle("performance","averageFramerate",frameRate);
               UnknownVarFromFramerateTracker_Int_2++;
               _lastReport = param2;
            }
         }
      }
   }
}

