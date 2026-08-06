package com.sulake.core.utils.profiler
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.utils.getTimer;
   
   public class ProfilerAgentTask implements IComponentInterfaceQueue
   {
      private var _name:String;
      
      private var _rounds:uint;
      
      private var _total:int;
      
      private var _latest:int;
      
      private var _average:Number;
      
      private var _caption:String;
      
      private var _running:Boolean;
      
      private var _disposed:Boolean = false;
      
      private var _children:Array;
      
      private var _startTime:uint;
      
      private var _paused:Boolean = false;
      
      public function ProfilerAgentTask(param1:String, param2:String = "")
      {
         super();
         _name = param1;
         _rounds = 0;
         _average = 0;
         _running = false;
         _children = [];
         _caption = param2;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
         }
      }
      
      public function start() : void
      {
         if(!_running)
         {
            _startTime = getTimer();
            _running = true;
         }
      }
      
      public function stop() : void
      {
         if(_running)
         {
            _latest = getTimer() - _startTime;
            _rounds++;
            _total += _latest;
            _average = _total / _rounds;
            _running = false;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get rounds() : uint
      {
         return _rounds;
      }
      
      public function get total() : int
      {
         return _total;
      }
      
      public function get latest() : int
      {
         return _latest;
      }
      
      public function get average() : Number
      {
         return _average;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
      
      public function set caption(param1:String) : void
      {
         _caption = caption;
      }
      
      public function get running() : Boolean
      {
         return _running;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get paused() : Boolean
      {
         return _paused;
      }
      
      public function set paused(param1:Boolean) : void
      {
         _paused = param1;
      }
      
      public function get numSubTasks() : uint
      {
         return _children.length;
      }
      
      public function addSubTask(param1:ProfilerAgentTask) : void
      {
         if(getSubTaskByName(param1.name) != null)
         {
            throw new Error("Component profiler task with name \"" + param1.name + "\" already exists!");
         }
         _children.push(param1);
      }
      
      public function removeSubTask(param1:ProfilerAgentTask) : ProfilerAgentTask
      {
         var _loc2_:int = int(_children.indexOf(param1));
         if(_loc2_ > -1)
         {
            _children.splice(_loc2_,1);
         }
         return param1;
      }
      
      public function getSubTaskAt(param1:uint) : ProfilerAgentTask
      {
         return _children[param1] as ProfilerAgentTask;
      }
      
      public function getSubTaskByName(param1:String) : ProfilerAgentTask
      {
         var _loc2_:ProfilerAgentTask = null;
         var _loc3_:uint = _children.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _children[_loc4_++] as ProfilerAgentTask;
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

