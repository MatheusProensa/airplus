package com.sulake.core.runtime
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.profiler.ProfilerAgent;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import flash.events.Event;
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   internal class Profiler extends Component implements IProfiler_2
   {
      public static const PROFILER_START:String = "PROFILER_START";
      
      public static const PROFILER_STOP:String = "PROFILER_STOP";
      
      private var UnknownVarFromProfiler_Dictionary_1:Dictionary = new Dictionary(true);
      
      private var _startTime:int;
      
      private var _roundTime:int;
      
      public function Profiler(param1:IComponent_2)
      {
         super(param1,0,null);
      }
      
      public function get numAssetLibraryInstances() : uint
      {
         return AssetLibrary.numAssetLibraryInstances;
      }
      
      public function get numBitmapAssetInstances() : uint
      {
         return BitmapDataAsset.instances;
      }
      
      public function get numAllocatedBitmapDataBytes() : uint
      {
         return BitmapDataAsset.allocatedByteCount;
      }
      
      public function get numTrackedBitmapDataInstances() : uint
      {
         return TrackedBitmapData.numInstances;
      }
      
      public function get numTrackedBitmapDataBytes() : uint
      {
         return TrackedBitmapData.allocatedByteCount;
      }
      
      override public function dispose() : void
      {
         var _loc1_:Object = null;
         if(!disposed)
         {
            for(_loc1_ in UnknownVarFromProfiler_Dictionary_1)
            {
               IComponentInterfaceQueue(UnknownVarFromProfiler_Dictionary_1[_loc1_]).dispose();
               delete UnknownVarFromProfiler_Dictionary_1[_loc1_];
            }
            super.dispose();
         }
      }
      
      public function gc() : void
      {
         System.pauseForGCIfCollectionImminent(0.25);
      }
      
      public function start() : void
      {
         events.dispatchEvent(new Event("PROFILER_START",false,false));
         _startTime = getTimer();
      }
      
      public function stop() : void
      {
         _roundTime = getTimer() - _startTime;
         events.dispatchEvent(new Event("PROFILER_STOP",false,false));
      }
      
      public function update(param1:IProfiler_1, param2:uint) : void
      {
         getProfilerAgentForReceiver(param1).update(param2);
      }
      
      public function get numProfilerAgents() : uint
      {
         var _loc1_:uint = 0;
         for(var _loc2_ in UnknownVarFromProfiler_Dictionary_1)
         {
            if(!IComponentInterfaceQueue(_loc2_).disposed)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getProfilerAgentsInArray() : Array
      {
         var _loc2_:IProfiler_1 = null;
         var _loc1_:Array = [];
         for(var _loc3_ in UnknownVarFromProfiler_Dictionary_1)
         {
            _loc2_ = _loc3_ as IProfiler_1;
            if(IComponentInterfaceQueue(_loc3_).disposed)
            {
               IComponentInterfaceQueue(UnknownVarFromProfiler_Dictionary_1[_loc3_]).dispose();
               delete UnknownVarFromProfiler_Dictionary_1[_loc3_];
            }
            else
            {
               _loc1_.push(UnknownVarFromProfiler_Dictionary_1[_loc3_]);
            }
         }
         return _loc1_;
      }
      
      public function getProfilerAgentForReceiver(param1:IProfiler_1) : ProfilerAgent
      {
         var _loc2_:ProfilerAgent = UnknownVarFromProfiler_Dictionary_1[param1];
         return _loc2_ ?? addProfilerAgentForReceiver(param1);
      }
      
      public function addProfilerAgentForReceiver(param1:IProfiler_1) : ProfilerAgent
      {
         if(UnknownVarFromProfiler_Dictionary_1[param1] != null)
         {
            throw new Error("Profiler for receiver already exists!");
         }
         var _loc2_:ProfilerAgent = new ProfilerAgent(param1);
         UnknownVarFromProfiler_Dictionary_1[param1] = _loc2_;
         return _loc2_;
      }
      
      public function addStartEventListener(param1:Function) : void
      {
         events.addEventListener("PROFILER_START",param1);
      }
      
      public function addStopEventListener(param1:Function) : void
      {
         events.addEventListener("PROFILER_STOP",param1);
      }
      
      public function removeStartEventListener(param1:Function) : void
      {
         events.removeEventListener("PROFILER_START",param1);
      }
      
      public function removeStopEventListener(param1:Function) : void
      {
         events.removeEventListener("PROFILER_STOP",param1);
      }
   }
}

