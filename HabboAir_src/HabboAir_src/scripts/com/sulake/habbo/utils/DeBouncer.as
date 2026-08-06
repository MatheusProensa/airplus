package com.sulake.habbo.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class DeBouncer implements IComponentInterfaceQueue
   {
      private var UnknownVarFromDeBouncer_Int_1:int = 0;
      
      private var _tolerateImmediateTimeout:int;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromDeBouncer_Timer_1:Timer;
      
      private var _callback:Function;
      
      public function DeBouncer(param1:int, param2:int, param3:Function)
      {
         super();
         _tolerateImmediateTimeout = param2;
         this._callback = param3;
         UnknownVarFromDeBouncer_Timer_1 = new Timer(param1,1);
         UnknownVarFromDeBouncer_Timer_1.addEventListener("timerComplete",onTimerComplete);
      }
      
      public function trigger(param1:Boolean = false) : void
      {
         if(param1 || UnknownVarFromDeBouncer_Int_1 < getTimer() - _tolerateImmediateTimeout)
         {
            UnknownVarFromDeBouncer_Timer_1.reset();
            execute();
            return;
         }
         UnknownVarFromDeBouncer_Timer_1.reset();
         UnknownVarFromDeBouncer_Timer_1.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         execute();
      }
      
      private function execute() : void
      {
         UnknownVarFromDeBouncer_Int_1 = getTimer();
         _callback();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromDeBouncer_Timer_1.stop();
         UnknownVarFromDeBouncer_Timer_1.removeEventListener("timerComplete",execute);
         UnknownVarFromDeBouncer_Timer_1 = null;
         _callback = null;
         _tolerateImmediateTimeout = 0;
         UnknownVarFromDeBouncer_Int_1 = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

