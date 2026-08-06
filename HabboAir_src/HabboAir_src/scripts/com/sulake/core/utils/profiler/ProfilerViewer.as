package com.sulake.core.utils.profiler
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_2;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ProfilerViewer extends TextField implements IComponentInterfaceQueue
   {
      protected var _disposed:Boolean = false;
      
      private var _profiler:IProfiler_2;
      
      public function ProfilerViewer(param1:IProfiler_2)
      {
         var _loc2_:TextFormat = new TextFormat("Courier New",8);
         defaultTextFormat = _loc2_;
         setTextFormat(_loc2_);
         textColor = 16777215;
         width = 10;
         height = 10;
         autoSize = "left";
         mouseEnabled = false;
         selectable = false;
         super();
         if(param1)
         {
            _profiler = param1;
            _profiler.addStopEventListener(refresh);
         }
      }
      
      private static function padAlign(param1:String, param2:int, param3:String = " ", param4:Boolean = false) : String
      {
         var _loc6_:int = 0;
         var _loc5_:int = param2 - param1.length;
         if(_loc5_ <= 0)
         {
            return param1.substring(0,param2);
         }
         var _loc7_:String = "";
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ += param3;
            _loc6_++;
         }
         return param4 ? _loc7_ + param1 : param1 + _loc7_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set profiler(param1:IProfiler_2) : void
      {
         if(!_profiler && param1)
         {
            _profiler = param1;
            _profiler.addStopEventListener(refresh);
         }
      }
      
      public function get profiler() : IProfiler_2
      {
         return _profiler;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(parent != null)
            {
               parent.removeChild(this);
            }
            if(_profiler)
            {
               _profiler.removeStopEventListener(refresh);
               _profiler = null;
            }
            _disposed = true;
         }
      }
      
      public function refresh() : void
      {
         text = padAlign("task",30) + "|" + padAlign("#rounds",10," ",true) + "|" + padAlign("latest ms",10," ",true) + "|" + padAlign("average ms",10," ",true) + "|" + padAlign("total ms",10," ",true) + "|\r" + padAlign("",30,"-") + "|" + padAlign("",10,"-") + "|" + padAlign("",10,"-") + "|" + padAlign("",10,"-") + "|" + padAlign("",10,"-") + "|\r";
         var _loc1_:Array = _profiler.getProfilerAgentsInArray();
         while(_loc1_.length > 0)
         {
            recursiveUpdate(_loc1_.pop(),0);
         }
         if(parent)
         {
            parent.swapChildren(this,parent.getChildAt(parent.numChildren - 1));
         }
      }
      
      private function recursiveUpdate(param1:ProfilerAgentTask, param2:uint) : void
      {
         var _loc3_:* = 0;
         text += padAlign(param1.name,30) + "|" + padAlign(String(param1.rounds),10) + "|" + padAlign(String(param1.latest),10) + "|" + padAlign(String(param1.average),10) + "|" + padAlign(String(param1.total),10) + "|\r";
         _loc3_ = 0;
         while(_loc3_ < param1.numSubTasks)
         {
            recursiveUpdate(param1.getSubTaskAt(_loc3_),param2 + 1);
            _loc3_++;
         }
      }
   }
}

