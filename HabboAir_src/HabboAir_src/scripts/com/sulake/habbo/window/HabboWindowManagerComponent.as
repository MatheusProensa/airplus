package com.sulake.habbo.window
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IIDProfiler;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.IProfiler_2;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.FontEnum;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.profiler.ProfilerAgentTask;
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.IWindowContext_1;
   import com.sulake.core.window.IWindowContext_2;
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowController_2;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.UnknownICoreWindow1;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.components.HTMLTextController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.*;
   import com.sulake.core.window.graphics.IWindowRenderer;
   import com.sulake.core.window.graphics.SkinContainer;
   import com.sulake.core.window.graphics.WindowRenderer;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import com.sulake.core.window.theme.IThemeManager;
   import com.sulake.core.window.tools.*;
   import com.sulake.core.window.utils.DefaultAttStruct;
   import com.sulake.core.window.utils.INotify;
   import com.sulake.core.window.utils.MouseCursorControl;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils6;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.window.handlers.HabbletLinkHandler;
   import com.sulake.habbo.window.theme.ThemeManager;
   import com.sulake.habbo.window.utils.AlertDialog;
   import com.sulake.habbo.window.utils.AlertDialogWithLink;
   import com.sulake.habbo.window.utils.ConfirmDialog;
   import com.sulake.habbo.window.utils.ElementPointerHandler;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.utils.ModalDialog;
   import com.sulake.habbo.window.utils.SimpleAlertDialog;
   import com.sulake.habbo.window.utils.SkinParserUtil;
   import com.sulake.habbo.window.utils.floorplaneditor.BCFloorPlanEditor;
   import com.sulake.habbo.window.utils.habbopedia.HabboPagesViewer;
   import com.sulake.habbo.window.widgets.WidgetClasses;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.StyleSheet;
   import flash.utils.getTimer;
   
   public class HabboWindowManagerComponent extends Component implements IHabboWindowManagerComponent, IWindowContext_2, IWindowContext_1, IProfiler_1, IInputEventTracker, UnknownICoreWindow1
   {
      private static const NUMBER_OF_CONTEXT_LAYERS:uint = 4;
      
      private static const DEFAULT_CONTEXT_LAYER_INDEX:uint = 1;
      
      private static const TRACKING_EVENT_INPUT:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_INPUT");
      
      private static const TRACKING_EVENT_RENDER:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_RENDER");
      
      private static const TRACKING_EVENT_SLEEP:Event = new Event("HABBO_WINDOW_TRACKING_EVENT_SLEEP");
      
      private var _localization:IHabboLocalizationManager;
      
      private var _windowContextArray:Array;
      
      private var UnknownVarFromHabboWindowManagerComponent_IWindowContext_3_1:IWindowContext_3;
      
      private var _windowRenderer:IWindowRenderer;
      
      private var UnknownVarFromHabboWindowManagerComponent_SkinContainer_1:SkinContainer;
      
      private var UnknownVarFromHabboWindowManagerComponent_Boolean_1:Boolean = false;
      
      private var UnknownVarFromHabboWindowManagerComponent_ProfilerOutput_1:ProfilerOutput;
      
      private var _profilerAgentTaskUpdate:ProfilerAgentTask;
      
      private var _profilerAgentTaskRedraw:ProfilerAgentTask;
      
      private var UnknownVarFromHabboWindowManagerComponent_ThemeManager_1:ThemeManager;
      
      private var _resourceManager:ResourceManager;
      
      private var _hintManager:HintManager;
      
      private var _avatarRenderer:IAvatarRenderManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _catalog:IHabboCatalog;
      
      private var UnknownVarFromHabboWindowManagerComponent_Boolean_2:Boolean = false;
      
      private var _roomEngine:IRoomEngine;
      
      private var UnknownVarFromHabboWindowManagerComponent_Uint_1:uint;
      
      private var _bcfloorPlanEditor:BCFloorPlanEditor;
      
      private var UnknownVarFromHabboWindowManagerComponent_HabboPagesViewer_1:HabboPagesViewer;
      
      private var UnknownVarFromHabboWindowManagerComponent_HabbletLinkHandler_1:HabbletLinkHandler;
      
      private var UnknownVarFromHabboWindowManagerComponent_ElementPointerHandler_1:ElementPointerHandler;
      
      public var LilithCustomsInstance:LilithCustoms;
      
      public function HabboWindowManagerComponent(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         FontEnum.refresh();
         HTMLTextController.defaultLinkTarget = "habboMain";
         HabboTracking.getInstance().WindowManager = this;
         this.LilithCustomsInstance = new LilithCustoms(this);
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false),new ComponentDependency(new IIDHabboConfigurationManager(),function(param1:IComponent_1):void
         {
         },false,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderer = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),setCommunicationManager,false),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false)]);
      }
      
      private function setCommunicationManager(param1:IHabboCommunicationManager) : void
      {
         _communication = param1;
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         if(_communication != null)
         {
            _bcfloorPlanEditor = new BCFloorPlanEditor(this);
            UnknownVarFromHabboWindowManagerComponent_ElementPointerHandler_1 = new ElementPointerHandler(this);
         }
      }
      
      override protected function initComponent() : void
      {
         var _loc3_:* = 0;
         var _loc1_:int = getTimer();
         var _loc2_:ISoundAsset = assets.getAssetByName("habbo_element_description_xml");
         UnknownVarFromHabboWindowManagerComponent_SkinContainer_1 = new SkinContainer();
         SkinParserUtil.parse(_loc2_.content as XML,assets,UnknownVarFromHabboWindowManagerComponent_SkinContainer_1);
         UnknownVarFromHabboWindowManagerComponent_ThemeManager_1 = new ThemeManager(UnknownVarFromHabboWindowManagerComponent_SkinContainer_1);
         _resourceManager = new ResourceManager(this);
         _hintManager = new HintManager(this);
         _windowRenderer = new WindowRenderer(UnknownVarFromHabboWindowManagerComponent_SkinContainer_1);
         _windowContextArray = new Array(4);
         var _loc4_:Rectangle = new Rectangle(0,0,context.displayObjectContainer.stage.stageWidth,context.displayObjectContainer.stage.stageHeight);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _windowContextArray[_loc3_] = new WindowContext("layer_" + _loc3_,_windowRenderer,this,this,_resourceManager,_localization,this,context.displayObjectContainer,_loc4_,context.linkEventTrackers);
            _loc3_++;
         }
         assets.removeAsset(_loc2_);
         _loc2_.dispose();
         UnknownVarFromHabboWindowManagerComponent_IWindowContext_3_1 = _windowContextArray[1];
         addMouseEventTracker(this);
         registerUpdateReceiver(this,0);
         queueInterface(new IIDProfiler(),receiveProfilerInterface);
         _loc1_ = getTimer() - _loc1_;
         Logger.log("initializing window framework took " + _loc1_ + "ms");
         UnknownVarFromHabboWindowManagerComponent_Boolean_2 = true;
         UnknownVarFromHabboWindowManagerComponent_HabboPagesViewer_1 = new HabboPagesViewer(this);
         UnknownVarFromHabboWindowManagerComponent_HabbletLinkHandler_1 = new HabbletLinkHandler(this);
         context.addLinkEventTracker(UnknownVarFromHabboWindowManagerComponent_HabbletLinkHandler_1);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("openlink",context.createLinkEvent);
         }
      }
      
      public function toggleFullScreen() : void
      {
         if(context.displayObjectContainer.stage.displayState == "fullScreenInteractive")
         {
            context.displayObjectContainer.stage.displayState = "normal";
         }
         else
         {
            context.displayObjectContainer.stage.displayState = "fullScreenInteractive";
         }
      }
      
      private function receiveProfilerInterface(param1:IID, param2:IUnknown) : void
      {
         var _loc3_:IProfiler_2 = param2 as IProfiler_2;
         if(_loc3_ != null)
         {
            if(!UnknownVarFromHabboWindowManagerComponent_ProfilerOutput_1)
            {
               UnknownVarFromHabboWindowManagerComponent_ProfilerOutput_1 = new ProfilerOutput(context,this,_windowRenderer);
            }
            UnknownVarFromHabboWindowManagerComponent_ProfilerOutput_1.profiler = _loc3_;
            _profilerAgentTaskUpdate = new ProfilerAgentTask("Update","Event processing");
            _loc3_.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskUpdate);
            _profilerAgentTaskRedraw = new ProfilerAgentTask("Redraw","Window rasterizer");
            _loc3_.getProfilerAgentForReceiver(this).addSubTask(_profilerAgentTaskRedraw);
            UnknownVarFromHabboWindowManagerComponent_Boolean_1 = true;
         }
      }
      
      private function receiveLoggerInterface(param1:IID, param2:IUnknown) : void
      {
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromHabboWindowManagerComponent_HabbletLinkHandler_1 != null)
            {
               context.removeLinkEventTracker(UnknownVarFromHabboWindowManagerComponent_HabbletLinkHandler_1);
               UnknownVarFromHabboWindowManagerComponent_HabbletLinkHandler_1.dispose();
               UnknownVarFromHabboWindowManagerComponent_HabbletLinkHandler_1 = null;
            }
            if(UnknownVarFromHabboWindowManagerComponent_ElementPointerHandler_1 != null)
            {
               UnknownVarFromHabboWindowManagerComponent_ElementPointerHandler_1.dispose();
               UnknownVarFromHabboWindowManagerComponent_ElementPointerHandler_1 = null;
            }
            removeUpdateReceiver(this);
            if(_bcfloorPlanEditor != null)
            {
               _bcfloorPlanEditor.dispose();
               _bcfloorPlanEditor = null;
            }
            if(UnknownVarFromHabboWindowManagerComponent_HabboPagesViewer_1)
            {
               UnknownVarFromHabboWindowManagerComponent_HabboPagesViewer_1.dispose();
               UnknownVarFromHabboWindowManagerComponent_HabboPagesViewer_1 = null;
            }
            if(_windowContextArray)
            {
               while(_windowContextArray.length > 0)
               {
                  IComponentInterfaceQueue(_windowContextArray.pop()).dispose();
               }
            }
            _windowContextArray = null;
            if(_windowRenderer)
            {
               _windowRenderer.dispose();
               _windowRenderer = null;
            }
            if(UnknownVarFromHabboWindowManagerComponent_SkinContainer_1)
            {
               UnknownVarFromHabboWindowManagerComponent_SkinContainer_1.dispose();
               UnknownVarFromHabboWindowManagerComponent_SkinContainer_1 = null;
            }
            if(_resourceManager != null)
            {
               _resourceManager.dispose();
               _resourceManager = null;
            }
            if(_hintManager != null)
            {
               _hintManager.dispose();
               _hintManager = null;
            }
            super.dispose();
         }
      }
      
      public function create(param1:String, param2:uint, param3:uint, param4:uint, param5:Rectangle, param6:Function = null, param7:String = "", param8:uint = 0, param9:Array = null, param10:IWindowModel = null, param11:Array = null, param12:String = "") : IWindowModel
      {
         return UnknownVarFromHabboWindowManagerComponent_IWindowContext_3_1.create(param1,param7,param2,param3,param4,param5,param6,param10,param8,param11,param12,param9);
      }
      
      public function destroy(param1:IWindowModel) : void
      {
         param1.destroy();
      }
      
      public function buildFromXML(param1:XML, param2:uint = 1, param3:Map = null) : IWindowModel
      {
         var _loc4_:IWindowModel = getWindowContext(param2).getWindowParser().parseAndConstruct(param1,null,param3);
         if(_loc4_ is IFrameController)
         {
            IFrameController(_loc4_).helpButtonAction = openHelpPage;
         }
         this.LilithCustomsInstance.HandleWindowFrameColor(_loc4_);
         return _loc4_;
      }
      
      public function windowToXMLString(param1:IWindowModel) : String
      {
         return UnknownVarFromHabboWindowManagerComponent_IWindowContext_3_1.getWindowParser().windowToXMLString(param1);
      }
      
      public function getLayoutByTypeAndStyle(param1:uint, param2:uint) : XML
      {
         return UnknownVarFromHabboWindowManagerComponent_SkinContainer_1.getWindowLayoutByTypeAndStyle(param1,param2);
      }
      
      public function getDefaultsByTypeAndStyle(param1:uint, param2:uint) : DefaultAttStruct
      {
         return UnknownVarFromHabboWindowManagerComponent_SkinContainer_1.getDefaultAttributesByTypeAndStyle(param1,param2);
      }
      
      public function getRendererByTypeAndStyle(param1:uint, param2:uint) : ISkinRenderer
      {
         return UnknownVarFromHabboWindowManagerComponent_SkinContainer_1.getSkinRendererByTypeAndStyle(param1,param2);
      }
      
      public function createWindow(param1:String, param2:String = "", param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:Rectangle = null, param7:Function = null, param8:uint = 0, param9:uint = 1, param10:String = "") : IWindowModel
      {
         return _windowContextArray[param9].create(param1,param2,param3,param4,param5,param6,param7,null,param8,null,null,null);
      }
      
      public function removeWindow(param1:String, param2:uint = 1) : void
      {
         var _loc3_:IDesktopController = null;
         _loc3_ = _windowContextArray[param2].getDesktopWindow();
         var _loc4_:IWindowModel = _loc3_.getChildByName(param1);
         if(_loc4_ != null)
         {
            _loc4_.destroy();
         }
      }
      
      public function getWindowByName(param1:String, param2:uint = 1) : IWindowModel
      {
         return _windowContextArray[param2].getDesktopWindow().getChildByName(param1);
      }
      
      public function getActiveWindow(param1:uint = 1) : IWindowModel
      {
         return _windowContextArray[param1].getDesktopWindow().getChildAt(UnknownVarFromHabboWindowManagerComponent_IWindowContext_3_1.getDesktopWindow().numChildren - 1);
      }
      
      public function getWindowContext(param1:uint) : IWindowContext_3
      {
         return _windowContextArray[param1];
      }
      
      public function getDesktop(param1:uint) : IDesktopController
      {
         var _loc2_:IWindowContext_3 = _windowContextArray[param1];
         return !!_loc2_ ? _loc2_.getDesktopWindow() : null;
      }
      
      public function notify(param1:String, param2:String, param3:Function, param4:uint = 0) : INotify
      {
         var _loc6_:ISoundAsset = assets.getAssetByName("habbo_window_alert_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new AlertDialog(this,_loc5_,param1,param2,param4,param3,false);
      }
      
      public function alert(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils1
      {
         var _loc6_:ISoundAsset = assets.getAssetByName("habbo_window_alert_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new AlertDialog(this,_loc5_,param1,param2,param3,param4,false);
      }
      
      public function alertWithModal(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils1
      {
         var _loc6_:ISoundAsset = assets.getAssetByName("habbo_window_alert_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new AlertDialog(this,_loc5_,param1,param2,param3,param4,true);
      }
      
      public function alertWithLink(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function) : UnknownICoreWindowUtils6
      {
         var _loc8_:ISoundAsset = assets.getAssetByName("habbo_window_alert_link_xml");
         if(!_loc8_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc7_:XML = _loc8_.content as XML;
         return new AlertDialogWithLink(this,_loc7_,param1,param2,param3,param4,param5,param6);
      }
      
      public function confirm(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils2
      {
         var _loc6_:ISoundAsset = assets.getAssetByName("habbo_window_confirm_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize aleret dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new ConfirmDialog(this,_loc5_,param1,param2,param3,param4,false);
      }
      
      public function confirmWithModal(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils2
      {
         var _loc6_:ISoundAsset = assets.getAssetByName("habbo_window_confirm_xml");
         if(!_loc6_)
         {
            throw new Error("Failed to initialize alert dialog; missing asset!");
         }
         var _loc5_:XML = _loc6_.content as XML;
         return new ConfirmDialog(this,_loc5_,param1,param2,param3,param4,true);
      }
      
      public function registerLocalizationParameter(param1:String, param2:String, param3:String, param4:String = "%") : void
      {
         _localization.registerParameter(param1,param2,param3,param4);
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = 0;
         if(UnknownVarFromHabboWindowManagerComponent_Boolean_1)
         {
            _profilerAgentTaskUpdate.start();
         }
         if(WindowContext.inputEventQueue.length > 0)
         {
            events.dispatchEvent(TRACKING_EVENT_INPUT);
            _loc2_ = 4 - 1;
            while(_loc2_ >= 0)
            {
               _windowContextArray[_loc2_].update(param1);
               _loc2_--;
            }
         }
         if(UnknownVarFromHabboWindowManagerComponent_Boolean_1)
         {
            _profilerAgentTaskUpdate.stop();
         }
         if(UnknownVarFromHabboWindowManagerComponent_Boolean_1)
         {
            _profilerAgentTaskRedraw.start();
         }
         events.dispatchEvent(TRACKING_EVENT_RENDER);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _windowContextArray[_loc2_].render(param1);
            _loc2_++;
         }
         if(UnknownVarFromHabboWindowManagerComponent_Boolean_1)
         {
            _profilerAgentTaskRedraw.stop();
         }
         if(WindowContext.inputEventQueue.length > 0)
         {
            WindowContext.inputEventQueue.flush();
         }
         MouseCursorControl.change();
         events.dispatchEvent(TRACKING_EVENT_SLEEP);
      }
      
      override public function purge() : void
      {
         super.purge();
         if(_windowRenderer)
         {
            _windowRenderer.purge();
         }
      }
      
      public function addMouseEventTracker(param1:IInputEventTracker) : void
      {
         for each(var _loc2_ in _windowContextArray)
         {
            _loc2_.addMouseEventTracker(param1);
         }
      }
      
      public function removeMouseEventTracker(param1:IInputEventTracker) : void
      {
         for each(var _loc2_ in _windowContextArray)
         {
            _loc2_.removeMouseEventTracker(param1);
         }
      }
      
      public function eventReceived(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param2 != null)
         {
            if(param1.type == "WME_CLICK")
            {
               ErrorReportStorage.setParameter("click_time",new Date().getTime().toString());
               ErrorReportStorage.setParameter("click_target",param2.name + ": " + param2.toString());
            }
            else if(param1.type == "WME_UP")
            {
               ErrorReportStorage.setParameter("mouse_up_time",new Date().getTime().toString());
               ErrorReportStorage.setParameter("mouse_up_target",param2.name + ": " + param2.toString());
            }
         }
      }
      
      private function performTestCases() : void
      {
         Logger.log("type: " + Capabilities.playerType + " debugger: " + Capabilities.isDebugger + " version: " + Capabilities.version);
      }
      
      public function findWindowByName(param1:String) : IWindowModel
      {
         var _loc2_:IWindowModel = null;
         for each(var _loc3_ in _windowContextArray)
         {
            _loc2_ = _loc3_.findWindowByName(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findWindowByTag(param1:String) : IWindowModel
      {
         var _loc2_:IWindowModel = null;
         for each(var _loc3_ in _windowContextArray)
         {
            _loc2_ = _loc3_.findWindowByTag(param1);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function groupWindowsWithTag(param1:String, param2:Array, param3:int = 0) : uint
      {
         var _loc4_:uint = 0;
         for each(var _loc5_ in _windowContextArray)
         {
            _loc4_ += _loc5_.groupChildrenWithTag(param1,param2,param3);
         }
         return _loc4_;
      }
      
      public function getThemeManager() : IThemeManager
      {
         return UnknownVarFromHabboWindowManagerComponent_ThemeManager_1;
      }
      
      public function createUnseenItemCounter() : IWindowController_1
      {
         var _loc1_:ISoundAsset = assets.getAssetByName("unseen_item_counter_xml") as ISoundAsset;
         var _loc2_:XML = _loc1_.content as XML;
         return buildFromXML(_loc2_) as IWindowController_1;
      }
      
      public function createWidget(param1:String, param2:IWidgetWindowController) : IWindowController_2
      {
         var _loc3_:Class = WidgetClasses.UnknownVarFromWidgetClasses_Dictionary_1[param1];
         if(_loc3_ != null)
         {
            return new _loc3_(param2,this);
         }
         throw new Error("Unknown widget type " + param1 + "! You might need to update Glaze to be able to work on this layout.");
      }
      
      public function get avatarRenderer() : IAvatarRenderManager
      {
         return _avatarRenderer;
      }
      
      public function get resourceManager() : IResourceManager
      {
         return _resourceManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function buildModalDialogFromXML(param1:XML) : IModalDialog
      {
         return new ModalDialog(this,param1);
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function simpleAlert(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:Map = null, param7:String = null, param8:Function = null, param9:Function = null) : void
      {
         new SimpleAlertDialog(this,param1,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      
      public function registerHintWindow(param1:String, param2:IWindowModel, param3:int = 1) : void
      {
         _hintManager.registerWindow(param1,param2,param3);
      }
      
      public function unregisterHintWindow(param1:String) : void
      {
         _hintManager.unregisterWindow(param1);
      }
      
      public function showHint(param1:String, param2:Rectangle = null) : void
      {
         _hintManager.showHint(param1,param2);
      }
      
      public function hideHint() : void
      {
         _hintManager.hideHint();
      }
      
      public function hideMatchingHint(param1:String) : void
      {
         _hintManager.hideMatchingHint(param1);
      }
      
      public function displayFloorPlanEditor() : void
      {
         if(_bcfloorPlanEditor == null)
         {
            _bcfloorPlanEditor = new BCFloorPlanEditor(this);
         }
         if(_bcfloorPlanEditor != null)
         {
            _bcfloorPlanEditor.visible = true;
         }
      }
      
      public function openHelpPage(param1:String) : void
      {
         if(UnknownVarFromHabboWindowManagerComponent_HabboPagesViewer_1 != null)
         {
            UnknownVarFromHabboWindowManagerComponent_HabboPagesViewer_1.openPage(param1);
         }
      }
      
      public function get habboPagesStyleSheet() : StyleSheet
      {
         return HabboPagesViewer.styleSheet;
      }
      
      public function get freeFlowChat() : IHabboFreeFlowChat
      {
         return _freeFlowChat;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
   }
}

