package com.sulake.core.window.events
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.EventListenerStruct;
   import com.sulake.core.window.IWindowModel;
   import flash.utils.Dictionary;
   
   public class WindowEventDispatcher implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromWindowEventDispatcher_Uint_1:uint = 0;
      
      private static const UnknownConstFromWindowEventDispatcher_Uint_2:uint = 1;
      
      private static const UnknownConstFromWindowEventDispatcher_Uint_3:uint = 2;
      
      protected var _disposed:Boolean = false;
      
      private var UnknownVarFromWindowEventDispatcher_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromWindowEventDispatcher_Uint_1:uint;
      
      private var _error:Error;
      
      public function WindowEventDispatcher(param1:IWindowModel)
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get error() : Error
      {
         return _error;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:int = 0) : void
      {
         var _loc6_:Array = UnknownVarFromWindowEventDispatcher_Dictionary_1[param1];
         var _loc4_:EventListenerStruct = new EventListenerStruct(param2,false,param3);
         if(!_loc6_)
         {
            _loc6_ = [_loc4_];
            UnknownVarFromWindowEventDispatcher_Dictionary_1[param1] = _loc6_;
         }
         else
         {
            for each(var _loc5_ in _loc6_)
            {
               if(_loc5_.callback == param2)
               {
                  return;
               }
               if(param3 > _loc5_.priority)
               {
                  _loc6_.splice(_loc6_.indexOf(_loc5_),0,_loc4_);
                  return;
               }
            }
            _loc6_.push(_loc4_);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         if(!_disposed)
         {
            _loc4_ = UnknownVarFromWindowEventDispatcher_Dictionary_1[param1];
            if(_loc4_)
            {
               _loc5_ = 0;
               for each(var _loc3_ in _loc4_)
               {
                  if(_loc3_.callback == param2)
                  {
                     _loc4_.splice(_loc5_,1);
                     _loc3_.callback = null;
                     if(_loc4_.length == 0)
                     {
                        delete UnknownVarFromWindowEventDispatcher_Dictionary_1[param1];
                     }
                     return;
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      public function dispatchEvent(param1:WindowEvent) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Function = null;
         var _loc5_:Array = null;
         if(!_disposed)
         {
            UnknownVarFromWindowEventDispatcher_Uint_1 = 0;
            _loc3_ = UnknownVarFromWindowEventDispatcher_Dictionary_1[param1.type];
            if(_loc3_)
            {
               _loc5_ = [];
               for each(var _loc2_ in _loc3_)
               {
                  _loc5_.push(_loc2_.callback);
               }
               while(_loc5_.length > 0)
               {
                  _loc4_ = _loc5_.shift();
                  _loc4_(param1);
               }
            }
            UnknownVarFromWindowEventDispatcher_Uint_1 = param1.isDefaultPrevented() ? 1 : 0;
            return UnknownVarFromWindowEventDispatcher_Uint_1 == 0;
         }
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _disposed ? false : UnknownVarFromWindowEventDispatcher_Dictionary_1[param1] != null;
      }
      
      public function dispose() : void
      {
         var _loc2_:Array = null;
         if(!_disposed)
         {
            for(var _loc3_ in UnknownVarFromWindowEventDispatcher_Dictionary_1)
            {
               _loc2_ = UnknownVarFromWindowEventDispatcher_Dictionary_1[_loc3_] as Array;
               for each(var _loc1_ in _loc2_)
               {
                  _loc1_.callback = null;
               }
               delete UnknownVarFromWindowEventDispatcher_Dictionary_1[_loc3_];
            }
            UnknownVarFromWindowEventDispatcher_Dictionary_1 = null;
            _disposed = true;
         }
      }
   }
}

