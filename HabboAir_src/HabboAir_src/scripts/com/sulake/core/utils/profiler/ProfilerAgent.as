package com.sulake.core.utils.profiler
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import flash.utils.getQualifiedClassName;
   
   public class ProfilerAgent extends ProfilerAgentTask implements IComponentInterfaceQueue
   {
      protected var _receiver:IProfiler_1;
      
      public function ProfilerAgent(param1:IProfiler_1)
      {
         _receiver = param1;
         var _loc2_:String = getQualifiedClassName(_receiver);
         super(_loc2_.slice(_loc2_.lastIndexOf(":") + 1,_loc2_.length));
      }
      
      public function get receiver() : IProfiler_1
      {
         return _receiver;
      }
      
      override public function dispose() : void
      {
         _receiver = null;
         super.dispose();
      }
      
      public function update(param1:int) : void
      {
         if(!paused)
         {
            super.start();
            _receiver.update(param1);
            super.stop();
         }
      }
   }
}

