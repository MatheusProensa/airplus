package com.sulake.core.runtime.events
{
   import com.sulake.core.Core;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [SecureSWF(rename="false")]
   public class EventDispatcherWrapper implements IEventDispatcher, IComponentInterfaceQueue
   {
      private static const UnknownConstFromEventDispatcherWrapper_Uint_1:uint = 0;
      
      private static const UnknownConstFromEventDispatcherWrapper_Uint_2:uint = 1;
      
      private static const UnknownConstFromEventDispatcherWrapper_Uint_3:uint = 2;
      
      protected var _disposed:Boolean = false;
      
      private var UnknownVarFromEventDispatcherWrapper_EventDispatcher_1:EventDispatcher;
      
      private var UnknownVarFromEventDispatcherWrapper_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromEventDispatcherWrapper_Uint_1:uint;
      
      private var _error:Error;
      
      public function EventDispatcherWrapper(param1:IEventDispatcher = null)
      {
         super();
         UnknownVarFromEventDispatcherWrapper_EventDispatcher_1 = new EventDispatcher(!!param1 ? param1 : this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get error() : Error
      {
         return _error;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         var _loc8_:Array = UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1];
         var _loc6_:EventListenerStruct = new EventListenerStruct(param2,param3,param4,param5);
         if(!_loc8_)
         {
            _loc8_ = [_loc6_];
            UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1] = _loc8_;
            UnknownVarFromEventDispatcherWrapper_EventDispatcher_1.addEventListener(param1,eventProcessor);
         }
         else
         {
            for each(var _loc7_ in _loc8_)
            {
               if(_loc7_.callback == param2 && _loc7_.useCapture == param3)
               {
                  return;
               }
               if(param4 > _loc7_.priority)
               {
                  _loc8_.splice(_loc8_.indexOf(_loc7_),0,_loc6_);
                  return;
               }
            }
            _loc8_.push(_loc6_);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         var _loc5_:Array = null;
         var _loc6_:* = 0;
         if(!_disposed)
         {
            _loc5_ = UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1];
            if(_loc5_)
            {
               _loc6_ = 0;
               for each(var _loc4_ in _loc5_)
               {
                  if(_loc4_.callback == param2 && _loc4_.useCapture == param3)
                  {
                     _loc5_.splice(_loc6_,1);
                     _loc4_.callback = null;
                     if(_loc5_.length == 0)
                     {
                        delete UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1];
                        UnknownVarFromEventDispatcherWrapper_EventDispatcher_1.removeEventListener(param1,eventProcessor);
                     }
                     return;
                  }
                  _loc6_++;
               }
            }
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         if(!_disposed)
         {
            UnknownVarFromEventDispatcherWrapper_Uint_1 = 0;
            UnknownVarFromEventDispatcherWrapper_EventDispatcher_1.dispatchEvent(param1);
            if(UnknownVarFromEventDispatcherWrapper_Uint_1 == 2)
            {
               if(_error != null)
               {
                  Core.crash("Error caught when handling " + getQualifiedClassName(param1) + ": " + _error.message,_error.errorID,_error);
               }
               else
               {
                  Core.crash("Error caught when handling " + getQualifiedClassName(param1) + ". No error data available!",0,_error);
               }
            }
            return UnknownVarFromEventDispatcherWrapper_Uint_1 == 0;
         }
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _disposed ? false : UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1] != null;
      }
      
      public function callEventListeners(param1:String) : void
      {
         var _loc3_:Array = UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1];
         if(_loc3_)
         {
            for each(var _loc2_ in _loc3_)
            {
               _loc2_.callback(null);
            }
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return _disposed ? false : UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1] != null;
      }
      
      private function eventProcessor(param1:Event) : void
      {
         var _loc4_:Function = null;
         var _loc5_:Array = null;
         var _loc3_:Array = UnknownVarFromEventDispatcherWrapper_Dictionary_1[param1.type];
         if(_loc3_)
         {
            _loc5_ = [];
            for each(var _loc2_ in _loc3_)
            {
               _loc5_.push(_loc2_.callback);
            }
            while(true)
            {
               if(_loc5_.length > 0)
               {
                  try
                  {
                     _loc4_ = _loc5_.shift();
                     _loc4_(param1);
                  }
                  catch(e:Error)
                  {
                     Logger.log(e.getStackTrace());
                     UnknownVarFromEventDispatcherWrapper_Uint_1 = 2;
                     _error = e;
                     break;
                  }
                  continue;
                  break;
               }
            }
            return;
         }
         UnknownVarFromEventDispatcherWrapper_Uint_1 = param1.isDefaultPrevented() ? 1 : 0;
      }
      
      public function dispose() : void
      {
         var _loc2_:Array = null;
         if(!_disposed)
         {
            for(var _loc3_ in UnknownVarFromEventDispatcherWrapper_Dictionary_1)
            {
               _loc2_ = UnknownVarFromEventDispatcherWrapper_Dictionary_1[_loc3_] as Array;
               for each(var _loc1_ in _loc2_)
               {
                  _loc1_.callback = null;
               }
               delete UnknownVarFromEventDispatcherWrapper_Dictionary_1[_loc3_];
               UnknownVarFromEventDispatcherWrapper_EventDispatcher_1.removeEventListener(_loc3_,eventProcessor);
            }
            UnknownVarFromEventDispatcherWrapper_Dictionary_1 = null;
            UnknownVarFromEventDispatcherWrapper_EventDispatcher_1 = null;
            _disposed = true;
         }
      }
   }
}

