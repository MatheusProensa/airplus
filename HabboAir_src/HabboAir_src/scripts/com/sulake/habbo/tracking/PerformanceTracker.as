package com.sulake.habbo.tracking
{
   import com.sulake.core.utils.debug.GarbageMonitor;
   import com.sulake.habbo.communication.messages.outgoing.tracking.PerformanceLogMessageComposer;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.getTimer;
   
   public class PerformanceTracker
   {
      private var UnknownVarFromPerformanceTracker_Int_1:int = 0;
      
      private var _averageUpdateInterval:Number = 0;
      
      private var UnknownVarFromPerformanceTracker_String_1:String = "";
      
      private var _flashVersion:String = "";
      
      private var UnknownVarFromPerformanceTracker_String_2:String = "";
      
      private var UnknownVarFromPerformanceTracker_String_3:String = "";
      
      private var UnknownVarFromPerformanceTracker_Boolean_1:Boolean = false;
      
      private var UnknownVarFromPerformanceTracker_GarbageMonitor_1:GarbageMonitor = null;
      
      private var UnknownVarFromPerformanceTracker_Int_2:int = 0;
      
      private var UnknownVarFromPerformanceTracker_Int_3:int = 0;
      
      private var _lastReport:int = 0;
      
      private var UnknownVarFromPerformanceTracker_Int_4:int = 0;
      
      private var UnknownVarFromPerformanceTracker_Number_1:Number = 0;
      
      private var _habboTracking:HabboTracking;
      
      public function PerformanceTracker(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
         _flashVersion = Capabilities.version;
         UnknownVarFromPerformanceTracker_String_2 = Capabilities.os;
         UnknownVarFromPerformanceTracker_Boolean_1 = Capabilities.isDebugger;
         try
         {
            UnknownVarFromPerformanceTracker_String_1 = ExternalInterface.available ? ExternalInterface.call("window.navigator.userAgent.toString") : "unknown";
         }
         catch(e:Error)
         {
         }
         if(UnknownVarFromPerformanceTracker_String_1 == null)
         {
            UnknownVarFromPerformanceTracker_String_1 = "unknown";
         }
         UnknownVarFromPerformanceTracker_GarbageMonitor_1 = new GarbageMonitor();
         updateGarbageMonitor();
         _lastReport = getTimer();
      }
      
      private static function differenceInPercents(param1:Number, param2:Number) : Number
      {
         if(param1 == param2)
         {
            return 0;
         }
         var _loc4_:* = param1;
         var _loc3_:* = param2;
         if(param2 > param1)
         {
            _loc4_ = param2;
            _loc3_ = param1;
         }
         return 100 * (1 - _loc3_ / _loc4_);
      }
      
      public function get flashVersion() : String
      {
         return _flashVersion;
      }
      
      public function get averageUpdateInterval() : int
      {
         return _averageUpdateInterval;
      }
      
      private function updateGarbageMonitor() : Object
      {
         var _loc2_:Object = null;
         var _loc1_:Array = UnknownVarFromPerformanceTracker_GarbageMonitor_1.list;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            _loc2_ = new GarbageTester("tester");
            UnknownVarFromPerformanceTracker_GarbageMonitor_1.insert(_loc2_,"tester");
            return _loc2_;
         }
         return null;
      }
      
      public function update(param1:uint, param2:int) : void
      {
         var _loc7_:Object = null;
         var _loc3_:Number = NaN;
         var _loc4_:* = 0;
         var _loc6_:Boolean = false;
         var _loc5_:Number = NaN;
         if(isGarbageMonitored)
         {
            _loc7_ = updateGarbageMonitor();
            if(_loc7_ != null)
            {
               UnknownVarFromPerformanceTracker_Int_2++;
               Logger.log("Garbage collection");
            }
         }
         var _loc8_:Boolean = false;
         if(param1 > slowUpdateLimit)
         {
            UnknownVarFromPerformanceTracker_Int_3++;
            _loc8_ = true;
         }
         else
         {
            UnknownVarFromPerformanceTracker_Int_1++;
            if(UnknownVarFromPerformanceTracker_Int_1 <= 1)
            {
               _averageUpdateInterval = param1;
            }
            else
            {
               _loc3_ = UnknownVarFromPerformanceTracker_Int_1;
               _averageUpdateInterval = _averageUpdateInterval * (_loc3_ - 1) / _loc3_ + param1 / _loc3_;
            }
         }
         if(param2 - _lastReport > reportInterval * 1000 && UnknownVarFromPerformanceTracker_Int_4 < reportLimit)
         {
            _loc4_ = System.totalMemory;
            Logger.log("*** Performance tracker: average frame rate " + 1000 / _averageUpdateInterval + "/s, system memory usage : " + _loc4_ + " bytes");
            _loc6_ = true;
            if(useDistribution && UnknownVarFromPerformanceTracker_Int_4 > 0)
            {
               _loc5_ = differenceInPercents(UnknownVarFromPerformanceTracker_Number_1,_averageUpdateInterval);
               if(_loc5_ < meanDevianceLimit)
               {
                  _loc6_ = false;
               }
            }
            _lastReport = param2;
            if(_loc6_ || _loc8_)
            {
               UnknownVarFromPerformanceTracker_Number_1 = _averageUpdateInterval;
               sendReport(param2);
               UnknownVarFromPerformanceTracker_Int_4++;
            }
         }
      }
      
      private function sendReport(param1:int) : void
      {
         var _loc4_:int = param1 / 1000;
         var _loc3_:int = -1;
         var _loc2_:int = System.totalMemory / 1024;
         _habboTracking.send(new PerformanceLogMessageComposer(_loc4_,UnknownVarFromPerformanceTracker_String_1,_flashVersion,UnknownVarFromPerformanceTracker_String_2,UnknownVarFromPerformanceTracker_String_3,UnknownVarFromPerformanceTracker_Boolean_1,_loc2_,_loc3_,UnknownVarFromPerformanceTracker_Int_2,_averageUpdateInterval,UnknownVarFromPerformanceTracker_Int_3));
         UnknownVarFromPerformanceTracker_Int_2 = 0;
         _averageUpdateInterval = 0;
         UnknownVarFromPerformanceTracker_Int_1 = 0;
         UnknownVarFromPerformanceTracker_Int_3 = 0;
      }
      
      private function get isGarbageMonitored() : Boolean
      {
         return _habboTracking.getBoolean("monitor.garbage.collection");
      }
      
      private function get slowUpdateLimit() : int
      {
         return _habboTracking.getInteger("performancetest.slowupdatelimit",1000);
      }
      
      private function get reportInterval() : int
      {
         return _habboTracking.getInteger("performancetest.interval",60);
      }
      
      private function get reportLimit() : int
      {
         return _habboTracking.getInteger("performancetest.reportlimit",10);
      }
      
      private function get meanDevianceLimit() : Number
      {
         return _habboTracking.propertyExists("performancetest.distribution.deviancelimit.percent") ? Number(_habboTracking.getProperty("performancetest.distribution.deviancelimit.percent")) : 10;
      }
      
      private function get useDistribution() : Boolean
      {
         return _habboTracking.getBoolean("performancetest.distribution.enabled");
      }
   }
}

