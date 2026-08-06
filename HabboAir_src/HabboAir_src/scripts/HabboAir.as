package
{
   import com.sulake.air.FileProxy;
   import com.sulake.air.NativeApplicationProxy;
   import com.sulake.core.Core;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.CoreComponentContext;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.ICoreComponentContext;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknownCoreRuntime1_1;
   import com.sulake.core.runtime.IUnknownCoreRuntime1_2;
   import com.sulake.core.runtime.events.ErrorEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.MouseWheelEnabler;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.PlatformData;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDRoomEngine;
   import flash.desktop.NativeApplication;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.BrowserInvokeEvent;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.InvokeEvent;
   import flash.events.ProgressEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import login.LoginFlow;
   
   [SecureSWF(rename="false")]
   public class HabboAir extends MovieClip
   {
      public static const CORE_RATIO:Number = 0.6;
      
      private static const INIT_STEPS:int = 3;
      
      protected static var PROCESSLOG_ENABLED:Boolean = false;
      
      public static const ERROR_VARIABLE_IS_FATAL:String = "is_fatal";
      
      public static const ERROR_VARIABLE_CLIENT_CRASH_TIME:String = "crash_time";
      
      public static const ERROR_VARIABLE_CONTEXT:String = "error_ctx";
      
      public static const ERROR_VARIABLE_FLASH_VERSION:String = "flash_version";
      
      public static const ERROR_VARIABLE_AVERAGE_UPDATE_INTERVAL:String = "avg_update";
      
      public static const ERROR_VARIABLE_DEBUG:String = "debug";
      
      public static const ERROR_VARIABLE_DESCRIPTION:String = "error_desc";
      
      public static const ERROR_VARIABLE_CATEGORY:String = "error_cat";
      
      public static const ERROR_VARIABLE_DATA:String = "error_data";
      
      private static const RECEPTION_LOG_STEP_FUNCTION:String = "NewUserReception.logStep";
      
      private static const STEP_NUX_ENTERED:String = "NUX_ENTERED";
      
      private static const STEP_RECEPTION_EXITED:String = "RECEPTION_EXITED";
      
      private static const STEP_NUX_EXITED:String = "NUX_EXITED";
      
      private static const STEP_CLIENT_LOADED:String = "CLIENT_LOADED";
      
      public static const ERROR_CATEGORY_FINALIZE_PRELOADING:int = 9;
      
      public static const ERROR_CATEGORY_DOWNLOAD_FONT:int = 11;
      
      public static const ERROR_UNCAUGHT_ERROR:int = 40;
      
      private static const LOCKED_COMPONENT_LOG_INTERVAL_MS:int = 2000;
      
      private static const LOCKED_COMPONENT_LOG_WARNING_DELAY_MS:int = 10000;
      
      private static const SANDBOX_CRASH_URL:String = "https://sandbox.habbo.com/api/log/crash";
      
      private static const S2_ENVIRONMENT_ID:String = "s2";
      
      private static const ARGUMENT_ENVIRONMENT:String = "server";
      
      private static const ARGUMENT_SSO_TOKEN:String = "ticket";
      
      private static var UnknownVarFromHabboAir_String_1:String = "https://www.habbo.com/api/log/crash";
      
      private static var UnknownVarFromHabboAir_Boolean_1:Boolean = false;
      
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 15000;
      
      private static var _lastRequestTime:Date;
      
      private var _loadingScreen:IHabboLoadingScreen;
      
      private var _startTime:int;
      
      private var _loginFlow:LoginFlow = null;
      
      private var UnknownVarFromHabboAir_Boolean_2:Boolean;
      
      private var UnknownVarFromHabboAir_Boolean_3:Boolean;
      
      private var UnknownVarFromHabboAir_Boolean_4:Boolean = true;
      
      private var _core:ICoreComponentContext;
      
      private var UnknownVarFromHabboAir_Int_1:int = 3;
      
      private var _loadedFiles:int = 0;
      
      private var _completedInitSteps:int = 0;
      
      private var UnknownVarFromHabboAir_Boolean_5:Boolean = false;
      
      private var UnknownVarFromHabboAir_Boolean_6:Boolean = false;
      
      private var _prepareCoreOnNextFrame:Boolean = false;
      
      private var UnknownVarFromHabboAir_Boolean_7:Boolean = false;
      
      private var UnknownVarFromHabboAir_Boolean_8:Boolean = false;
      
      private var UnknownVarFromHabboAir_Int_2:int = 0;
      
      private var UnknownVarFromHabboAir_Object_1:Object;
      
      private var UnknownVarFromHabboAir_Boolean_9:Boolean = false;
      
      private var UnknownVarFromHabboAir_Dictionary_1:Dictionary;
      
      public function HabboAir()
      {
         var _loc1_:§_o_-_--§ = new §_o_-_--§();
         if(!_loc1_.§_o_---_§(this))
         {
            return;
         }
         UnknownVarFromHabboAir_Object_1 = {};
         super();
         _startTime = getTimer();
         stop();
         UnknownVarFromHabboAir_Dictionary_1 = new Dictionary();
         if(stage)
         {
            onAddedToStage();
         }
         else
         {
            this.addEventListener("addedToStage",onAddedToStage);
         }
         NativeApplication.nativeApplication.addEventListener("invoke",onInvoke);
         NativeApplication.nativeApplication.addEventListener("browserInvoke",onBrowserInvoke);
         NativeApplication.nativeApplication.addEventListener("exiting",onApplicationExiting);
      }
      
      public static function trackLoginStep(param1:String, param2:String = null) : void
      {
         Logger.log("* HabboMain Login Step: " + param1);
         if(PROCESSLOG_ENABLED)
         {
            try
            {
               if(ExternalInterface.available)
               {
                  if(param2 != null)
                  {
                     ExternalInterface.call("FlashExternalInterface.logLoginStep",param1,param2);
                  }
                  else
                  {
                     ExternalInterface.call("FlashExternalInterface.logLoginStep",param1);
                  }
               }
               else
               {
                  Logger.log("ExternalInterface is not available, tracking is disabled");
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public static function reportCrash(param1:String, param2:int, param3:Boolean, param4:Error = null, param5:IUnknownCoreRuntime1_2 = null) : void
      {
      }
      
      public static function reportCrashStack(param1:String, param2:int, param3:Boolean, param4:String, param5:IUnknownCoreRuntime1_2 = null) : void
      {
      }
      
      private function onBrowserInvoke(param1:BrowserInvokeEvent) : void
      {
         Logger.log("Received Browser Invoke: " + param1.arguments);
         NativeApplication.nativeApplication.removeEventListener("browserInvoke",onBrowserInvoke);
         parseArguments(param1.arguments);
      }
      
      private function onInvoke(param1:InvokeEvent) : void
      {
         NativeApplication.nativeApplication.removeEventListener("invoke",onInvoke);
         parseArguments(param1.arguments);
      }
      
      private function parseArguments(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc4_:* = null;
         UnknownVarFromHabboAir_Dictionary_1 = new Dictionary();
         if(param1 && param1.length)
         {
            if(param1.length % 2 != 0)
            {
            }
            _loc2_ = param1.length / 2;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc3_ * 2 + 1 < param1.length)
               {
                  _loc5_ = param1[_loc3_ * 2];
                  _loc4_ = param1[_loc3_ * 2 + 1];
                  _loc5_ = _loc5_.replace("-","");
                  if(_loc5_ == "server")
                  {
                     _loc4_ = _loc4_.replace("hh","");
                     _loc4_ = _loc4_.replace("br","pt");
                     _loc4_ = _loc4_.replace("us","en");
                     UnknownVarFromHabboAir_Dictionary_1["environment.id"] = _loc4_;
                     CommunicationUtils.writeSOLProperty("environment",_loc4_);
                  }
                  if(_loc5_ == "ticket")
                  {
                     _loc4_ = _loc4_.split(".")[0] + "." + _loc4_.split(".")[1];
                     UnknownVarFromHabboAir_Dictionary_1["sso.token"] = _loc4_;
                  }
               }
               _loc3_++;
            }
         }
         UnknownVarFromHabboAir_Boolean_3 = true;
         tryInit();
      }
      
      private function onAddedToStage(param1:Event = null) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         UnknownVarFromHabboAir_Boolean_2 = true;
         tryInit();
      }
      
      private function tryInit() : void
      {
         var clientFatalErrorUrl:String;
         var urlPrefix:String;
         if(!UnknownVarFromHabboAir_Boolean_3 || !UnknownVarFromHabboAir_Boolean_2)
         {
            return;
         }
         clientFatalErrorUrl = UnknownVarFromHabboAir_Dictionary_1["client.fatal.error.url"];
         if(clientFatalErrorUrl != null)
         {
            UnknownVarFromHabboAir_String_1 = clientFatalErrorUrl;
         }
         else
         {
            urlPrefix = UnknownVarFromHabboAir_Dictionary_1["url.prefix"];
            if(urlPrefix != null)
            {
               UnknownVarFromHabboAir_String_1 = urlPrefix + "/flash_client_error";
            }
         }
         if(isSandboxConnection())
         {
            UnknownVarFromHabboAir_String_1 = "https://sandbox.habbo.com/api/log/crash";
         }
         PROCESSLOG_ENABLED = UnknownVarFromHabboAir_Dictionary_1["processlog.enabled"] == "1";
         trackLoginStep("client.init.start");
         stage.scaleMode = "noScale";
         stage.quality = "low";
         stage.align = "TL";
         stage.nativeWindow.title = "HabboAirPlus";
         stage.nativeWindow.maximize();
         root.loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError",function(param1:UncaughtErrorEvent):void
         {
            reportCrash("Uncaught client error, eventType: " + param1.type + " errorID: " + param1.errorID + " runtime: " + (getTimer() - _startTime) / 1000 + "s",40,true,param1.error);
         });
         createLoginFlowOrLoadingScreen();
         startCoreInitializationIfPossible();
         MouseWheelEnabler.init(stage);
      }
      
      private function isSandboxConnection() : Boolean
      {
         var _loc1_:String = UnknownVarFromHabboAir_Dictionary_1["environment.id"];
         return _loc1_ != null && _loc1_.toLowerCase() == "s2";
      }
      
      private function onLoginFlowFinished(param1:Event) : void
      {
         UnknownVarFromHabboAir_Dictionary_1["sso.token"] = _loginFlow.ssoToken;
         UnknownVarFromHabboAir_Dictionary_1["environment.id"] = CommunicationUtils.readSOLString("environment");
         _loginFlow.removeEventListener("LOGIN_FLOW_FINISHED_EVENT",onLoginFlowFinished);
         _loginFlow.dispose();
         _loginFlow = null;
         _loadingScreen = null;
         createLoadingScreen();
         startCoreInitializationIfPossible();
      }
      
      private function clone(param1:Dictionary) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         for(var _loc3_ in param1)
         {
            if(param1[_loc3_] is Dictionary)
            {
               _loc2_[_loc3_] = clone(param1[_loc3_]);
            }
            else
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
         }
         return _loc2_;
      }
      
      private function createLoginFlowOrLoadingScreen() : void
      {
         if(!ssoTokenAvailable && UnknownVarFromHabboAir_Boolean_4)
         {
            _loginFlow = new LoginFlow(clone(UnknownVarFromHabboAir_Dictionary_1));
            _loginFlow.addEventListener("LOGIN_FLOW_FINISHED_EVENT",onLoginFlowFinished);
            stage.addChild(_loginFlow);
            _loginFlow.init();
            updateLoadingBarProgress();
            return;
         }
         createLoadingScreen();
      }
      
      public function createLoadingScreen() : void
      {
         _loadingScreen = new HabboLoadingScreen(stage.stageWidth,stage.stageHeight,clone(UnknownVarFromHabboAir_Dictionary_1));
         updateLoadingBarProgress();
         stage.addChild(DisplayObject(_loadingScreen));
      }
      
      private function updateLoadingBarProgress() : void
      {
         if(_loadingScreen != null)
         {
            _loadingScreen.updateLoadingBar(0.6);
         }
      }
      
      private function startCoreInitializationIfPossible() : void
      {
         if(UnknownVarFromHabboAir_Boolean_7)
         {
            return;
         }
         if(_loadingScreen == null)
         {
            return;
         }
         UnknownVarFromHabboAir_Boolean_7 = true;
         trackLoginStep("client.init.swf.loaded");
         logApplicationInfo();
         Logger.log(getQualifiedClassName(Core) + " version: " + Core.version);
         addEventListener("exitFrame",onExitFrame);
         _prepareCoreOnNextFrame = true;
      }
      
      private function logApplicationInfo() : void
      {
         if(UnknownVarFromHabboAir_Boolean_8)
         {
            return;
         }
         UnknownVarFromHabboAir_Boolean_8 = true;
         var _loc2_:XML = NativeApplication.nativeApplication.applicationDescriptor;
         var _loc4_:Namespace = _loc2_.namespace();
         var _loc1_:String = _loc2_._loc4_::copyright;
         var _loc3_:String = _loc2_._loc4_::versionLabel;
         var _loc5_:String = _loc2_._loc4_::versionNumber;
         Logger.log("AIR Runtime version: " + NativeApplication.nativeApplication.runtimeVersion);
         Logger.log("Application ID: " + NativeApplication.nativeApplication.applicationID);
         Logger.log("Copyright: " + _loc1_);
         Logger.log("Version: " + _loc3_);
         Logger.log("VersionNumber: " + _loc5_);
      }
      
      protected function onExitFrame(param1:Event = null) : void
      {
         if(_prepareCoreOnNextFrame)
         {
            _prepareCoreOnNextFrame = false;
            prepareCore();
            return;
         }
         if(UnknownVarFromHabboAir_Boolean_5 && UnknownVarFromHabboAir_Boolean_6)
         {
            disposeLoadingScreen();
            removeEventListener("exitFrame",onExitFrame);
         }
      }
      
      private function prepareCore() : void
      {
         var _loc2_:IUnknownCoreRuntime1_1 = null;
         var _loc1_:IEventDispatcher = null;
         var _loc3_:XML = null;
         try
         {
            _loc2_ = Capabilities.playerType != "StandAlone" ? new HabboCoreErrorReporter() : null;
            _core = Core.instantiate(stage,1,_loc2_,UnknownVarFromHabboAir_Dictionary_1);
            _loc1_ = getCoreEventDispatcher();
            if(_loc1_ != null)
            {
               _loc1_.addEventListener("COMPONENT_EVENT_ERROR",onCoreError);
               _loc1_.addEventListener("COMPONENT_EVENT_REBOOT",onCoreReboot);
            }
            _core.prepareComponent(HabboTrackingLib);
            addEventListener("progress",onProgressEvent);
            addEventListener("complete",onCompleteEvent);
            _loc3_ = <config>
					<asset-libraries>
						<library url="hh_human_body.swf"/>
						<library url="hh_human_item.swf"/>
					</asset-libraries>
					<service-libraries/>
					<component-libraries/>
				</config>;
            _loc3_ = new XML();
            _core.readConfigDocument(_loc3_,this);
            (_core as CoreComponentContext).fileProxy = new FileProxy();
            if(PlatformData.nativeApplicationProxy)
            {
               PlatformData.nativeApplicationProxy.dispose();
            }
            PlatformData.nativeApplicationProxy = new NativeApplicationProxy();
            UnknownVarFromHabboAir_Int_1 = _core.getNumberOfFilesPending() + _core.getNumberOfFilesLoaded() + 3;
            _core.prepareComponent(CoreCommunicationFrameworkLib);
            _core.prepareComponent(HabboRoomObjectLogicLib);
            _core.prepareComponent(HabboRoomObjectVisualizationLib);
            _core.prepareComponent(RoomManagerLib);
            _core.prepareComponent(RoomSpriteRendererLib);
            _core.prepareComponent(HabboRoomSessionManagerLib);
            _core.prepareComponent(HabboAvatarRenderLib);
            _core.prepareComponent(HabboSessionDataManagerLib);
            _core.prepareComponent(HabboConfigurationCom);
            _core.prepareComponent(HabboLocalizationCom);
            _core.prepareComponent(HabboWindowManagerCom);
            _core.prepareComponent(HabboCommunicationCom);
            _core.prepareComponent(HabboCommunicationDemoCom);
            _core.prepareComponent(HabboNavigatorCom);
            _core.prepareComponent(HabboFriendListCom);
            _core.prepareComponent(HabboMessengerCom);
            _core.prepareComponent(HabboInventoryCom);
            _core.prepareComponent(HabboToolbarCom);
            _core.prepareComponent(HabboCatalogCom);
            _core.prepareComponent(HabboRoomEngineCom);
            _core.prepareComponent(HabboRoomUICom);
            _core.prepareComponent(HabboAvatarEditorCom);
            _core.prepareComponent(HabboNotificationsCom);
            _core.prepareComponent(HabboHelpCom);
            _core.prepareComponent(HabboAdManagerCom);
            _core.prepareComponent(HabboModerationCom);
            _core.prepareComponent(HabboUserDefinedRoomEventsCom);
            _core.prepareComponent(HabboSoundManagerFlash10Com);
            _core.prepareComponent(HabboQuestEngineCom);
            _core.prepareComponent(HabboFriendBarCom);
            _core.prepareComponent(HabboGroupsCom);
            _core.prepareComponent(HabboGamesCom);
            _core.prepareComponent(HabboFreeFlowChatCom);
            _core.prepareComponent(HabboDiscordCom);
            _core.prepareComponent(HabboNewNavigatorCom);
            addInitializationProgressListeners();
            startLockedComponentLogging();
         }
         catch(error:Error)
         {
            HabboAir.trackLoginStep("client.init.core.fail");
            HabboAir.reportCrash("Failed to prepare the core: " + error.message,10,true,error);
            showLoadingError("Failed to prepare the core: " + error.message,10);
            Core.dispose();
         }
      }
      
      private function updateProgressBar() : void
      {
         var _loc1_:Number = NaN;
         if(_loadingScreen != null)
         {
            _loc1_ = 0.6 + (_completedInitSteps + _loadedFiles) / UnknownVarFromHabboAir_Int_1 * (1 - 0.6);
            _loadingScreen.updateLoadingBar(_loc1_);
         }
      }
      
      private function onProgressEvent(param1:ProgressEvent) : void
      {
         _loadedFiles = _core.getNumberOfFilesLoaded();
         updateProgressBar();
      }
      
      private function onCompleteEvent(param1:Event) : void
      {
         removeEventListener("progress",onProgressEvent);
         removeEventListener("complete",onCompleteEvent);
         initializeCore();
      }
      
      private function initializeCore() : void
      {
         HabboAir.trackLoginStep("client.init.core.init");
         try
         {
            _core.initialize();
            if(ExternalInterface.available)
            {
               ExternalInterface.addCallback("unloading",unloading);
            }
         }
         catch(error:Error)
         {
            HabboAir.trackLoginStep("client.init.core.fail");
            showLoadingError("Failed to initialize the core: " + error.message,10);
            Core.crash("Failed to initialize the core: " + error.message,10,error);
         }
      }
      
      private function showLoadingError(param1:String, param2:int = -1) : void
      {
         removeEventListener("exitFrame",onExitFrame);
         removeEventListener("progress",onProgressEvent);
         removeEventListener("complete",onCompleteEvent);
         stopLockedComponentLogging();
         _prepareCoreOnNextFrame = false;
         UnknownVarFromHabboAir_Boolean_7 = false;
         if(_loadingScreen != null && !_loadingScreen.disposed)
         {
            _loadingScreen.showError(formatLoadingErrorMessage(param1,param2));
         }
      }
      
      private function formatLoadingErrorMessage(param1:String, param2:int) : String
      {
         var _loc3_:String = null;
         var _loc4_:* = null;
         var _loc5_:String = param1 == null ? "" : param1.replace(/\s+/g," ").replace(/^\s+|\s+$/g,"");
         var _loc6_:String = _loc5_.toLowerCase();
         if(param2 == 8 || param2 == 7 || _loc6_.indexOf("gamedata") > -1 || _loc6_.indexOf("product data") > -1 || _loc6_.indexOf("localization") > -1)
         {
            _loc3_ = "Failed to download required game data.\nPlease check your connection and restart the client.";
         }
         else if(param2 == 2 || param2 == 5 || _loc6_.indexOf("download") > -1)
         {
            _loc3_ = "Failed to download required client libraries.\nPlease check your connection and restart the client.";
         }
         else
         {
            _loc3_ = "Client startup failed.\nPlease restart the client.";
         }
         if(_loc5_ != "")
         {
            _loc4_ = _loc5_;
            if(_loc4_.length > 220)
            {
               _loc4_ = _loc4_.substr(0,220) + "...";
            }
            _loc3_ += "\n\nDetails: " + _loc4_;
         }
         return _loc3_;
      }
      
      private function getCoreEventDispatcher() : IEventDispatcher
      {
         var _loc1_:IComponent_2 = _core as IComponent_2;
         return _loc1_ != null ? _loc1_.events : null;
      }
      
      public function unloading() : void
      {
         var _loc1_:IEventDispatcher = null;
         try
         {
            if(_core && !_core.disposed)
            {
               ErrorReportStorage.addDebugData("Unload","Client unloading started");
               _loc1_ = getCoreEventDispatcher();
               if(_loc1_ != null)
               {
                  _loc1_.dispatchEvent(new Event("unload"));
               }
            }
         }
         catch(error:Error)
         {
         }
      }
      
      public function onCoreError(param1:Event) : void
      {
         var _loc4_:String = "Unknown core error";
         var _loc3_:int = -1;
         var _loc5_:Boolean = false;
         var _loc2_:Error = null;
         var _loc6_:ErrorEvent = param1 as ErrorEvent;
         if(_loc6_ != null)
         {
            _loc4_ = _loc6_.message;
            _loc3_ = _loc6_.category;
            _loc5_ = _loc6_.critical;
            _loc2_ = _loc6_.error;
         }
         Logger.log("onCoreError type=" + param1.type + " critical=" + _loc5_ + " category=" + _loc3_ + " message=" + _loc4_);
         if(_loc5_ && _loadingScreen != null && !_loadingScreen.disposed)
         {
            showLoadingError(_loc4_,_loc3_);
         }
         if(_loc5_)
         {
            HabboAir.reportCrash(_loc4_,_loc3_,true,_loc2_);
         }
      }
      
      private function onApplicationExiting(param1:Event) : void
      {
         shutdownCore();
      }
      
      private function shutdownCore() : void
      {
         if(UnknownVarFromHabboAir_Boolean_9)
         {
            return;
         }
         UnknownVarFromHabboAir_Boolean_9 = true;
         stopLockedComponentLogging();
         unloading();
         NativeApplication.nativeApplication.removeEventListener("exiting",onApplicationExiting);
         var _loc1_:IEventDispatcher = getCoreEventDispatcher();
         if(_loc1_ != null)
         {
            _loc1_.removeEventListener("COMPONENT_EVENT_ERROR",onCoreError);
            _loc1_.removeEventListener("COMPONENT_EVENT_REBOOT",onCoreReboot);
            _loc1_.removeEventListener("COMPONENT_EVENT_RUNNING",onCoreRunning);
         }
         Core.dispose();
         _core = null;
      }
      
      private function onCoreReboot(param1:Event) : void
      {
         Logger.log("Reboot application! " + System.privateMemory,System.totalMemory,System.totalMemoryNumber);
         shutdownCore();
         Logger.log("Application ready for restart! " + System.privateMemory,System.totalMemory,System.totalMemoryNumber);
         NativeApplication.nativeApplication.exit(1);
      }
      
      private function simpleQueueInterface(param1:IID, param2:Function) : void
      {
         var _loc3_:Object = _core.queueInterface(param1,param2);
         if(_loc3_ != null)
         {
            param2(param1,_loc3_);
         }
      }
      
      private function addInitializationProgressListeners() : void
      {
         var coreEvents:IEventDispatcher;
         simpleQueueInterface(new IIDHabboLocalizationManager(),function(param1:IID, param2:Component):void
         {
            param2.events.addEventListener("complete",onLocalizationComplete);
         });
         simpleQueueInterface(new IIDHabboConfigurationManager(),onConfigurationComplete);
         simpleQueueInterface(new IIDRoomEngine(),function(param1:IID, param2:Component):void
         {
            param2.events.addEventListener("REE_ENGINE_INITIALIZED",onRoomEngineReady);
         });
         coreEvents = getCoreEventDispatcher();
         if(coreEvents != null)
         {
            coreEvents.addEventListener("COMPONENT_EVENT_RUNNING",onCoreRunning);
         }
      }
      
      private function startLockedComponentLogging() : void
      {
         if(UnknownVarFromHabboAir_Int_2 != 0)
         {
            return;
         }
         if(!(_core is CoreComponentContext))
         {
            return;
         }
         UnknownVarFromHabboAir_Int_2 = setInterval(logLockedComponents,2000);
         logLockedComponents();
      }
      
      private function stopLockedComponentLogging() : void
      {
         if(UnknownVarFromHabboAir_Int_2 != 0)
         {
            clearInterval(UnknownVarFromHabboAir_Int_2);
            UnknownVarFromHabboAir_Int_2 = 0;
         }
         UnknownVarFromHabboAir_Object_1 = {};
      }
      
      private function logLockedComponents() : void
      {
         var _loc6_:String = null;
         var _loc10_:* = undefined;
         var _loc2_:String = null;
         var _loc7_:Object = null;
         if(!(_core is CoreComponentContext))
         {
            stopLockedComponentLogging();
            return;
         }
         var _loc4_:CoreComponentContext = _core as CoreComponentContext;
         var _loc8_:Array = _loc4_.getLockedComponents();
         if(_loc8_.length == 0)
         {
            stopLockedComponentLogging();
            return;
         }
         var _loc3_:int = getTimer();
         var _loc5_:Object = {};
         for each(var _loc1_ in _loc8_)
         {
            _loc6_ = getQualifiedClassName(_loc1_);
            _loc10_ = _loc1_.requiredDependencyIids;
            _loc2_ = _loc10_ != null && _loc10_.length > 0 ? _loc10_.join(", ") : "dependencies to finish";
            _loc7_ = UnknownVarFromHabboAir_Object_1[_loc6_];
            if(!_loc7_)
            {
               _loc7_ = {
                  "firstSeen":_loc3_,
                  "lastReport":0,
                  "description":_loc2_
               };
               UnknownVarFromHabboAir_Object_1[_loc6_] = _loc7_;
            }
            else if(_loc7_.description != _loc2_)
            {
               Logger.log("[CoreInit] Component " + _loc6_ + " dependency wait updated to: " + _loc2_);
               _loc7_.description = _loc2_;
               _loc7_.lastReport = 0;
            }
            _loc5_[_loc6_] = true;
            if(_loc3_ - _loc7_.firstSeen >= 10000 && _loc3_ - _loc7_.lastReport >= 10000)
            {
               Logger.log("[CoreInit] Component " + _loc6_ + " still locked after " + ((_loc3_ - _loc7_.firstSeen) / 1000).toFixed(1) + "s, waiting for: " + _loc2_);
               _loc7_.lastReport = _loc3_;
            }
         }
         for(var _loc9_ in UnknownVarFromHabboAir_Object_1)
         {
            if(!_loc5_[_loc9_])
            {
               delete UnknownVarFromHabboAir_Object_1[_loc9_];
            }
         }
      }
      
      private function onLocalizationComplete(param1:Event) : void
      {
         HabboAir.trackLoginStep("client.init.localization.loaded");
         _completedInitSteps++;
         updateProgressBar();
      }
      
      private function onConfigurationComplete(param1:IID, param2:Component) : void
      {
         HabboAir.trackLoginStep("client.init.config.loaded");
         _completedInitSteps++;
         updateProgressBar();
      }
      
      private function onRoomEngineReady(param1:Event) : void
      {
         UnknownVarFromHabboAir_Boolean_5 = true;
         HabboAir.trackLoginStep("client.init.room.ready");
         if(_core.getInteger("spaweb",0) == 1)
         {
            startSendingHeartBeat();
         }
      }
      
      private function startSendingHeartBeat() : void
      {
         sendHeartBeat();
         setInterval(sendHeartBeat,10000);
      }
      
      private function sendHeartBeat() : void
      {
         HabboWebTools.sendHeartBeat();
      }
      
      private function onCoreRunning(param1:Event) : void
      {
         UnknownVarFromHabboAir_Boolean_6 = true;
         HabboAir.trackLoginStep("client.init.core.running");
         _completedInitSteps++;
         updateProgressBar();
      }
      
      private function disposeLoadingScreen() : void
      {
         stopLockedComponentLogging();
         if(_loadingScreen != null)
         {
            _loadingScreen.dispose();
            if(DisplayObject(_loadingScreen).parent)
            {
               DisplayObject(_loadingScreen).parent.removeChild(DisplayObject(_loadingScreen));
            }
            _loadingScreen = null;
         }
         var _loc1_:IEventDispatcher = getCoreEventDispatcher();
         if(_loc1_ != null)
         {
            _loc1_.removeEventListener("COMPONENT_EVENT_RUNNING",onCoreRunning);
         }
      }
      
      private function get ssoTokenAvailable() : Boolean
      {
         var _loc1_:String = UnknownVarFromHabboAir_Dictionary_1["sso.token"];
         return _loc1_ != null && _loc1_.length > 0;
      }
   }
}

import com.sulake.core.runtime.IUnknownCoreRuntime1_1;
import com.sulake.core.runtime.IUnknownCoreRuntime1_2;

class HabboCoreErrorReporter implements IUnknownCoreRuntime1_1
{
   private var _logger:IUnknownCoreRuntime1_2;
   
   public function HabboCoreErrorReporter()
   {
      super();
   }
   
   public function logError(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : void
   {
      HabboAir.reportCrash(param1,param3,param2,param4,_logger);
   }
   
   public function set errorLogger(param1:IUnknownCoreRuntime1_2) : void
   {
      _logger = param1;
   }
}
