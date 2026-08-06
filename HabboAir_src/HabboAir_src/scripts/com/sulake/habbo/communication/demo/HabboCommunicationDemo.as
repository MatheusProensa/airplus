package com.sulake.habbo.communication.demo
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ErrorEvent;
   import com.sulake.core.runtime.events.HotelViewEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.IHabboWebApiSession_3;
   import com.sulake.habbo.communication.login.AvatarData;
   import com.sulake.habbo.communication.login.ILoginProvider;
   import com.sulake.habbo.communication.login.WebApiLoginProvider;
   import com.sulake.habbo.communication.messages.incoming.handshake.*;
   import com.sulake.habbo.communication.messages.outgoing.handshake.*;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.*;
   import flash.display.Stage;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.system.Capabilities;
   import flash.utils.Timer;
   
   [SecureSWF(rename="true")]
   public class HabboCommunicationDemo extends Component
   {
      public static const ERROR_TYPE_IO_ERROR:String = "ioError";
      
      public static const ERROR_CODE_MAINTENANCE:String = "maintenance";
      
      private static const AUTO_RECONNECT:Boolean = false;
      
      private var UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1:HabboLoginDemoScreen;
      
      private var _logoutInProgress:Boolean;
      
      private var UnknownVarFromHabboCommunicationDemo_String_1:String;
      
      private var _incomingMessages:IncomingMessages;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromHabboCommunicationDemo_String_2:String;
      
      private var UnknownVarFromHabboCommunicationDemo_String_3:String;
      
      private var _loginName:String;
      
      private var UnknownVarFromHabboCommunicationDemo_String_4:String;
      
      private var UnknownVarFromHabboCommunicationDemo_ILoginProvider_1:ILoginProvider;
      
      private var UnknownVarFromHabboCommunicationDemo_Boolean_1:Boolean;
      
      private var _autoLogin:Boolean;
      
      private var UnknownVarFromHabboCommunicationDemo_Boolean_2:Boolean;
      
      private var UnknownVarFromHabboCommunicationDemo_ErrorPopupCtrl_1:ErrorPopupCtrl;
      
      public function HabboCommunicationDemo(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         param1.events.addEventListener("unload",unloading);
         UnknownVarFromHabboCommunicationDemo_ErrorPopupCtrl_1 = new ErrorPopupCtrl(param1,0,param3);
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function set ssoTicket(param1:String) : void
      {
         UnknownVarFromHabboCommunicationDemo_String_2 = param1;
      }
      
      public function set flashClientUrl(param1:String) : void
      {
         UnknownVarFromHabboCommunicationDemo_String_3 = param1;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         },!isRoomViewerMode),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         },true,[{
            "type":"complete",
            "callback":onLocalizationsComplete
         },{
            "type":"LOCALIZATION_EVENT_LOCALIZATION_FAILED",
            "callback":onLocalizationFailed
         }])]);
      }
      
      override protected function initComponent() : void
      {
         Core.instance.events.addEventListener("COMPONENT_EVENT_ERROR",onCoreError);
         var _loc1_:Stage = context.displayObjectContainer.stage;
         if(_loc1_ != null)
         {
            _loc1_.dispatchEvent(new HotelViewEvent("HOTEL_VIEW_READY"));
         }
         UnknownVarFromHabboCommunicationDemo_Boolean_1 = false;
         if(_incomingMessages)
         {
            _incomingMessages.dispose();
            if(_communication)
            {
               _communication.renewSocket();
            }
         }
         _incomingMessages = new IncomingMessages(this,_communication);
         context.events.addEventListener("HHVE_ERROR",onHotelViewError);
         prepareProperties();
         HabboWebTools.baseUrl = getProperty("url.prefix");
         if(_autoLogin)
         {
            initWithStoredCredentials();
         }
         else if(UnknownVarFromHabboCommunicationDemo_String_2)
         {
            initWithSSO(UnknownVarFromHabboCommunicationDemo_String_2);
         }
         else
         {
            initWithLoginView();
         }
      }
      
      override public function dispose() : void
      {
         if(Core.instance.events)
         {
            Core.instance.events.removeEventListener("COMPONENT_EVENT_ERROR",onCoreError);
         }
         if(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1)
         {
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.dispose();
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1 = null;
         }
         if(_incomingMessages)
         {
            _incomingMessages.dispose();
            _incomingMessages = null;
         }
         _localization = null;
         _communication = null;
         if(UnknownVarFromHabboCommunicationDemo_ErrorPopupCtrl_1)
         {
            UnknownVarFromHabboCommunicationDemo_ErrorPopupCtrl_1.dispose();
            UnknownVarFromHabboCommunicationDemo_ErrorPopupCtrl_1 = null;
         }
      }
      
      public function initGameSocket() : void
      {
         dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_INIT");
         if(UnknownVarFromHabboCommunicationDemo_String_2 != null)
         {
            _communication.mode = 0;
         }
         else
         {
            _communication.mode = 0;
         }
         _communication.initConnection("habbo");
      }
      
      private function prepareProperties() : void
      {
         _localization.loadDefaultEmbedLocalizations("en");
         _loginName = CommunicationUtils.readSOLString("login");
         UnknownVarFromHabboCommunicationDemo_String_4 = CommunicationUtils.restorePassword();
         var _loc2_:String = CommunicationUtils.readSOLString("environment");
         var _loc3_:String = CommunicationUtils.readSOLString("loginmethod","habbo");
         var _loc6_:Boolean = CommunicationUtils.readSOLBoolean("autologin");
         var _loc5_:Boolean = CommunicationUtils.forcedAutoLoginEnabled;
         CommunicationUtils.forcedAutoLoginEnabled = false;
         var _loc4_:Array = getProperty("live.environment.list").split("/");
         if(_loc4_.indexOf(_loc2_) == -1)
         {
            Logger.log("Missing environment, require hotel selection! " + _loc2_);
            _loc2_ = null;
            CommunicationUtils.writeSOLProperty("environment",null);
         }
         if(_loc2_ != null)
         {
            initEnvironment(_loc2_);
         }
         UnknownVarFromHabboCommunicationDemo_String_2 = getProperty("sso.token");
         UnknownVarFromHabboCommunicationDemo_String_3 = getProperty("flash.client.url");
         UnknownVarFromHabboCommunicationDemo_String_1 = getProperty("external.variables.txt");
         var _loc1_:Boolean = getBoolean("use.sso");
      }
      
      private function initWithStoredCredentials() : void
      {
         _communication.mode = 0;
         UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.showLoadingScreen();
         var _loc1_:String = CommunicationUtils.readSOLString("environment");
         initEnvironment(_loc1_);
      }
      
      private function initWithSSO(param1:String) : void
      {
         UnknownVarFromHabboCommunicationDemo_String_2 = param1;
         _communication.mode = 0;
         initGameSocket();
      }
      
      private function initWithLoginView() : void
      {
         var _loc1_:String = CommunicationUtils.readSOLString("environment");
         if(_loc1_ == null || _loc1_ == "")
         {
         }
         if(_windowManager != null && !isRoomViewerMode)
         {
            Core.crash("Login without an SSO ticket is not supported",29);
         }
         if(_loc1_ && _loc1_ == "")
         {
            UnknownVarFromHabboCommunicationDemo_ILoginProvider_1.init(_communication);
         }
      }
      
      private function onInitLogin(param1:Event) : void
      {
         var _loc2_:IHabboWebApiSession_3 = null;
         if(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.useWebApi)
         {
            _loc2_ = _communication.getHabboWebApiSession();
            _loc2_.login(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.name,UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.password);
         }
         else
         {
            initGameSocket();
         }
      }
      
      private function onAvatarSelected(param1:Event) : void
      {
         var _loc2_:IHabboWebApiSession_3 = null;
         if(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.useWebApi)
         {
            _loc2_ = _communication.getHabboWebApiSession();
            _loc2_.selectAvatar(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.selectedAccount.uniqueId);
         }
         else
         {
            sendTryLoginDevelopmentOnly(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.name,UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.password,UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.avatarId);
         }
      }
      
      private function onEnvironmentSelected(param1:Event) : void
      {
         initEnvironment(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.selectedEnvironment);
      }
      
      private function initEnvironment(param1:String) : void
      {
         setProperty("environment.id",param1);
         CommunicationUtils.writeSOLProperty("environment",param1);
         updateEnvironmentVariables(param1);
         _communication.updateHostParameters();
         _communication.resetHabboWebApiSession();
         _localization.loadDefaultEmbedLocalizations(param1);
         if(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1 != null)
         {
            if(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.useWebApi)
            {
               UnknownVarFromHabboCommunicationDemo_ILoginProvider_1.init(_communication);
            }
            else
            {
               UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.environmentReady();
            }
         }
      }
      
      private function onConfigurationLoaded(param1:Event) : void
      {
         Logger.log("[HabboCommunicationDemo] Configuration Loaded!");
      }
      
      private function onConfigurationError(param1:Event) : void
      {
         var _loc2_:DataEvent = param1 as DataEvent;
         Logger.log("[HabboCommunicationDemo] Configuration Error!");
         if(_loc2_ && _loc2_.data == "503")
         {
         }
      }
      
      private function onLocalizationsComplete(param1:Event) : void
      {
      }
      
      private function onLocalizationFailed(param1:Event) : void
      {
      }
      
      public function setSSOTicket(param1:String) : void
      {
         if(param1 && !UnknownVarFromHabboCommunicationDemo_String_2)
         {
            UnknownVarFromHabboCommunicationDemo_String_2 = param1;
            initGameSocket();
         }
      }
      
      public function sendTryLoginDevelopmentOnly(param1:String, param2:String, param3:int = 0) : void
      {
         var _loc5_:IConnection = _communication.connection;
         if(!_loc5_)
         {
            _communication.initConnection("habbo");
            _loc5_ = _communication.connection;
         }
         var _loc4_:TryLoginMessageComposer = new TryLoginMessageComposer(param1,param2,param3);
         _loc5_.send(_loc4_);
      }
      
      public function sendConnectionParameters(param1:IConnection) : void
      {
         var _loc2_:SSOTicketMessageComposer = null;
         param1.send(new VersionCheckMessageComposer(401,UnknownVarFromHabboCommunicationDemo_String_3,UnknownVarFromHabboCommunicationDemo_String_1));
         var _loc3_:String = CommunicationUtils.readSOLString("machineid");
         var _loc4_:String = CommunicationUtils.generateFingerprint();
         var _loc5_:Array = Capabilities.version.split(" ");
         param1.send(new UniqueIDMessageComposer(_loc3_,_loc4_,_loc5_.join("/")));
         if(UnknownVarFromHabboCommunicationDemo_String_2 && UnknownVarFromHabboCommunicationDemo_String_2.length > 0)
         {
            _loc2_ = new SSOTicketMessageComposer(UnknownVarFromHabboCommunicationDemo_String_2);
            param1.send(_loc2_);
         }
      }
      
      public function loginOk() : void
      {
         UnknownVarFromHabboCommunicationDemo_Boolean_1 = false;
         if(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1 != null)
         {
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.closeLoginWindow();
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.dispose();
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1 = null;
         }
         UnknownVarFromHabboCommunicationDemo_Boolean_2 = false;
      }
      
      public function alert(param1:String, param2:String) : void
      {
         var titleKey:String = param1;
         var messageKey:String = param2;
         _windowManager.alert(titleKey,messageKey,0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      public function dispatchLoginStepEvent(param1:String) : void
      {
         if(Component(context) == null || Component(context).events == null)
         {
            return;
         }
         Component(context).events.dispatchEvent(new Event(param1));
      }
      
      private function unloading(param1:Event) : void
      {
         _logoutInProgress = true;
      }
      
      public function onUserList(param1:Vector.<AvatarData>) : void
      {
         var _loc3_:String = null;
         var _loc2_:Timer = null;
         if(_autoLogin)
         {
            _loc3_ = CommunicationUtils.readSOLString("useruniqueid");
            if(userExists(param1,_loc3_))
            {
               _loc2_ = new Timer(500,1);
               _loc2_.addEventListener("timerComplete",onAutoSendLogin);
               _loc2_.start();
            }
            else
            {
               UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.populateCharacterList(param1);
            }
         }
         else
         {
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.populateCharacterList(param1);
         }
      }
      
      private function onAutoSendLogin(param1:TimerEvent) : void
      {
         var _loc2_:int = CommunicationUtils.readSOLInteger("userid");
         sendTryLoginDevelopmentOnly(_loginName,UnknownVarFromHabboCommunicationDemo_String_4,_loc2_);
      }
      
      private function userExists(param1:Vector.<AvatarData>, param2:String) : Boolean
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.uniqueId == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function disconnected(param1:int, param2:String) : void
      {
         if(param1 == -1)
         {
            param2 = "UNKNOWN_REASON";
         }
         if(param1 == -2)
         {
            param2 = "MAINTENANCE_BREAK";
         }
         if(param1 == -3)
         {
            param2 = "CONNECTION_CLOSED";
         }
         var _loc3_:String = null;
         UnknownVarFromHabboCommunicationDemo_Boolean_1 = true;
         if(!UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1)
         {
            if(param2 == null || param2.length < 6)
            {
               param2 = _localization.getLocalization(DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(param1));
            }
            _loc3_ = "connection.login.logged_out";
            _localization.registerParameter(_loc3_,"reason",param1.toString());
            _localization.registerParameter(_loc3_,"reasonName",param2);
            alert(DisconnectReasonEvent.resolveDisconnectedReasonLocalizationKey(param1),"${connection.login.logged_out}");
            return;
         }
         onBufferedDisconnected(param1,param2);
      }
      
      private function onBufferedDisconnected(param1:int, param2:String) : void
      {
         var _loc5_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:* = false;
         if(param1 == 20)
         {
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.showInvalidLoginError(null);
         }
         else
         {
            _loc5_ = _loginName && _loginName.length && UnknownVarFromHabboCommunicationDemo_String_4 && UnknownVarFromHabboCommunicationDemo_String_4.length;
            _loc3_ = CommunicationUtils.readSOLString("loginmethod","habbo");
            _loc4_ = _loc3_ == "facebook";
            if(param1 != -3 || !_loc5_ && !_loc4_ || true)
            {
               UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.showDisconnected(param1,param2);
               if(_communication)
               {
                  _communication.disconnect();
               }
            }
            else
            {
               UnknownVarFromHabboCommunicationDemo_Boolean_2 = true;
               CommunicationUtils.forcedAutoLoginEnabled = true;
               initComponent();
            }
         }
      }
      
      public function handleErrorMessage(param1:int, param2:int) : void
      {
         switch(param1)
         {
            case 0:
               localization.registerParameter("connection.server.error.desc","errorCode",String(param1));
               alert("${connection.server.error.title}","${connection.server.error.desc}");
               break;
            case 1001:
            case 1002:
            case 1003:
            case 1004:
            case 1005:
            case 1006:
            case 1007:
            case 1008:
            case 1009:
            case 1010:
            case 1011:
            case 1012:
            case 1013:
            case 1014:
            case 1015:
            case 1016:
            case 1017:
            case 1018:
            case 1019:
               _communication.connection.close();
               break;
            case 4013:
               alert("${connection.room.maintenance.title}","${connection.room.maintenance.desc}");
               break;
            default:
               localization.registerParameter("connection.server.error.desc","errorCode",String(param1));
               alert("${connection.server.error.title}","${connection.server.error.desc}");
         }
      }
      
      private function onCoreError(param1:ErrorEvent) : void
      {
         switch(param1.category)
         {
            case 30:
            case 29:
            case 1:
            case 3:
            case 20:
            case 8:
            case 12:
            case 7:
               if(param1.critical && !isExcludeFromCrashing(param1.category))
               {
                  disconnected(-2,_localization.getLocalization("disconnected.reason.maintenance"));
               }
               break;
            default:
               handleNonMaintenanceCoreError(param1);
         }
      }
      
      private function handleNonMaintenanceCoreError(param1:ErrorEvent) : void
      {
         UnknownVarFromHabboCommunicationDemo_ErrorPopupCtrl_1.onError(param1,true);
      }
      
      private function isExcludeFromWarnings(param1:int) : Boolean
      {
         return isExcludedFromListProperty(param1,"error_handling.exclude_warnings");
      }
      
      private function isExcludeFromCrashing(param1:int) : Boolean
      {
         return isExcludedFromListProperty(param1,"error_handling.exclude_crashing");
      }
      
      private function isExcludedFromListProperty(param1:int, param2:String) : Boolean
      {
         var _loc3_:String = getProperty(param2);
         if(!_loc3_)
         {
            return false;
         }
         var _loc4_:Array = _loc3_.split(",");
         return _loc4_.indexOf(param1.toString()) != -1;
      }
      
      public function handleLoginFailedHotelClosedMessage(param1:int, param2:int) : void
      {
         if(UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1)
         {
            UnknownVarFromHabboCommunicationDemo_HabboLoginDemoScreen_1.showDisconnectedWithText(12);
         }
      }
      
      private function updateEnvironmentVariables(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         _loc4_ = [];
         _loc4_.push("connection.info.host");
         _loc4_.push("connection.info.port");
         _loc4_.push("url.prefix");
         _loc4_.push("site.url");
         _loc4_.push("flash.dynamic.download.url");
         _loc4_.push("flash.dynamic.download.name.template");
         _loc4_.push("flash.dynamic.avatar.download.configuration");
         _loc4_.push("flash.dynamic.avatar.download.url");
         _loc4_.push("pocket.api");
         _loc4_.push("web.api");
         _loc4_.push("facebook.application.id");
         _loc4_.push("web.terms_of_service.link");
         for each(var _loc3_ in _loc4_)
         {
            _loc2_ = getProperty(_loc3_);
            _loc5_ = _loc3_ + "." + param1;
            if(propertyExists(_loc5_))
            {
               setProperty(_loc3_,getProperty(_loc5_));
            }
            else
            {
               setProperty(_loc3_,_loc2_);
            }
         }
      }
      
      private function onHotelViewError(param1:Event) : void
      {
         disconnected(-2,_localization.getLocalization("disconnected.reason.maintenance"));
      }
      
      public function get isRoomViewerMode() : Boolean
      {
         return HabboComponentFlags.isRoomViewerMode(flags);
      }
   }
}

