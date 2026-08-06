package com.sulake.core.runtime
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.runtime.events.LibraryProgressEvent;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import com.sulake.core.utils.LibraryLoaderQueue;
   import com.sulake.core.utils.PurgeTrigger;
   import com.sulake.core.utils.UnknownICoreUtils1;
   import com.sulake.core.utils.profiler.ProfilerViewer;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public final class CoreComponentContext extends ComponentContext implements ICoreComponentContext
   {
      private static const NUM_UPDATE_RECEIVER_LEVELS:uint = 3;
      
      private static const CONFIG_XML_NODE_ASSET_LIBRARIES:String = "asset-libraries";
      
      private static const CONFIG_XML_NODE_ASSET_LIBRARY:String = "library";
      
      private static const CONFIG_XML_NODE_SERVICE_LIBRARIES:String = "service-libraries";
      
      private static const CONFIG_XML_NODE_SERVICE_LIBRARY:String = "library";
      
      private static const CONFIG_XML_NODE_COMPONENT_LIBRARIES:String = "component-libraries";
      
      private static const CONFIG_XML_NODE_COMPONENT_LIBRARY:String = "library";
      
      private static var _fileProxy:UnknownICoreUtils1;
      
      private var UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1:LibraryLoaderQueue;
      
      private var _loadingEventDelegate:IEventDispatcher;
      
      private var _numberOfFilesInConfig:uint;
      
      private var UnknownVarFromCoreComponentContext_Function_1:Function;
      
      private var UnknownVarFromCoreComponentContext_Profiler_1:Profiler;
      
      private var UnknownVarFromCoreComponentContext_IUnknownCoreRuntime1_1_1:IUnknownCoreRuntime1_1;
      
      private var UnknownVarFromCoreComponentContext_Array_1:Array;
      
      private var UnknownVarFromCoreComponentContext_Array_2:Array;
      
      private var _lastUpdateTimeMs:uint;
      
      private var UnknownVarFromCoreComponentContext_Uint_1:uint = 0;
      
      private var _hibernationLevel:int = -1;
      
      private var _hibernationUpdateFrequency:uint;
      
      private var _arguments:Dictionary;
      
      private var _rebootOnNextFrame:Boolean;
      
      public function CoreComponentContext(param1:DisplayObjectContainer, param2:IUnknownCoreRuntime1_1, param3:uint, param4:Dictionary)
      {
         var _loc5_:* = 0;
         super(this,2,new AssetLibraryCollection("_core_assets"));
         if(param4 == null)
         {
            param4 = new Dictionary();
         }
         _arguments = param4;
         UnknownVarFromCoreComponentContext_Uint_1 = param3;
         UnknownVarFromComponentContext_Boolean_1 = (param3 & 0x0F) == 15;
         UnknownVarFromCoreComponentContext_Array_1 = [];
         UnknownVarFromCoreComponentContext_Array_2 = [];
         _displayObjectContainer = param1;
         UnknownVarFromCoreComponentContext_IUnknownCoreRuntime1_1_1 = param2;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            UnknownVarFromCoreComponentContext_Array_1.push([]);
            UnknownVarFromCoreComponentContext_Array_2.push(0);
            _loc5_++;
         }
         _lastUpdateTimeMs = getTimer();
         attachComponent(this,[new IIDCore()]);
         _displayObjectContainer.addEventListener("enterFrame",onEnterFrame);
         switch(param3 & 0x0F)
         {
            case 0:
               debug("Core; using simple frame update handler");
               UnknownVarFromCoreComponentContext_Function_1 = simpleFrameUpdateHandler;
               break;
            case 1:
               debug("Core; using complex frame update handler");
               UnknownVarFromCoreComponentContext_Function_1 = complexFrameUpdateHandler;
               break;
            case 2:
               debug("Core; using profiler frame update handler");
               UnknownVarFromCoreComponentContext_Function_1 = profilerFrameUpdateHandler;
               UnknownVarFromCoreComponentContext_Profiler_1 = new Profiler(this);
               attachComponent(UnknownVarFromCoreComponentContext_Profiler_1,[new IIDProfiler()]);
               _displayObjectContainer.addChild(new ProfilerViewer(UnknownVarFromCoreComponentContext_Profiler_1));
               break;
            case 4:
               debug("Core; using experimental frame update handler");
               UnknownVarFromCoreComponentContext_Function_1 = experimentalFrameUpdateHandler;
               break;
            case 15:
               debug("Core; using debug frame update handler");
               UnknownVarFromCoreComponentContext_Function_1 = debugFrameUpdateHandler;
         }
      }
      
      private static function writeObjectToProxy(param1:String, param2:Object) : Boolean
      {
         var _loc3_:UnknownICoreUtils1 = null;
         var _loc4_:ByteArray = null;
         try
         {
            _loc3_ = Core.instance.fileProxy;
            if(_loc3_)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeObject(param2);
               _loc3_.writeCache(param1,_loc4_);
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when writing Object (" + param1 + ") to IFileProxy: " + e.toString());
            var _loc8_:Boolean = false;
         }
         return _loc8_;
      }
      
      private static function readObjectFromProxy(param1:String) : Object
      {
         var _loc2_:UnknownICoreUtils1 = null;
         var _loc3_:ByteArray = null;
         try
         {
            _loc2_ = Core.instance.fileProxy;
            if(_loc2_)
            {
               _loc3_ = _loc2_.readCache(param1);
               if(_loc3_)
               {
                  return _loc3_.readObject();
               }
            }
            return null;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when reading Object (" + param1 + ") from IFileProxy: " + e.toString());
            var _loc7_:* = null;
         }
         return _loc7_;
      }
      
      public function set fileProxy(param1:UnknownICoreUtils1) : void
      {
         _fileProxy = param1;
      }
      
      public function get fileProxy() : UnknownICoreUtils1
      {
         return _fileProxy;
      }
      
      public function getNumberOfFilesPending() : uint
      {
         return UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1.length;
      }
      
      public function getNumberOfFilesLoaded() : uint
      {
         return _numberOfFilesInConfig - getNumberOfFilesPending();
      }
      
      public function get arguments() : Dictionary
      {
         return _arguments;
      }
      
      public function clearArguments() : void
      {
         _arguments = new Dictionary();
      }
      
      public function initialize() : void
      {
         if(hasLockedComponents())
         {
            events.addEventListener("COMPONENT_EVENT_UNLOCKED",unlockEventHandler);
         }
         else
         {
            doInitialize();
         }
      }
      
      private function unlockEventHandler(param1:Event) : void
      {
         if(!hasLockedComponents())
         {
            events.removeEventListener("COMPONENT_EVENT_UNLOCKED",unlockEventHandler);
            doInitialize();
         }
      }
      
      private function doInitialize() : void
      {
         events.dispatchEvent(new Event("COMPONENT_EVENT_RUNNING"));
         PurgeTrigger.start();
      }
      
      public function hasLockedComponents() : Boolean
      {
         if(UnknownVarFromComponentContext_Vector_1 != null)
         {
            for each(var _loc1_ in UnknownVarFromComponentContext_Vector_1)
            {
               if(_loc1_.locked)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function getLockedComponents() : Array
      {
         var _loc2_:Array = [];
         if(UnknownVarFromComponentContext_Vector_1 != null)
         {
            for each(var _loc1_ in UnknownVarFromComponentContext_Vector_1)
            {
               if(_loc1_.locked)
               {
                  _loc2_.push(_loc1_);
               }
            }
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         var _loc2_:Array = null;
         var _loc1_:* = undefined;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(!disposed)
         {
            debug("Disposing core");
            PurgeTrigger.stop();
            try
            {
               _loc4_ = 0;
               while(_loc4_ < 3)
               {
                  _loc2_ = UnknownVarFromCoreComponentContext_Array_1[_loc4_] as Array;
                  _loc3_ = _loc2_.length;
                  while(_loc3_-- > 0)
                  {
                     _loc1_ = _loc2_.pop();
                     if(_loc1_ is UpdateDelegate)
                     {
                        UpdateDelegate(_loc1_).dispose();
                     }
                  }
                  _loc4_++;
               }
            }
            catch(e:Error)
            {
            }
            if(_displayObjectContainer)
            {
               _displayObjectContainer.removeEventListener("enterFrame",onEnterFrame);
               _displayObjectContainer = null;
            }
            if(UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1 != null)
            {
               UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1.dispose();
               UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1 = null;
            }
            super.dispose();
         }
      }
      
      override public function error(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : Boolean
      {
         super.error(param1,param2,param3,param4);
         UnknownVarFromCoreComponentContext_IUnknownCoreRuntime1_1_1.logError(param1,param2,param3,param4);
         if(param2 && isCrashOnCriticalError && !isExcludedFromCrash(param3))
         {
            dispose();
            return true;
         }
         return false;
      }
      
      private function get isCrashOnCriticalError() : Boolean
      {
         return getBoolean("error_handling.crash_on_critical_error");
      }
      
      private function isExcludedFromCrash(param1:int) : Boolean
      {
         var _loc2_:String = getProperty("error_handling.exclude_crashing");
         if(!_loc2_)
         {
            return false;
         }
         var _loc3_:Array = _loc2_.split(",");
         return _loc3_.indexOf(param1.toString()) != -1;
      }
      
      public function readConfigDocument(param1:XML, param2:IEventDispatcher = null) : void
      {
         var _loc3_:XML = null;
         var _loc7_:XMLList = null;
         var _loc4_:* = null;
         var _loc8_:String = null;
         var _loc5_:LibraryLoader = null;
         var _loc6_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
         debug("Parsing config document");
         _loadingEventDelegate = param2;
         if(UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1 == null)
         {
            UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1 = new LibraryLoaderQueue(UnknownVarFromComponentContext_Boolean_1);
         }
         _loc3_ = param1.child("asset-libraries")[0];
         if(_loc3_ != null)
         {
            _loc7_ = _loc3_.child("library");
            for each(_loc4_ in _loc7_)
            {
               _loc8_ = _loc4_.attribute("url").toString();
               _loc5_ = new LibraryLoader(_loc6_,true,UnknownVarFromComponentContext_Boolean_1);
               assets.loadFromFile(_loc5_,true);
               _loc5_.load(new URLRequest(_loc8_));
               UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1.push(_loc5_);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",updateLoadingProcess);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",errorInLoadingProcess);
               _numberOfFilesInConfig++;
            }
         }
         _loc3_ = param1.child("service-libraries")[0];
         if(_loc3_ != null)
         {
            _loc7_ = _loc3_.child("library");
            for each(_loc4_ in _loc7_)
            {
               _loc8_ = _loc4_.attribute("url").toString();
               _loc5_ = new LibraryLoader(_loc6_,true,UnknownVarFromComponentContext_Boolean_1);
               _loc5_.load(new URLRequest(_loc8_));
               UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1.push(_loc5_);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",updateLoadingProcess);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",errorInLoadingProcess);
               _numberOfFilesInConfig++;
            }
         }
         _loc3_ = param1.child("component-libraries")[0];
         if(_loc3_ != null)
         {
            _loc7_ = _loc3_.child("library");
            for each(_loc4_ in _loc7_)
            {
               _loc8_ = _loc4_.attribute("url").toString();
               _loc5_ = new LibraryLoader(_loc6_,true,UnknownVarFromComponentContext_Boolean_1);
               _loc5_.load(new URLRequest(_loc8_));
               UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1.push(_loc5_);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",updateLoadingProcess);
               _loc5_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",errorInLoadingProcess);
               _numberOfFilesInConfig++;
            }
         }
         if(!disposed)
         {
            updateLoadingProcess();
         }
      }
      
      public function writeDictionaryToProxy(param1:String, param2:Dictionary) : Boolean
      {
         return writeObjectToProxy(param1,param2);
      }
      
      public function readDictionaryFromProxy(param1:String) : Dictionary
      {
         return readObjectFromProxy(param1) as Dictionary;
      }
      
      public function writeXMLToProxy(param1:String, param2:XML) : Boolean
      {
         return writeObjectToProxy(param1,param2);
      }
      
      public function readXMLFromProxy(param1:String) : XML
      {
         return readObjectFromProxy(param1) as XML;
      }
      
      public function readStringFromProxy(param1:String) : String
      {
         var _loc2_:UnknownICoreUtils1 = null;
         var _loc3_:ByteArray = null;
         try
         {
            _loc2_ = Core.instance.fileProxy;
            if(_loc2_)
            {
               _loc3_ = _loc2_.readCache(param1);
               if(_loc3_)
               {
                  return _loc3_.readUTFBytes(_loc3_.length);
               }
            }
            return null;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when reading Object (" + param1 + ") from IFileProxy: " + e.toString());
            var _loc7_:* = null;
         }
         return _loc7_;
      }
      
      public function writeStringToProxy(param1:String, param2:String) : Boolean
      {
         var _loc3_:UnknownICoreUtils1 = null;
         var _loc4_:ByteArray = null;
         try
         {
            _loc3_ = Core.instance.fileProxy;
            if(_loc3_)
            {
               _loc4_ = new ByteArray();
               _loc4_.writeUTFBytes(param2);
               _loc3_.writeCache(param1,_loc4_);
               return true;
            }
            return false;
         }
         catch(e:Error)
         {
            Logger.log("Caught error when writing String (" + param1 + ") to IFileProxy: " + e.toString());
            var _loc8_:Boolean = false;
         }
         return _loc8_;
      }
      
      private function errorInLoadingProcess(param1:LibraryLoaderEvent = null) : void
      {
         var _loc2_:LibraryLoader = LibraryLoader(param1.target);
         error("Failed to download library \"" + _loc2_.url + "\" HTTP status " + param1.status + " bytes loaded " + param1.bytesLoaded + "/" + param1.bytesTotal + " : " + _loc2_.getLastErrorMessage(),true,2);
         if(!disposed)
         {
            updateLoadingProcess(param1);
         }
      }
      
      private function finalizeLoadingEventDelegate() : void
      {
         if(_loadingEventDelegate != null)
         {
            _loadingEventDelegate.dispatchEvent(new Event("complete"));
            _loadingEventDelegate = null;
         }
      }
      
      private function updateLoadingProgress(param1:LibraryLoaderEvent = null) : void
      {
         var _loc2_:LibraryLoader = null;
         if(_loadingEventDelegate != null)
         {
            _loc2_ = param1.target as LibraryLoader;
            _loadingEventDelegate.dispatchEvent(new LibraryProgressEvent(_loc2_.url,param1.bytesLoaded,param1.bytesTotal,_loc2_.elapsedTime));
         }
      }
      
      private function updateLoadingProcess(param1:LibraryLoaderEvent = null) : void
      {
         var _loc2_:LibraryLoader = null;
         var _loc3_:String = null;
         if(param1 != null)
         {
            if(param1.type == "LIBRARY_LOADER_EVENT_COMPLETE" || param1.type == "LIBRARY_LOADER_EVENT_ERROR")
            {
               _loc2_ = param1.target as LibraryLoader;
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",updateLoadingProcess);
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",errorInLoadingProcess);
               _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS",updateLoadingProgress);
               _loc3_ = _loc2_.url;
               debug("Loading library \"" + _loc3_ + "\" " + (param1.type == "LIBRARY_LOADER_EVENT_COMPLETE" ? "ready" : "failed\n" + _loc2_.getLastErrorMessage()));
               _loc2_.dispose();
               if(!disposed)
               {
                  if(_loadingEventDelegate != null)
                  {
                     _loadingEventDelegate.dispatchEvent(new LibraryProgressEvent(_loc2_.url,_numberOfFilesInConfig - UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1.length,_numberOfFilesInConfig,_loc2_.elapsedTime));
                  }
               }
            }
         }
         if(!disposed)
         {
            if(UnknownVarFromCoreComponentContext_LibraryLoaderQueue_1.length == 0)
            {
               finalizeLoadingEventDelegate();
               debug("All libraries loaded, Core is now running");
            }
         }
      }
      
      override public function registerUpdateReceiver(param1:IProfiler_1, param2:uint) : void
      {
         removeUpdateReceiver(param1);
         param2 = uint(param2 >= 3 ? 3 - 1 : param2);
         var _loc3_:int = int(!!UnknownVarFromCoreComponentContext_Profiler_1 ? 2 : UnknownVarFromCoreComponentContext_Uint_1 & 0x0F);
         if(_loc3_ == 4)
         {
            UnknownVarFromCoreComponentContext_Array_1[param2].push(new UpdateDelegate(param1,this,param2));
         }
         else
         {
            UnknownVarFromCoreComponentContext_Array_1[param2].push(param1);
         }
      }
      
      override public function removeUpdateReceiver(param1:IProfiler_1) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         if(disposed)
         {
            return;
         }
         var _loc3_:int = int(!!UnknownVarFromCoreComponentContext_Profiler_1 ? 2 : UnknownVarFromCoreComponentContext_Uint_1 & 0x0F);
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc4_ = UnknownVarFromCoreComponentContext_Array_1[_loc6_] as Array;
            if(_loc3_ == 4)
            {
               for each(var _loc2_ in _loc4_)
               {
                  if(_loc2_.receiver == param1)
                  {
                     _loc2_.dispose();
                     return;
                  }
               }
            }
            else
            {
               _loc5_ = int(_loc4_.indexOf(param1));
               if(_loc5_ > -1)
               {
                  _loc4_[_loc5_] = null;
                  return;
               }
            }
            _loc6_++;
         }
      }
      
      public function hibernate(param1:int, param2:int = 1) : void
      {
         if(!hibernating)
         {
            PurgeTrigger.stop();
            _hibernationLevel = param1;
            _hibernationUpdateFrequency = 1000 / param2;
         }
      }
      
      public function resume() : void
      {
         if(hibernating)
         {
            PurgeTrigger.start();
            _hibernationLevel = -1;
         }
      }
      
      private function get hibernating() : Boolean
      {
         return _hibernationLevel > -1;
      }
      
      private function get maxPriority() : uint
      {
         return hibernating ? _hibernationLevel + 1 : 3;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_rebootOnNextFrame)
         {
            _displayObjectContainer.removeEventListener("enterFrame",onEnterFrame);
            _rebootOnNextFrame = false;
            events.dispatchEvent(new Event("COMPONENT_EVENT_REBOOT"));
            return;
         }
         var _loc3_:uint = uint(getTimer());
         var _loc2_:uint = uint(_loc3_ - _lastUpdateTimeMs);
         if(!hibernating || _loc2_ > _hibernationUpdateFrequency)
         {
            UnknownVarFromCoreComponentContext_Function_1(_loc3_,_loc2_);
            _lastUpdateTimeMs = _loc3_;
         }
      }
      
      private function simpleFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:IProfiler_1 = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc7_ = 0;
         loop0:
         while(_loc7_ < maxPriority)
         {
            UnknownVarFromCoreComponentContext_Array_2[_loc7_] = 0;
            _loc4_ = UnknownVarFromCoreComponentContext_Array_1[_loc7_];
            _loc6_ = 0;
            _loc5_ = _loc4_.length;
            while(true)
            {
               if(_loc6_ == _loc5_)
               {
                  _loc7_++;
                  continue loop0;
               }
               _loc3_ = IProfiler_1(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     _loc3_.update(param2);
                  }
                  catch(e:Error)
                  {
                     Logger.log(e.getStackTrace());
                     if(error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e.message,true,e.errorID,e))
                     {
                        break;
                     }
                  }
                  _loc6_++;
               }
            }
            return;
         }
      }
      
      private function complexFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc6_:Array = null;
         var _loc4_:IProfiler_1 = null;
         var _loc7_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:Boolean = false;
         var _loc5_:* = 0;
         var _loc3_:Boolean = true;
         var _loc8_:uint = 1000 / _displayObjectContainer.stage.frameRate;
         _loc11_ = 0;
         while(_loc11_ < maxPriority)
         {
            _loc5_ = uint(getTimer());
            _loc10_ = false;
            if(_loc5_ - param1 > _loc8_)
            {
               if(UnknownVarFromCoreComponentContext_Array_2[_loc11_] < _loc11_)
               {
                  UnknownVarFromCoreComponentContext_Array_2[_loc11_]++;
                  _loc10_ = true;
               }
            }
            if(!_loc10_)
            {
               UnknownVarFromCoreComponentContext_Array_2[_loc11_] = 0;
               _loc6_ = UnknownVarFromCoreComponentContext_Array_1[_loc11_];
               _loc9_ = 0;
               _loc7_ = _loc6_.length;
               while(_loc9_ != _loc7_ && _loc3_)
               {
                  _loc4_ = IProfiler_1(_loc6_[_loc9_]);
                  if(_loc4_ == null || Boolean(_loc4_.disposed))
                  {
                     _loc6_.splice(_loc9_,1);
                     _loc7_--;
                  }
                  else
                  {
                     try
                     {
                        _loc4_.update(param2);
                     }
                     catch(e:Error)
                     {
                        Logger.log(e.getStackTrace());
                        if(error("Error in update receiver \"" + getQualifiedClassName(_loc4_) + "\": " + e,true,e.errorID,e))
                        {
                           _loc3_ = false;
                        }
                     }
                     _loc9_++;
                  }
               }
            }
            _loc11_++;
         }
      }
      
      private function profilerFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:IProfiler_1 = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         UnknownVarFromCoreComponentContext_Profiler_1.start();
         _loc7_ = 0;
         loop0:
         while(_loc7_ < maxPriority)
         {
            UnknownVarFromCoreComponentContext_Array_2[_loc7_] = 0;
            _loc4_ = UnknownVarFromCoreComponentContext_Array_1[_loc7_];
            _loc6_ = 0;
            _loc5_ = _loc4_.length;
            while(true)
            {
               if(_loc6_ == _loc5_)
               {
                  _loc7_++;
                  continue loop0;
               }
               _loc3_ = IProfiler_1(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     UnknownVarFromCoreComponentContext_Profiler_1.update(_loc3_,param2);
                  }
                  catch(e:Error)
                  {
                     if(error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e.message,true,e.errorID,e))
                     {
                        break;
                     }
                  }
                  _loc6_++;
               }
            }
            return;
         }
         UnknownVarFromCoreComponentContext_Profiler_1.stop();
      }
      
      private function experimentalFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc3_ = UnknownVarFromCoreComponentContext_Array_1[_loc5_];
            _loc4_ = _loc3_.length - 1;
            while(_loc4_ > -1)
            {
               if(_loc3_[_loc4_].disposed)
               {
                  _loc3_.splice(_loc4_,1);
               }
               _loc4_--;
            }
            _loc5_++;
         }
      }
      
      private function debugFrameUpdateHandler(param1:uint, param2:uint) : void
      {
         var _loc4_:Array = null;
         var _loc3_:IProfiler_1 = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < maxPriority)
         {
            UnknownVarFromCoreComponentContext_Array_2[_loc7_] = 0;
            _loc4_ = UnknownVarFromCoreComponentContext_Array_1[_loc7_];
            _loc6_ = 0;
            _loc5_ = _loc4_.length;
            while(_loc6_ != _loc5_)
            {
               _loc3_ = IProfiler_1(_loc4_[_loc6_]);
               if(_loc3_ == null || Boolean(_loc3_.disposed))
               {
                  _loc4_.splice(_loc6_,1);
                  _loc5_--;
               }
               else
               {
                  try
                  {
                     _loc3_.update(param2);
                  }
                  catch(e:Error)
                  {
                     error("Error in update receiver \"" + getQualifiedClassName(_loc3_) + "\": " + e,false,e.errorID,e);
                  }
                  _loc6_++;
               }
            }
            _loc7_++;
         }
      }
      
      public function setProfilerMode(param1:Boolean) : void
      {
         var _loc3_:Array = null;
         var _loc2_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            UnknownVarFromCoreComponentContext_Function_1 = profilerFrameUpdateHandler;
            if(!UnknownVarFromCoreComponentContext_Profiler_1 || UnknownVarFromCoreComponentContext_Profiler_1.disposed)
            {
               UnknownVarFromCoreComponentContext_Profiler_1 = new Profiler(this);
            }
            attachComponent(UnknownVarFromCoreComponentContext_Profiler_1,[new IIDProfiler()]);
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               _loc3_ = UnknownVarFromCoreComponentContext_Array_1[_loc5_];
               _loc4_ = _loc3_.length - 1;
               while(_loc4_ > -1)
               {
                  _loc2_ = _loc3_[_loc4_];
                  if(_loc2_ is UpdateDelegate)
                  {
                     _loc3_[_loc4_] = UpdateDelegate(_loc2_).receiver;
                     UpdateDelegate(_loc2_).dispose();
                  }
                  _loc4_--;
               }
               _loc5_++;
            }
         }
         else
         {
            detachComponent(UnknownVarFromCoreComponentContext_Profiler_1);
            switch(UnknownVarFromCoreComponentContext_Uint_1 & 0x0F)
            {
               case 0:
                  UnknownVarFromCoreComponentContext_Function_1 = simpleFrameUpdateHandler;
                  break;
               case 1:
                  UnknownVarFromCoreComponentContext_Function_1 = complexFrameUpdateHandler;
                  break;
               case 4:
                  UnknownVarFromCoreComponentContext_Function_1 = experimentalFrameUpdateHandler;
                  _loc5_ = 0;
                  while(_loc5_ < 3)
                  {
                     _loc3_ = UnknownVarFromCoreComponentContext_Array_1[_loc5_];
                     _loc4_ = _loc3_.length - 1;
                     while(_loc4_ > -1)
                     {
                        _loc2_ = _loc3_[_loc4_];
                        if(_loc2_ is IProfiler_1)
                        {
                           _loc3_[_loc4_] = new UpdateDelegate(IProfiler_1(_loc2_),this,_loc5_);
                        }
                        _loc4_--;
                     }
                     _loc5_++;
                  }
                  break;
               default:
                  UnknownVarFromCoreComponentContext_Function_1 = debugFrameUpdateHandler;
            }
         }
      }
      
      public function set errorLogger(param1:IUnknownCoreRuntime1_2) : void
      {
         if(UnknownVarFromCoreComponentContext_IUnknownCoreRuntime1_1_1 != null)
         {
            UnknownVarFromCoreComponentContext_IUnknownCoreRuntime1_1_1.errorLogger = param1;
         }
      }
      
      public function reboot() : void
      {
         _rebootOnNextFrame = true;
      }
   }
}

import flash.events.Event;
import flash.utils.getQualifiedClassName;
import flash.utils.getTimer;

class UpdateDelegate implements IComponentInterfaceQueue
{
   private var _receiver:IProfiler_1;
   
   private var _context:IComponent_2;
   
   private var _priority:int;
   
   private var _lastUpdateTimeMs:uint;
   
   private var _framesSkipped:uint = 0;
   
   public function UpdateDelegate(param1:IProfiler_1, param2:IComponent_2, param3:int)
   {
      super();
      if(param2 && param1)
      {
         _receiver = param1;
         _context = param2;
         _priority = param3;
         param2.displayObjectContainer.stage.addEventListener(_priority == 0 ? "exitFrame" : "enterFrame",onFrameUpdate);
         _lastUpdateTimeMs = getTimer();
      }
   }
   
   public function get priority() : int
   {
      return _priority;
   }
   
   public function get receiver() : IProfiler_1
   {
      return _receiver;
   }
   
   public function get disposed() : Boolean
   {
      return !!_receiver ? _receiver.disposed : true;
   }
   
   public function dispose() : void
   {
      if(_receiver)
      {
         _receiver = null;
         _context.displayObjectContainer.stage.removeEventListener(_priority == 0 ? "exitFrame" : "enterFrame",onFrameUpdate);
         _context = null;
      }
   }
   
   private function onFrameUpdate(param1:Event) : void
   {
      var _loc2_:* = 0;
      if(!disposed)
      {
         _loc2_ = uint(getTimer());
         var _loc3_:uint = _loc2_ - _lastUpdateTimeMs;
         _lastUpdateTimeMs = _loc2_;
         if(_priority > 0 && _framesSkipped < _priority)
         {
            if(_loc3_ > 1000 / _context.displayObjectContainer.stage.frameRate)
            {
               _framesSkipped++;
               return;
            }
         }
         _framesSkipped = 0;
         try
         {
            _receiver.update(_loc3_);
         }
         catch(e:Error)
         {
            _context.error("Error in update receiver \"" + getQualifiedClassName(_receiver) + "\": " + e.message,true,e.errorID,e);
         }
      }
   }
}
