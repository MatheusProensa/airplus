package com.sulake.core.runtime
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.runtime.events.LockEvent;
   import com.sulake.core.runtime.exceptions.*;
   import com.sulake.core.utils.ClassUtils;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [SecureSWF(rename="true")]
   public class Component implements IUnknown, IComponent_1
   {
      public static const COMPONENT_EVENT_RUNNING:String = "COMPONENT_EVENT_RUNNING";
      
      public static const COMPONENT_EVENT_DISPOSING:String = "COMPONENT_EVENT_DISPOSING";
      
      public static const COMPONENT_EVENT_WARNING:String = "COMPONENT_EVENT_WARNING";
      
      public static const COMPONENT_EVENT_ERROR:String = "COMPONENT_EVENT_ERROR";
      
      public static const COMPONENT_EVENT_DEBUG:String = "COMPONENT_EVENT_DEBUG";
      
      public static const COMPONENT_EVENT_UNLOCKED:String = "COMPONENT_EVENT_UNLOCKED";
      
      public static const COMPONENT_EVENT_REBOOT:String = "COMPONENT_EVENT_REBOOT";
      
      protected static const INTERNAL_EVENT_UNLOCKED:String = "_INTERNAL_EVENT_UNLOCKED";
      
      public static const COMPONENT_FLAG_NULL:uint = 0;
      
      public static const COMPONENT_FLAG_INTERFACE:uint = 1;
      
      public static const COMPONENT_FLAG_CONTEXT:uint = 2;
      
      public static const COMPONENT_FLAG_DISPOSABLE:uint = 4;
      
      protected var _references:uint = 0;
      
      protected var _lastError:String = "";
      
      protected var _lastDebugMessage:String = "";
      
      protected var _lastWarningMessage:String = "";
      
      private var _assets:IAssetLibraryCollection;
      
      private var _events:EventDispatcherWrapper;
      
      private var _flags:uint;
      
      private var UnknownVarFromComponent_InterfaceStructList_1:InterfaceStructList;
      
      private var _context:IComponent_2 = null;
      
      private var _disposed:Boolean = false;
      
      private var _locked:Boolean = false;
      
      private var UnknownVarFromComponent_Int_1:int = 1;
      
      private var _requiredDependencyIids:Vector.<String>;
      
      private var UnknownVarFromComponent_Vector_1:Vector.<Function> = new Vector.<Function>(0);
      
      public function Component(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super();
         _flags = param2;
         UnknownVarFromComponent_InterfaceStructList_1 = new InterfaceStructList();
         _events = new EventDispatcherWrapper();
         _context = param1;
         _assets = param3 ?? new AssetLibrary("_internal_asset_library");
         if(_context == null)
         {
            throw new InvalidComponentException("IContext not provided to Component\'s constructor!");
         }
         if(dependencies.length > 0)
         {
            lock();
         }
         _requiredDependencyIids = new Vector.<String>(0);
         for each(var _loc4_ in dependencies)
         {
            if(_loc4_.isRequired)
            {
               _requiredDependencyIids.push(ClassUtils.getSimpleQualifiedClassName(_loc4_.identifier));
            }
            injectDependency(_loc4_.identifier,_loc4_.dependencySetter,_loc4_.isRequired,_loc4_.eventListeners);
         }
         allDependenciesRequested();
      }
      
      public static function getInterfaceStructList(param1:Component) : InterfaceStructList
      {
         return param1.UnknownVarFromComponent_InterfaceStructList_1;
      }
      
      public function get locked() : Boolean
      {
         return _locked;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get context() : IComponent_2
      {
         return _context;
      }
      
      public function get events() : IEventDispatcher
      {
         return _events;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return _assets;
      }
      
      private function injectDependency(param1:IID, param2:Function, param3:Boolean, param4:Array) : void
      {
         var identifier:IID = param1;
         var dependencySetter:Function = param2;
         var isRequired:Boolean = param3;
         var eventListeners:Array = param4;
         if(isRequired)
         {
            UnknownVarFromComponent_Int_1++;
         }
         queueInterface(identifier,(function(param1:Function, param2:Boolean, param3:Array, param4:String):Function
         {
            var setter:Function = param1;
            var required:Boolean = param2;
            var listeners:Array = param3;
            var componentName:String = param4;
            return function(param1:IID, param2:IUnknown):void
            {
               var eventDispatcher:IEventDispatcher;
               var listener:Object;
               var identifier:IID = param1;
               var unknown:IUnknown = param2;
               if(disposed)
               {
                  return;
               }
               if(setter != null)
               {
                  setter(unknown);
               }
               if(listeners != null)
               {
                  eventDispatcher = Component(unknown).events;
                  for each(listener in listeners)
                  {
                     eventDispatcher.addEventListener(listener.type,listener.callback);
                  }
               }
               UnknownVarFromComponent_Vector_1.push((function(param1:IID, param2:IUnknown):Function
               {
                  var iid:IID = param1;
                  var component:IUnknown = param2;
                  return function():void
                  {
                     var _loc2_:IEventDispatcher = null;
                     if(listeners != null)
                     {
                        _loc2_ = Component(component).events;
                        if(_loc2_ != null)
                        {
                           for each(var _loc1_ in listeners)
                           {
                              _loc2_.removeEventListener(_loc1_.type,_loc1_.callback);
                           }
                        }
                     }
                     if(setter != null)
                     {
                        setter(null);
                     }
                     component.release(iid);
                  };
               })(identifier,unknown));
               if(required)
               {
                  allDependenciesRequested(ClassUtils.getSimpleQualifiedClassName(identifier));
               }
            };
         })(dependencySetter,isRequired,eventListeners,ClassUtils.getSimpleQualifiedClassName(this)));
      }
      
      private function allDependenciesRequested(param1:String = "") : void
      {
         UnknownVarFromComponent_Int_1--;
         if(param1 != "" && _requiredDependencyIids.indexOf(param1) > -1)
         {
            _requiredDependencyIids.splice(_requiredDependencyIids.indexOf(param1),1);
         }
         if(UnknownVarFromComponent_Int_1 == 0)
         {
            initComponent();
            unlock();
         }
      }
      
      protected function get allRequiredDependenciesInjected() : Boolean
      {
         return UnknownVarFromComponent_Int_1 == 0;
      }
      
      protected function get dependencies() : Vector.<ComponentDependency>
      {
         return new Vector.<ComponentDependency>(0);
      }
      
      protected function initComponent() : void
      {
      }
      
      public function queueInterface(param1:IID, param2:Function = null) : IUnknown
      {
         var _loc3_:InterfaceStruct = UnknownVarFromComponent_InterfaceStructList_1.getStructByInterface(param1);
         if(_loc3_ == null)
         {
            return _context.queueInterface(param1,param2);
         }
         if(_disposed)
         {
            throw new ComponentDisposedException("Failed to queue interface trough disposed Component \"" + ClassUtils.getSimpleQualifiedClassName(this) + "\"!");
         }
         if(_locked)
         {
            return null;
         }
         _loc3_.reserve();
         var _loc4_:IUnknown = _loc3_.unknown as IUnknown;
         if(param2 != null)
         {
            param2(param1,_loc4_);
         }
         return _loc4_;
      }
      
      public function release(param1:IID) : uint
      {
         if(_disposed)
         {
            return 0;
         }
         var _loc2_:InterfaceStruct = UnknownVarFromComponent_InterfaceStructList_1.getStructByInterface(param1);
         if(_loc2_ == null)
         {
            _lastError = "Attempting to release unknown interface:" + param1 + "!";
            throw new Error(_lastError);
         }
         var _loc3_:uint = _loc2_.release();
         if(_flags & 4)
         {
            if(_loc3_ == 0)
            {
               if(UnknownVarFromComponent_InterfaceStructList_1.getTotalReferenceCount() == 0)
               {
                  _context.detachComponent(this);
                  this.dispose();
               }
            }
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            for each(var _loc1_ in UnknownVarFromComponent_Vector_1)
            {
               _loc1_();
            }
            UnknownVarFromComponent_Vector_1 = null;
            _events.dispatchEvent(new Event("COMPONENT_EVENT_DISPOSING"));
            _events = null;
            UnknownVarFromComponent_InterfaceStructList_1.dispose();
            UnknownVarFromComponent_InterfaceStructList_1 = null;
            _assets.dispose();
            _assets = null;
            _context = null;
            _references = 0;
            _disposed = true;
         }
      }
      
      public function purge() : void
      {
      }
      
      final protected function lock() : void
      {
         if(!_locked)
         {
            _locked = true;
         }
      }
      
      final protected function unlock() : void
      {
         if(_locked)
         {
            _locked = false;
            _events.dispatchEvent(new LockEvent("_INTERNAL_EVENT_UNLOCKED",this));
         }
      }
      
      public function toString() : String
      {
         return "[component " + ClassUtils.getSimpleQualifiedClassName(this) + " refs: " + _references + "]";
      }
      
      public function toXMLString(param1:uint = 0) : String
      {
         var _loc7_:* = 0;
         var _loc3_:InterfaceStruct = null;
         var _loc8_:* = 0;
         var _loc4_:String = "";
         _loc7_ = 0;
         while(_loc7_ < param1)
         {
            _loc4_ += "\t";
            _loc7_++;
         }
         var _loc5_:String = getQualifiedClassName(this);
         var _loc2_:String = "";
         _loc2_ += _loc4_ + "<component class=\"" + _loc5_ + "\">\n";
         var _loc6_:uint = UnknownVarFromComponent_InterfaceStructList_1.length;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc3_ = UnknownVarFromComponent_InterfaceStructList_1.getStructByIndex(_loc8_);
            _loc2_ += _loc4_ + "\t<interface iid=\"" + _loc3_.iis + "\" refs=\"" + _loc3_.references + "\"/>\n";
            _loc8_++;
         }
         return _loc2_ + (_loc4_ + "</component>\n");
      }
      
      public function get requiredDependencyIids() : Vector.<String>
      {
         return _requiredDependencyIids;
      }
      
      public function registerUpdateReceiver(param1:IProfiler_1, param2:uint) : void
      {
         if(!_disposed)
         {
            _context.registerUpdateReceiver(param1,param2);
         }
      }
      
      public function removeUpdateReceiver(param1:IProfiler_1) : void
      {
         if(!_disposed)
         {
            _context.removeUpdateReceiver(param1);
         }
      }
      
      public function get flags() : uint
      {
         return _flags;
      }
      
      public function propertyExists(param1:String) : Boolean
      {
         return !!_context.configuration ? _context.configuration.propertyExists(param1) : false;
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return !!_context.configuration ? _context.configuration.getProperty(param1,param2) : "";
      }
      
      public function setProperty(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(_context.configuration)
         {
            _context.configuration.setProperty(param1,param2,param3,param4);
         }
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         return !!_context.configuration ? _context.configuration.getBoolean(param1) : false;
      }
      
      public function getInteger(param1:String, param2:int) : int
      {
         return !!_context.configuration ? _context.configuration.getInteger(param1,param2) : 0;
      }
      
      public function interpolate(param1:String) : String
      {
         return !!_context.configuration ? _context.configuration.interpolate(param1) : "";
      }
      
      public function updateUrlProtocol(param1:String) : String
      {
         return !!_context.configuration ? _context.configuration.updateUrlProtocol(param1) : "";
      }
   }
}

