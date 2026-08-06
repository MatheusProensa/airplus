package
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.ICoreComponentContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.UnknownICoreUtils1;
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class FakeContext implements ICoreComponentContext
   {
      private var _events:IEventDispatcher;
      
      private var _assets:AssetLibraryCollection;
      
      private var _configuration:IComponent_1;
      
      private var _arguments:Dictionary;
      
      public function FakeContext(param1:Dictionary)
      {
         super();
         _events = new EventDispatcherWrapper();
         _assets = new AssetLibraryCollection("fakeAssetCollection");
         _arguments = param1;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return _assets;
      }
      
      public function get events() : IEventDispatcher
      {
         return _events;
      }
      
      public function get root() : IComponent_2
      {
         return null;
      }
      
      public function error(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : Boolean
      {
         return false;
      }
      
      public function getLastErrorMessage() : String
      {
         return "";
      }
      
      public function debug(param1:String) : void
      {
      }
      
      public function getLastDebugMessage() : String
      {
         return "";
      }
      
      public function warning(param1:String) : void
      {
      }
      
      public function getLastWarningMessage() : String
      {
         return "";
      }
      
      public function get displayObjectContainer() : DisplayObjectContainer
      {
         return null;
      }
      
      public function loadFromFile(param1:URLRequest, param2:LoaderContext) : LibraryLoader
      {
         return null;
      }
      
      public function attachComponent(param1:Component, param2:Array) : void
      {
      }
      
      public function detachComponent(param1:Component) : void
      {
      }
      
      public function prepareComponent(param1:Class, param2:uint = 0, param3:ApplicationDomain = null) : IUnknown
      {
         return null;
      }
      
      public function prepareAssetLibrary(param1:XML, param2:Class) : Boolean
      {
         return false;
      }
      
      public function registerUpdateReceiver(param1:IProfiler_1, param2:uint) : void
      {
      }
      
      public function removeUpdateReceiver(param1:IProfiler_1) : void
      {
      }
      
      public function toXMLString(param1:uint = 0) : String
      {
         return "";
      }
      
      public function queueInterface(param1:IID, param2:Function = null) : IUnknown
      {
         return null;
      }
      
      public function release(param1:IID) : uint
      {
         return 0;
      }
      
      public function dispose() : void
      {
         _assets.dispose();
         _events = null;
         _assets = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function injectDependencies(param1:Component) : void
      {
      }
      
      public function get configuration() : IComponent_1
      {
         return _configuration;
      }
      
      public function set configuration(param1:IComponent_1) : void
      {
         _configuration = param1;
      }
      
      public function addLinkEventTracker(param1:ILinkEventTracker) : void
      {
      }
      
      public function removeLinkEventTracker(param1:ILinkEventTracker) : void
      {
      }
      
      public function createLinkEvent(param1:String) : void
      {
      }
      
      public function get linkEventTrackers() : Vector.<ILinkEventTracker>
      {
         return null;
      }
      
      public function initialize() : void
      {
      }
      
      public function purge() : void
      {
      }
      
      public function hibernate(param1:int, param2:int = 1) : void
      {
      }
      
      public function resume() : void
      {
      }
      
      public function readConfigDocument(param1:XML, param2:IEventDispatcher = null) : void
      {
      }
      
      public function writeDictionaryToProxy(param1:String, param2:Dictionary) : Boolean
      {
         return false;
      }
      
      public function readDictionaryFromProxy(param1:String) : Dictionary
      {
         return new Dictionary();
      }
      
      public function writeXMLToProxy(param1:String, param2:XML) : Boolean
      {
         return false;
      }
      
      public function readXMLFromProxy(param1:String) : XML
      {
         return new XML();
      }
      
      public function readStringFromProxy(param1:String) : String
      {
         return "";
      }
      
      public function writeStringToProxy(param1:String, param2:String) : Boolean
      {
         return false;
      }
      
      public function getNumberOfFilesPending() : uint
      {
         return 0;
      }
      
      public function getNumberOfFilesLoaded() : uint
      {
         return 0;
      }
      
      public function setProfilerMode(param1:Boolean) : void
      {
      }
      
      public function get arguments() : Dictionary
      {
         return _arguments;
      }
      
      public function clearArguments() : void
      {
         _arguments = new Dictionary();
      }
      
      public function propertyExists(param1:String) : Boolean
      {
         return false;
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return "";
      }
      
      public function setProperty(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         return false;
      }
      
      public function getInteger(param1:String, param2:int) : int
      {
         return 0;
      }
      
      public function interpolate(param1:String) : String
      {
         return "";
      }
      
      public function updateUrlProtocol(param1:String) : String
      {
         return "";
      }
      
      public function get fileProxy() : UnknownICoreUtils1
      {
         return undefined;
      }
   }
}

