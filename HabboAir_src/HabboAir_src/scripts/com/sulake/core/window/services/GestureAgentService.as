package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GestureAgentService implements IGestureAgentService, IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      protected var _working:Boolean;
      
      protected var _window:IWindowModel;
      
      protected var UnknownVarFromGestureAgentService_Timer_1:Timer;
      
      protected var UnknownVarFromGestureAgentService_Uint_1:uint = 0;
      
      protected var _callback:Function;
      
      protected var UnknownVarFromGestureAgentService_Int_1:int;
      
      protected var UnknownVarFromGestureAgentService_Int_2:int;
      
      public function GestureAgentService()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         end(_window);
         _disposed = true;
      }
      
      public function begin(param1:IWindowModel, param2:Function, param3:uint, param4:int, param5:int) : IWindowModel
      {
         UnknownVarFromGestureAgentService_Uint_1 = param3;
         var _loc6_:IWindowModel = _window;
         if(_window != null)
         {
            end(_window);
         }
         if(param1 && !param1.disposed)
         {
            _window = param1;
            _window.addEventListener("WE_DESTROYED",clientWindowDestroyed);
            _callback = param2;
            _working = true;
            UnknownVarFromGestureAgentService_Int_1 = param4;
            UnknownVarFromGestureAgentService_Int_2 = param5;
            UnknownVarFromGestureAgentService_Timer_1 = new Timer(40,0);
            UnknownVarFromGestureAgentService_Timer_1.addEventListener("timer",operate);
            UnknownVarFromGestureAgentService_Timer_1.start();
         }
         return _loc6_;
      }
      
      protected function operate(param1:TimerEvent) : void
      {
         UnknownVarFromGestureAgentService_Int_1 *= 0.75;
         UnknownVarFromGestureAgentService_Int_2 *= 0.75;
         if(Math.abs(UnknownVarFromGestureAgentService_Int_1) <= 1 && Math.abs(UnknownVarFromGestureAgentService_Int_2) <= 1)
         {
            end(_window);
         }
         else if(_callback != null)
         {
            _callback(UnknownVarFromGestureAgentService_Int_1,UnknownVarFromGestureAgentService_Int_2);
         }
      }
      
      public function end(param1:IWindowModel) : IWindowModel
      {
         var _loc2_:IWindowModel = _window;
         if(UnknownVarFromGestureAgentService_Timer_1)
         {
            UnknownVarFromGestureAgentService_Timer_1.stop();
            UnknownVarFromGestureAgentService_Timer_1.removeEventListener("timer",operate);
            UnknownVarFromGestureAgentService_Timer_1 = null;
         }
         if(_working)
         {
            if(_window == param1)
            {
               if(!_window.disposed)
               {
                  _window.removeEventListener("WE_DESTROYED",clientWindowDestroyed);
               }
               _window = null;
               _working = false;
            }
         }
         return _loc2_;
      }
      
      private function clientWindowDestroyed(param1:WindowEvent) : void
      {
         end(_window);
      }
   }
}

