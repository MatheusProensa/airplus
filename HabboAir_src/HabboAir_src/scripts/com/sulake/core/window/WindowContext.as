package com.sulake.core.window
{
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.localization.ILocalizable;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.components.DesktopController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.SubstituteParentController;
   import com.sulake.core.window.graphics.IGraphicContextHost;
   import com.sulake.core.window.graphics.IWindowRenderer;
   import com.sulake.core.window.services.IInternalWindowServices;
   import com.sulake.core.window.services.ServiceManager;
   import com.sulake.core.window.utils.EventProcessorState;
   import com.sulake.core.window.utils.IEventProcessor;
   import com.sulake.core.window.utils.IEventQueue;
   import com.sulake.core.window.utils.IWindowParser;
   import com.sulake.core.window.utils.MouseEventProcessor;
   import com.sulake.core.window.utils.MouseEventQueue;
   import com.sulake.core.window.utils.WindowParser;
   import com.sulake.core.window.utils.tablet.TabletEventProcessor;
   import com.sulake.core.window.utils.tablet.TabletEventQueue;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class WindowContext implements IWindowContext_3, IComponentInterfaceQueue, IProfiler_1
   {
      public static const INPUT_MODE_MOUSE:uint = 0;
      
      public static const INPUT_MODE_TOUCH:uint = 1;
      
      public static const ERROR_UNKNOWN:int = 0;
      
      public static const ERROR_INVALID_WINDOW:int = 1;
      
      public static const ERROR_WINDOW_NOT_FOUND:int = 2;
      
      public static const ERROR_WINDOW_ALREADY_EXISTS:int = 3;
      
      public static const ERROR_UNKNOWN_WINDOW_TYPE:int = 4;
      
      public static const ERROR_DURING_EVENT_HANDLING:int = 5;
      
      public static var inputEventQueue:IEventQueue;
      
      private static var inputEventProcessor:IEventProcessor;
      
      private static var inputModeFlag:uint = 0;
      
      private static var UnknownVarFromWindowContext_IWindowRenderer_1:IWindowRenderer;
      
      private static var stage:Stage;
      
      public var inputEventTrackers:Vector.<IInputEventTracker>;
      
      private var _linkEventTrackers:Vector.<ILinkEventTracker>;
      
      private var UnknownVarFromWindowContext_EventProcessorState_1:EventProcessorState;
      
      protected var _localization:ICoreLocalizationManager;
      
      protected var _rootDisplayObject:DisplayObjectContainer;
      
      protected var _throwErrors:Boolean = true;
      
      protected var _lastError:Error;
      
      protected var _lastErrorCode:int = -1;
      
      protected var _windowServices:IInternalWindowServices;
      
      protected var _windowParser:IWindowParser;
      
      protected var _windowFactory:IWindowContext_1;
      
      protected var _widgetFactory:UnknownICoreWindow1;
      
      protected var _resourceManager:IResourceManager;
      
      protected var _desktopWindow:IDesktopController;
      
      protected var UnknownVarFromWindowContext_SubstituteParentController_1:SubstituteParentController;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromWindowContext_Boolean_1:Boolean = false;
      
      private var _rendering:Boolean = false;
      
      private var _name:String;
      
      private var UnknownVarFromWindowContext_IComponent_1_1:IComponent_1;
      
      public function WindowContext(param1:String, param2:IWindowRenderer, param3:IWindowContext_1, param4:UnknownICoreWindow1, param5:IResourceManager, param6:ICoreLocalizationManager, param7:IComponent_1, param8:DisplayObjectContainer, param9:Rectangle, param10:Vector.<ILinkEventTracker>)
      {
         super();
         _name = param1;
         UnknownVarFromWindowContext_IWindowRenderer_1 = param2;
         _localization = param6;
         UnknownVarFromWindowContext_IComponent_1_1 = param7;
         _rootDisplayObject = param8;
         _windowServices = new ServiceManager(this,param8);
         _windowFactory = param3;
         _widgetFactory = param4;
         _resourceManager = param5;
         _windowParser = new WindowParser(this);
         inputEventTrackers = new Vector.<IInputEventTracker>(0);
         _linkEventTrackers = param10;
         if(!stage)
         {
            if(_rootDisplayObject is Stage)
            {
               stage = _rootDisplayObject as Stage;
            }
            else if(_rootDisplayObject.stage)
            {
               stage = _rootDisplayObject.stage;
            }
         }
         Classes.init();
         if(param9 == null)
         {
            param9 = new Rectangle(0,0,800,600);
         }
         _desktopWindow = new DesktopController("_CONTEXT_DESKTOP_" + _name,this,param9);
         _desktopWindow.limits.maxWidth = param9.width;
         _desktopWindow.limits.maxHeight = param9.height;
         _rootDisplayObject.addChild(_desktopWindow.getDisplayObject());
         _rootDisplayObject.doubleClickEnabled = true;
         _rootDisplayObject.addEventListener("resize",stageResizedHandler);
         UnknownVarFromWindowContext_EventProcessorState_1 = new EventProcessorState(UnknownVarFromWindowContext_IWindowRenderer_1,_desktopWindow,_desktopWindow,null,null,null,inputEventTrackers);
         inputMode = 0;
         UnknownVarFromWindowContext_SubstituteParentController_1 = new SubstituteParentController(this);
      }
      
      public static function get inputMode() : uint
      {
         return inputModeFlag;
      }
      
      public static function set inputMode(param1:uint) : void
      {
         if(inputEventQueue)
         {
            if(inputEventQueue is IComponentInterfaceQueue)
            {
               IComponentInterfaceQueue(inputEventQueue).dispose();
            }
         }
         if(inputEventProcessor)
         {
            if(inputEventProcessor is IComponentInterfaceQueue)
            {
               IComponentInterfaceQueue(inputEventProcessor).dispose();
            }
         }
         switch(param1)
         {
            case INPUT_MODE_MOUSE:
               inputEventQueue = new MouseEventQueue(stage);
               inputEventProcessor = new MouseEventProcessor();
               try
               {
               }
               catch(e:Error)
               {
               }
               break;
            case 1:
               inputEventQueue = new TabletEventQueue(stage);
               inputEventProcessor = new TabletEventProcessor();
               try
               {
               }
               catch(e:Error)
               {
               }
               break;
            default:
               inputMode = INPUT_MODE_MOUSE;
               throw new Error("Unknown input mode " + param1);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _rootDisplayObject.removeEventListener("resize",stageResizedHandler);
            _rootDisplayObject.removeChild(IGraphicContextHost(_desktopWindow).getGraphicContext(true) as DisplayObject);
            _desktopWindow.destroy();
            _desktopWindow = null;
            UnknownVarFromWindowContext_SubstituteParentController_1.destroy();
            UnknownVarFromWindowContext_SubstituteParentController_1 = null;
            if(_windowServices is IComponentInterfaceQueue)
            {
               IComponentInterfaceQueue(_windowServices).dispose();
            }
            _windowServices = null;
            _windowParser.dispose();
            _windowParser = null;
            UnknownVarFromWindowContext_IWindowRenderer_1 = null;
            _localization = null;
            _rootDisplayObject = null;
            _windowFactory = null;
            _widgetFactory = null;
            _resourceManager = null;
         }
      }
      
      public function getLastError() : Error
      {
         return _lastError;
      }
      
      public function getLastErrorCode() : int
      {
         return _lastErrorCode;
      }
      
      public function handleError(param1:int, param2:Error) : void
      {
         _lastError = param2;
         _lastErrorCode = param1;
         if(_throwErrors)
         {
            throw param2;
         }
      }
      
      public function flushError() : void
      {
         _lastError = null;
         _lastErrorCode = -1;
      }
      
      public function getWindowServices() : IInternalWindowServices
      {
         return _windowServices;
      }
      
      public function getWindowParser() : IWindowParser
      {
         return _windowParser;
      }
      
      public function getWindowFactory() : IWindowContext_1
      {
         return _windowFactory;
      }
      
      public function getDesktopWindow() : IDesktopController
      {
         return _desktopWindow;
      }
      
      public function findWindowByName(param1:String) : IWindowModel
      {
         return _desktopWindow.findChildByName(param1);
      }
      
      public function findWindowByTag(param1:String) : IWindowModel
      {
         return _desktopWindow.findChildByTag(param1);
      }
      
      public function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         return _desktopWindow.groupChildrenWithTag(param1,param2,param3);
      }
      
      public function registerLocalizationListener(param1:String, param2:IWindowModel) : void
      {
         _localization.registerListener(param1,param2 as ILocalizable);
      }
      
      public function removeLocalizationListener(param1:String, param2:IWindowModel) : void
      {
         _localization.removeListener(param1,param2 as ILocalizable);
      }
      
      public function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindowModel, param9:uint, param10:Array = null, param11:String = "", param12:Array = null) : IWindowModel
      {
         var _loc14_:IWindowModel = null;
         var _loc13_:Class = Classes.getWindowClassByType(param3);
         if(_loc13_ == null)
         {
            handleError(4,new Error("Failed to solve implementation for window \"" + param1 + "\"!"));
            return null;
         }
         if(param8 == null)
         {
            if(param5 & 0x10)
            {
               param8 = UnknownVarFromWindowContext_SubstituteParentController_1;
            }
         }
         _loc14_ = new _loc13_(param1,param3,param4,param5,this,param6,param8 ?? _desktopWindow,param7,param10,param12,param9);
         _loc14_.dynamicStyle = param11;
         if(param2 && param2.length)
         {
            _loc14_.caption = param2;
         }
         return _loc14_;
      }
      
      public function destroy(param1:IWindowModel) : Boolean
      {
         if(param1 == _desktopWindow)
         {
            _desktopWindow = null;
         }
         if(param1.state != 1073741824)
         {
            param1.destroy();
         }
         return true;
      }
      
      public function invalidate(param1:IWindowModel, param2:Rectangle, param3:uint) : void
      {
         if(!disposed)
         {
            UnknownVarFromWindowContext_IWindowRenderer_1.addToRenderQueue(param1,param2,param3);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Error = null;
         UnknownVarFromWindowContext_Boolean_1 = true;
         if(_lastError)
         {
            _loc2_ = _lastError;
            _lastError = null;
            throw _loc2_;
         }
         inputEventProcessor.process(UnknownVarFromWindowContext_EventProcessorState_1,inputEventQueue);
         UnknownVarFromWindowContext_Boolean_1 = false;
      }
      
      public function render(param1:uint) : void
      {
         _rendering = true;
         UnknownVarFromWindowContext_IWindowRenderer_1.render();
         _rendering = false;
      }
      
      private function stageResizedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_desktopWindow != null && !_desktopWindow.disposed)
         {
            if(_rootDisplayObject is Stage)
            {
               _loc2_ = int(Stage(_rootDisplayObject).stageWidth);
               _loc3_ = int(Stage(_rootDisplayObject).stageHeight);
            }
            else
            {
               _loc2_ = _rootDisplayObject.width;
               _loc3_ = _rootDisplayObject.height;
            }
            if(_loc2_ >= 10 && _loc3_ >= 10)
            {
               _desktopWindow.limits.maxWidth = _loc2_;
               _desktopWindow.limits.maxHeight = _loc3_;
               _desktopWindow.width = _loc2_;
               _desktopWindow.height = _loc3_;
            }
         }
      }
      
      public function addMouseEventTracker(param1:IInputEventTracker) : void
      {
         if(inputEventTrackers.indexOf(param1) < 0)
         {
            inputEventTrackers.push(param1);
         }
      }
      
      public function removeMouseEventTracker(param1:IInputEventTracker) : void
      {
         var _loc2_:int = int(inputEventTrackers.indexOf(param1));
         if(_loc2_ > -1)
         {
            inputEventTrackers.splice(_loc2_,1);
         }
      }
      
      public function getResourceManager() : IResourceManager
      {
         return _resourceManager;
      }
      
      public function getWidgetFactory() : UnknownICoreWindow1
      {
         return _widgetFactory;
      }
      
      public function get linkEventTrackers() : Vector.<ILinkEventTracker>
      {
         return _linkEventTrackers;
      }
   }
}

