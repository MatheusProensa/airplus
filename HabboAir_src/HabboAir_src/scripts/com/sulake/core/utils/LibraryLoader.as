package com.sulake.core.utils
{
   import com.sulake.core.Core;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.System;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class LibraryLoader extends EventDispatcherWrapper implements IComponentInterfaceQueue
   {
      private static const LOG_LOADING:* = false;
      
      protected static const STATE_EVENT_COMPLETE:uint = 1;
      
      protected static const STATE_EVENT_INIT:uint = 2;
      
      protected static const STATE_EVENT_FRAME:uint = 4;
      
      protected static const STATE_ANALYZE:uint = 3;
      
      protected static const STATE_READY:uint = 7;
      
      public static const DEFAULT_MAX_RETRIES:int = 5;
      
      public static const LIBRARY_LOADER_FINALIZE:String = "LIBRARY_LOADER_FINALIZE";
      
      public static const USE_DOWNLOAD_THROTTLING:Boolean = true;
      
      public static const MAX_SIMULTANEOUS_DOWNLOADS:int = 6;
      
      private static var UnknownVarFromLibraryLoader_Array_1:Array = [];
      
      private static var UnknownVarFromLibraryLoader_Array_2:Array = [];
      
      protected var UnknownVarFromLibraryLoader_Loader_1:Loader;
      
      protected var _context:LoaderContext;
      
      protected var _status:int = 0;
      
      protected var _request:URLRequest;
      
      protected var _manifest:XML;
      
      protected var _resource:Class;
      
      protected var UnknownVarFromLibraryLoader_Uint_1:uint = 0;
      
      protected var _name:String;
      
      protected var _ready:Boolean = false;
      
      protected var UnknownVarFromLibraryLoader_Boolean_1:Boolean = false;
      
      protected var _paused:Boolean = false;
      
      protected var _errorMsg:String = "";
      
      protected var _debugMsg:String = "";
      
      protected var _downloadStartTime:int;
      
      protected var _downloadEndTime:int;
      
      protected var _downloadRetriesLeft:int;
      
      protected var UnknownVarFromLibraryLoader_Uint_2:uint = 0;
      
      public function LibraryLoader(param1:LoaderContext = null, param2:Boolean = false, param3:Boolean = false)
      {
         super();
         if(param1 == null)
         {
            _context = new LoaderContext();
            _context.applicationDomain = ApplicationDomain.currentDomain;
         }
         else
         {
            _context = param1;
         }
         _paused = param2;
         UnknownVarFromLibraryLoader_Boolean_1 = param3;
         _status = 0;
         UnknownVarFromLibraryLoader_Loader_1 = new Loader();
         UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.addEventListener("init",loadEventHandler);
         UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.addEventListener("complete",loadEventHandler);
         UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.addEventListener("progress",loadEventHandler);
         UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.addEventListener("unload",loadEventHandler);
         UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.addEventListener("httpStatus",loadEventHandler);
         UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.addEventListener("ioError",loadEventHandler);
         UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.addEventListener("securityError",loadEventHandler);
      }
      
      protected static function addRequestCounterToUrlRequest(param1:URLRequest, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         if(param1.url == null || param1.url == "")
         {
            return;
         }
         var _loc4_:Array = param1.url.split("?");
         var _loc5_:String = _loc4_[0];
         var _loc9_:String = _loc4_.length > 1 ? _loc4_[1] : "";
         var _loc7_:String = "counterparameter";
         var _loc10_:Array = _loc9_.split("&");
         var _loc8_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < _loc10_.length)
         {
            _loc6_ = _loc10_[_loc3_];
            if(_loc6_.indexOf(_loc7_ + "=") >= 0)
            {
               _loc6_ = _loc7_ + "=" + param2.toString();
               _loc10_[_loc3_] = _loc6_;
               _loc8_ = true;
               break;
            }
            _loc3_++;
         }
         if(!_loc8_)
         {
            _loc10_.push(_loc7_ + "=" + param2);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc10_.length)
         {
            _loc5_ += (_loc3_ == 0 ? "?" : "&") + _loc10_[_loc3_];
            _loc3_++;
         }
         param1.url = _loc5_;
      }
      
      protected static function parseNameFromUrl(param1:String) : String
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.indexOf("?",0));
         if(_loc2_ > -1)
         {
            param1 = param1.slice(0,_loc2_);
         }
         _loc2_ = int(param1.lastIndexOf("."));
         if(_loc2_ > -1)
         {
            param1 = param1.slice(0,_loc2_);
         }
         _loc2_ = int(param1.lastIndexOf("/"));
         if(_loc2_ > -1)
         {
            param1 = param1.slice(_loc2_ + 1,param1.length);
         }
         return param1;
      }
      
      protected static function queue(param1:LibraryLoader) : void
      {
         if(UnknownVarFromLibraryLoader_Array_1.indexOf(param1) == -1)
         {
            UnknownVarFromLibraryLoader_Array_1.push(param1);
         }
         throttle();
      }
      
      protected static function throttle() : void
      {
         var _loc1_:LibraryLoader = null;
         var _loc2_:int = 0;
         _loc2_ = UnknownVarFromLibraryLoader_Array_2.length - 1;
         while(_loc2_ > -1)
         {
            _loc1_ = UnknownVarFromLibraryLoader_Array_2[_loc2_] as LibraryLoader;
            if(_loc1_ && (_loc1_.ready || _loc1_.disposed))
            {
               UnknownVarFromLibraryLoader_Array_2.splice(_loc2_,1);
            }
            _loc2_--;
         }
         while(UnknownVarFromLibraryLoader_Array_2.length < 6 && UnknownVarFromLibraryLoader_Array_1.length > 0)
         {
            _loc1_ = UnknownVarFromLibraryLoader_Array_1.shift() as LibraryLoader;
            if(!_loc1_.ready && !_loc1_.disposed)
            {
               UnknownVarFromLibraryLoader_Array_2.push(_loc1_);
               _loc1_.UnknownVarFromLibraryLoader_Loader_1.load(_loc1_._request,_loc1_._context);
            }
         }
      }
      
      public function get url() : String
      {
         return !!_request ? _request.url : null;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get ready() : Boolean
      {
         return _ready;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get domain() : ApplicationDomain
      {
         return UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.applicationDomain;
      }
      
      public function get request() : URLRequest
      {
         return _request;
      }
      
      public function get resource() : Class
      {
         return _resource;
      }
      
      public function get manifest() : XML
      {
         return _manifest;
      }
      
      public function get bytesTotal() : uint
      {
         return UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.bytesTotal;
      }
      
      public function get bytesLoaded() : uint
      {
         return UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.bytesLoaded;
      }
      
      public function get elapsedTime() : uint
      {
         return _ready ? _downloadEndTime - _downloadStartTime : getTimer() - _downloadStartTime;
      }
      
      public function get paused() : Boolean
      {
         return _paused;
      }
      
      protected function get content() : DisplayObject
      {
         if(Resources.get(_name))
         {
            return Resources.get(_name) as DisplayObject;
         }
         return UnknownVarFromLibraryLoader_Loader_1.content;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_DISPOSE",_status,bytesTotal,bytesLoaded,elapsedTime));
            try
            {
               UnknownVarFromLibraryLoader_Loader_1.close();
            }
            catch(e:Error)
            {
            }
            try
            {
               UnknownVarFromLibraryLoader_Loader_1.unload();
            }
            catch(e:Error)
            {
            }
            UnknownVarFromLibraryLoader_Loader_1 = null;
            _context = null;
            _resource = null;
            System.disposeXML(_manifest);
            _manifest = null;
            super.dispose();
         }
      }
      
      public function load(param1:URLRequest, param2:int = 5) : void
      {
         _request = param1;
         _name = parseNameFromUrl(_request.url);
         _ready = false;
         _downloadRetriesLeft = param2;
         ErrorReportStorage.addDebugData("Library url","Library url " + param1.url);
         ErrorReportStorage.addDebugData("Library name","Library name " + _name);
         if(!_paused)
         {
            _paused = true;
            resume();
         }
      }
      
      public function resume() : void
      {
         var _loc1_:Timer = null;
         if(_paused && !_disposed)
         {
            _paused = false;
            if(!_ready && _request)
            {
               _downloadEndTime = -1;
               _downloadStartTime = getTimer();
               if(hasDefinition(_name))
               {
                  Logger.log("[LibraryLoader] Found in AIR: " + _name);
                  _loc1_ = new Timer(10,1);
                  _loc1_.addEventListener("timer",loadEventHandler);
                  _loc1_.start();
                  return;
               }
               queue(this);
            }
         }
      }
      
      protected function retry() : Boolean
      {
         if(!_ready && !_disposed && _downloadRetriesLeft > 0)
         {
            try
            {
               UnknownVarFromLibraryLoader_Loader_1.close();
               UnknownVarFromLibraryLoader_Loader_1.unload();
            }
            catch(e:Error)
            {
            }
            addRequestCounterToUrlRequest(_request,5 - _downloadRetriesLeft);
            _downloadRetriesLeft--;
            UnknownVarFromLibraryLoader_Uint_1 = 0;
            UnknownVarFromLibraryLoader_Loader_1.load(_request,_context);
            return true;
         }
         return false;
      }
      
      public function hasDefinition(param1:String) : Boolean
      {
         if(Resources.get(param1))
         {
            Logger.log("[LibraryLoader] Definition in resources: " + param1);
            return true;
         }
         var _loc2_:Boolean = false;
         try
         {
            _loc2_ = UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.applicationDomain.hasDefinition(param1);
         }
         catch(e:Error)
         {
         }
         return _loc2_;
      }
      
      public function getDefinition(param1:String) : Object
      {
         if(Resources.get(param1))
         {
            return Resources.get(param1);
         }
         var _loc2_:Object = null;
         try
         {
            if(UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.applicationDomain.hasDefinition(param1))
            {
               _loc2_ = UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.applicationDomain.getDefinition(param1);
            }
         }
         catch(e:Error)
         {
         }
         return _loc2_;
      }
      
      protected function loadEventHandler(param1:Event) : void
      {
         var _loc3_:Timer = null;
         var _loc2_:Boolean = false;
         switch(param1.type)
         {
            case "init":
               UnknownVarFromLibraryLoader_Uint_1 |= 2;
               break;
            case "complete":
               UnknownVarFromLibraryLoader_Uint_1 |= 1;
               break;
            case "enterFrame":
               break;
            case "httpStatus":
               _status = HTTPStatusEvent(param1).status;
               break;
            case "unload":
               debug("Load event UNLOAD for file \"" + url + "\"");
               dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_UNLOAD",_status,bytesTotal,bytesLoaded,elapsedTime));
               break;
            case "progress":
               dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_PROGRESS",_status,bytesTotal,bytesLoaded,elapsedTime));
               break;
            case "ioError":
               debug("Load event IO ERROR for file \"" + url + "\"");
               if(!handleHttpStatus(_status))
               {
                  _downloadEndTime = getTimer();
                  failure("IO Error, send or load operation failed for file \"" + url + "\"");
                  removeEventListeners();
               }
               break;
            case "securityError":
               _downloadEndTime = getTimer();
               failure("Security Error, security violation with file \"" + url + "\"");
               removeEventListeners();
               break;
            case "timer":
               _loc3_ = TimerEvent(param1).target as Timer;
               _loc3_.removeEventListener("timer",loadEventHandler);
               _loc3_.stop();
               if(!_disposed)
               {
                  UnknownVarFromLibraryLoader_Uint_1 = 7;
                  loadEventHandler(new Event("complete"));
               }
               return;
         }
         if(UnknownVarFromLibraryLoader_Uint_1 == 3)
         {
            if(analyzeLibrary())
            {
               UnknownVarFromLibraryLoader_Uint_1 |= 4;
            }
         }
         if(UnknownVarFromLibraryLoader_Uint_1 == 7)
         {
            _loc2_ = prepareLibrary();
            if(_loc2_)
            {
               _ready = true;
               _downloadEndTime = getTimer();
               removeEventListeners();
               throttle();
               dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_COMPLETE",_status,bytesTotal,bytesLoaded,elapsedTime));
               dispatchEvent(new Event("LIBRARY_LOADER_FINALIZE"));
            }
         }
      }
      
      protected function analyzeLibrary() : Boolean
      {
         var _loc1_:MovieClip = null;
         var _loc3_:FrameLabel = null;
         var _loc4_:Array = null;
         var _loc2_:* = 0;
         if(content is MovieClip)
         {
            _loc1_ = content as MovieClip;
            _loc4_ = _loc1_.currentLabels;
            debug("\tLibrary \"" + _name + "\" is in frame " + _loc1_.currentFrame + "(" + _loc1_.currentLabel + ")");
            if(_loc4_.length > 1)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc4_.length)
               {
                  _loc3_ = _loc4_[_loc2_] as FrameLabel;
                  if(_loc3_.name == _name)
                  {
                     if(_loc3_.frame != _loc1_.currentFrame)
                     {
                        _loc1_.addEventListener("enterFrame",loadEventHandler);
                        return false;
                     }
                  }
                  _loc2_++;
               }
            }
         }
         return true;
      }
      
      [SecureSWF(controlFlow="0")]
      protected function prepareLibrary() : Boolean
      {
         var _loc3_:ByteArray = null;
         _resource = this.getDefinition(_name) as Class;
         if(_resource == null)
         {
            if(!retry())
            {
               failure("Failed to find resource class \"" + _name + "\" from library " + _request.url + "!");
            }
            return false;
         }
         var _loc1_:Boolean = true;
         var _loc2_:Class = null;
         try
         {
            _loc2_ = _resource.manifest as Class;
         }
         catch(e:Error)
         {
            if(!retry())
            {
               failure("Failed to find embedded manifest.xml from library " + _request.url + "!");
            }
            _loc1_ = false;
         }
         if(_loc2_ == null || !_loc1_)
         {
            return false;
         }
         try
         {
            _loc3_ = new _loc2_() as ByteArray;
            _manifest = new XML(_loc3_.readUTFBytes(_loc3_.length));
         }
         catch(e:Error)
         {
            if(!retry())
            {
               failure("Failed to extract manifest.xml from library " + _name + "!\n" + e.message);
            }
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      protected function handleHttpStatus(param1:int) : Boolean
      {
         if(param1 == 0 || param1 >= 400)
         {
            if(retry())
            {
               return true;
            }
            failure("HTTP Error " + param1 + " \"" + UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.url + "\"");
            removeEventListeners();
         }
         return false;
      }
      
      protected function removeEventListeners() : void
      {
         if(UnknownVarFromLibraryLoader_Loader_1)
         {
            if(UnknownVarFromLibraryLoader_Loader_1.content != null)
            {
               UnknownVarFromLibraryLoader_Loader_1.content.removeEventListener("enterFrame",loadEventHandler);
            }
            UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.removeEventListener("init",loadEventHandler);
            UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.removeEventListener("complete",loadEventHandler);
            UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.removeEventListener("progress",loadEventHandler);
            UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.removeEventListener("unload",loadEventHandler);
            UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.removeEventListener("httpStatus",loadEventHandler);
            UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.removeEventListener("ioError",loadEventHandler);
            UnknownVarFromLibraryLoader_Loader_1.contentLoaderInfo.removeEventListener("securityError",loadEventHandler);
         }
      }
      
      protected function debug(param1:String) : void
      {
         Core.debug(param1);
         _debugMsg = param1;
         if(UnknownVarFromLibraryLoader_Boolean_1)
         {
            dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_DEBUG",_status,bytesTotal,bytesLoaded,elapsedTime));
         }
      }
      
      protected function failure(param1:String) : void
      {
         Core.warning(param1);
         _errorMsg = param1;
         throttle();
         dispatchEvent(new LibraryLoaderEvent("LIBRARY_LOADER_EVENT_ERROR",_status,bytesTotal,bytesLoaded,elapsedTime));
         dispatchEvent(new Event("LIBRARY_LOADER_FINALIZE"));
      }
      
      public function getLastDebugMessage() : String
      {
         return _debugMsg;
      }
      
      public function getLastErrorMessage() : String
      {
         return _errorMsg;
      }
   }
}

