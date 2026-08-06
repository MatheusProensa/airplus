package login
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.communication.HabboCommunicationManager;
   import com.sulake.habbo.communication.login.AvatarData;
   import com.sulake.habbo.communication.login.ILoginProvider;
   import com.sulake.habbo.communication.login.ILoginViewer;
   import com.sulake.habbo.communication.login.SsoTokenAvailableEvent;
   import com.sulake.habbo.communication.login.UnknownIHabboCommunicationLogin1;
   import com.sulake.habbo.communication.login.WebApiLoginProvider;
   import com.sulake.habbo.configuration.HabboConfigurationManager;
   import com.sulake.habbo.localization.HabboLocalizationManager;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.utils.animation.TweenUtils;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.LocalizedSprite;
   import onBoardingHcUi.LocalizedTextField;
   
   public class LoginFlow extends Sprite implements ILoginContext, IComponentInterfaceQueue, ILoginViewer
   {
      public static const LOGIN_FLOW_FINISHED_EVENT:String = "LOGIN_FLOW_FINISHED_EVENT";
      
      private static const ERROR_TYPE_IO_ERROR:String = "ioError";
      
      private static const LOGO_AREA_HEIGHT:int = 50;
      
      private static const MAIN_AREA_MARGIN:int = 5;
      
      public static const SCREEN_ENVIRONMENT:int = 1;
      
      public static const SCREEN_LOGIN:int = 2;
      
      public static const SCREEN_AVATARS:int = 3;
      
      public static const SCREEN_SSO_TOKEN:int = 4;
      
      public static var ubuntu_regular:Class = §Ubuntu-R_1_ttf§;
      
      public static var ubuntu_bold:Class = §Ubuntu-B_2_ttf§;
      
      public static var ubuntu_italic:Class = §Ubuntu-I_1_ttf§;
      
      public static var ubuntu_bold_italic:Class = §Ubuntu-BI_1_ttf§;
      
      private static const habbo_logo_png:Class = logo_new_2_png;
      
      private var _background:Background;
      
      private var UnknownVarFromLoginFlow_Sprite_1:Sprite;
      
      private var UnknownVarFromLoginFlow_EnvironmentView_1:EnvironmentView;
      
      private var UnknownVarFromLoginFlow_LoginView_1:LoginView;
      
      private var UnknownVarFromLoginFlow_SsoTokenView_1:SsoTokenView;
      
      private var UnknownVarFromLoginFlow_AvatarView_1:AvatarView;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromLoginFlow_IComponent_2_1:IComponent_2;
      
      private var UnknownVarFromLoginFlow_Sprite_2:Sprite;
      
      private var _mainSprite:Sprite;
      
      private var UnknownVarFromLoginFlow_Sprite_3:Sprite;
      
      private var UnknownVarFromLoginFlow_HabboConfigurationManager_1:HabboConfigurationManager;
      
      private var _communication:HabboCommunicationManager;
      
      private var _localization:HabboLocalizationManager;
      
      private var UnknownVarFromLoginFlow_ILoginProvider_1:ILoginProvider;
      
      private var _ssoToken:String;
      
      private var UnknownVarFromLoginFlow_ColouredButton_1:ColouredButton;
      
      private var UnknownVarFromLoginFlow_Loader_1:Loader;
      
      private var UnknownVarFromLoginFlow_Loader_2:Loader;
      
      private var _lastFrameTime:int;
      
      public function LoginFlow(param1:Dictionary)
      {
         super();
         createFakeContext(param1);
      }
      
      public function get ssoToken() : String
      {
         return _ssoToken;
      }
      
      public function dispose() : void
      {
         removeEventListener("enterFrame",onEnterFrame);
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromLoginFlow_IComponent_2_1)
         {
            UnknownVarFromLoginFlow_IComponent_2_1.dispose();
            UnknownVarFromLoginFlow_IComponent_2_1 = null;
         }
         if(_background)
         {
            removeChild(_background);
            _background.dispose();
            _background = null;
         }
         if(_mainSprite != null)
         {
            removeChild(_mainSprite);
            _mainSprite = null;
         }
         hideViews();
         UnknownVarFromLoginFlow_EnvironmentView_1.dispose();
         UnknownVarFromLoginFlow_LoginView_1.dispose();
         UnknownVarFromLoginFlow_AvatarView_1.dispose();
         UnknownVarFromLoginFlow_SsoTokenView_1.dispose();
         UnknownVarFromLoginFlow_ILoginProvider_1 = null;
         stage.removeChild(this);
         _disposed = true;
         LocalizedSprite.localizationManager = null;
         LocalizedTextField.localizationManager = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function createConfiguration(param1:IComponent_2) : HabboConfigurationManager
      {
         var _loc5_:XML = <manifest><library /></manifest>;
         var _loc2_:ByteArray = new HabboConfigurationCom.manifest() as ByteArray;
         var _loc3_:XML = new XML(_loc2_.readUTFBytes(_loc2_.length));
         _loc5_.library.appendChild(_loc3_.component.assets);
         var _loc4_:IAssetLibraryCollection = new AssetLibrary("_assetsConfiguration@");
         _loc4_.loadFromResource(_loc5_,HabboConfigurationCom);
         return new HabboConfigurationManager(param1,0,_loc4_);
      }
      
      private function createLocalization(param1:IComponent_2) : HabboLocalizationManager
      {
         var _loc5_:XML = <manifest><library /></manifest>;
         var _loc2_:ByteArray = new HabboLocalizationCom.manifest() as ByteArray;
         var _loc3_:XML = new XML(_loc2_.readUTFBytes(_loc2_.length));
         _loc5_.library.appendChild(_loc3_.component.assets);
         var _loc4_:IAssetLibraryCollection = new AssetLibrary("_assetsLocalization@");
         _loc4_.loadFromResource(_loc5_,HabboLocalizationCom);
         return new HabboLocalizationManager(param1,0,_loc4_);
      }
      
      private function createCommunication(param1:IComponent_2) : HabboCommunicationManager
      {
         var _loc3_:ByteArray = new HabboCommunicationCom.manifest() as ByteArray;
         var _loc4_:XML = new XML(_loc3_.readUTFBytes(_loc3_.length));
         var _loc2_:XML = <manifest><library /></manifest>;
         _loc2_.library.appendChild(_loc4_.component.assets);
         var _loc5_:IAssetLibraryCollection = new AssetLibrary("_assetsTemp@",_loc2_);
         _loc5_.loadFromResource(_loc2_,HabboCommunicationCom);
         return new HabboCommunicationManager(param1,0,_loc5_);
      }
      
      private function createFakeContext(param1:Dictionary) : void
      {
         UnknownVarFromLoginFlow_IComponent_2_1 = new FakeContext(param1);
         var _loc3_:XML = <manifest><library /></manifest>;
         var _loc2_:IAssetLibraryCollection = new AssetLibrary("_assetsTemp@",_loc3_);
         (UnknownVarFromLoginFlow_IComponent_2_1.assets as AssetLibraryCollection).addAssetLibrary(_loc2_);
         UnknownVarFromLoginFlow_HabboConfigurationManager_1 = createConfiguration(UnknownVarFromLoginFlow_IComponent_2_1);
         _localization = createLocalization(UnknownVarFromLoginFlow_IComponent_2_1);
         _communication = createCommunication(UnknownVarFromLoginFlow_IComponent_2_1);
         LocalizedSprite.localizationManager = _localization;
         LocalizedTextField.localizationManager = _localization;
         if(new Array("en","pt","fi","fr","de","nl","es","it","tr").indexOf(Capabilities.language) == -1)
         {
            this._localization.loadDefaultEmbedLocalizations("en");
         }
         else
         {
            this._localization.loadDefaultEmbedLocalizations(Capabilities.language);
         }
         UnknownVarFromLoginFlow_ILoginProvider_1 = new WebApiLoginProvider(this);
         UnknownVarFromLoginFlow_ILoginProvider_1.addEventListener("SSO_TOKEN_AVAILABLE",onSsoTokenAvailable);
      }
      
      private function onSsoTokenAvailable(param1:SsoTokenAvailableEvent) : void
      {
         _ssoToken = param1.ssoToken;
         dispatchEvent(new Event("LOGIN_FLOW_FINISHED_EVENT"));
      }
      
      public function initLoginWithSsoToken(param1:String, param2:String) : void
      {
         updateEnvironment(param1,false);
         _ssoToken = param2;
         dispatchEvent(new Event("LOGIN_FLOW_FINISHED_EVENT"));
      }
      
      public function init() : void
      {
         stage.addEventListener("resize",onStageResize);
         _background = new Background();
         addChild(_background);
         UnknownVarFromLoginFlow_Loader_1 = new Loader();
         UnknownVarFromLoginFlow_Loader_1.visible = false;
         UnknownVarFromLoginFlow_Loader_1.alpha = 0;
         addChild(UnknownVarFromLoginFlow_Loader_1);
         UnknownVarFromLoginFlow_Loader_2 = new Loader();
         UnknownVarFromLoginFlow_Loader_2.visible = false;
         UnknownVarFromLoginFlow_Loader_2.alpha = 0;
         addChild(UnknownVarFromLoginFlow_Loader_2);
         UnknownVarFromLoginFlow_Sprite_3 = new Sprite();
         addChild(UnknownVarFromLoginFlow_Sprite_3);
         var _loc1_:Bitmap = new habbo_logo_png();
         _loc1_.x = 40;
         _loc1_.y = 40;
         UnknownVarFromLoginFlow_Sprite_3.addChild(_loc1_);
         _mainSprite = new Sprite();
         addChild(_mainSprite);
         _mainSprite.y = 50;
         _mainSprite.x = 5;
         UnknownVarFromLoginFlow_Sprite_1 = new Sprite();
         UnknownVarFromLoginFlow_Sprite_1.x = 0;
         UnknownVarFromLoginFlow_Sprite_1.y = 50;
         UnknownVarFromLoginFlow_Sprite_1.visible = true;
         _mainSprite.addChild(UnknownVarFromLoginFlow_Sprite_1);
         UnknownVarFromLoginFlow_EnvironmentView_1 = new EnvironmentView(this);
         UnknownVarFromLoginFlow_LoginView_1 = new LoginView(this);
         UnknownVarFromLoginFlow_AvatarView_1 = new AvatarView(this);
         UnknownVarFromLoginFlow_SsoTokenView_1 = new SsoTokenView(this);
         UnknownVarFromLoginFlow_ColouredButton_1 = new ColouredButton("red","X",new Rectangle(0,0,0,40),true,onClose,14211288);
         UnknownVarFromLoginFlow_EnvironmentView_1.init();
         loadImages();
         showScreen(4);
         layoutMainElements();
         addEventListener("addedToStage",onAddedToStage);
         addEventListener("enterFrame",onEnterFrame);
      }
      
      private function loadImages() : void
      {
      }
      
      private function onImageComplete(param1:ImageLoaderEvent) : void
      {
         Logger.log("Image complete: " + param1.url);
         param1.loader.visible = true;
         TweenUtils.alphaTweenVisible(param1.loader,0,1.2);
         layoutMainElements();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         _lastFrameTime = getTimer();
         layoutMainElements();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         TweenUtils.UnknownVarFromTweenUtils_Juggler_1.advanceTime((getTimer() - _lastFrameTime) / 1000);
         _lastFrameTime = getTimer();
      }
      
      private function onStageResize(param1:Event) : void
      {
         if(disposed)
         {
            return;
         }
         layoutMainElements();
      }
      
      private function layoutMainElements() : void
      {
         var _loc2_:int = 0;
         if(disposed)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         if(_background != null)
         {
            _background.resize();
         }
         var _loc1_:int = _mainSprite.width + 20;
         if(stage.stageWidth > _loc1_)
         {
            _loc2_ = (stage.stageWidth - _loc1_) / 2;
            if(_loc2_ < 5)
            {
               _loc2_ = 5;
            }
            _mainSprite.x = _loc2_;
         }
         else
         {
            _mainSprite.x = 5;
         }
         _mainSprite.y = 50;
         UnknownVarFromLoginFlow_ColouredButton_1.y = 30;
         UnknownVarFromLoginFlow_ColouredButton_1.x = stage.stageWidth - UnknownVarFromLoginFlow_ColouredButton_1.width - 30;
         UnknownVarFromLoginFlow_Loader_2.x = Math.max(400,stage.stageWidth - UnknownVarFromLoginFlow_Loader_2.width + 50);
         UnknownVarFromLoginFlow_Loader_2.y = stage.stageHeight - UnknownVarFromLoginFlow_Loader_2.height + 50;
         UnknownVarFromLoginFlow_Loader_1.x = -50;
         UnknownVarFromLoginFlow_Loader_1.y = stage.stageHeight - UnknownVarFromLoginFlow_Loader_1.height + 50;
      }
      
      public function showErrorMessage(param1:String) : void
      {
         var _loc4_:TextField = null;
         var _loc3_:Bitmap = null;
         if(UnknownVarFromLoginFlow_Sprite_2 == null)
         {
            _loc4_ = LoaderUI.createTextField(param1,12,16777215,true);
            LoaderUI.addEtching(_loc4_,true);
            _loc3_ = LoaderUI.createBalloon(_loc4_.width + 30,_loc4_.height + 17,-1,true,11411485,"down");
            UnknownVarFromLoginFlow_Sprite_2 = new Sprite();
            UnknownVarFromLoginFlow_Sprite_2.addChild(_loc3_);
            UnknownVarFromLoginFlow_Sprite_2.addChild(_loc4_);
            _loc4_.x = 15;
            _loc4_.y = 14;
            _mainSprite.addChild(UnknownVarFromLoginFlow_Sprite_2);
            UnknownVarFromLoginFlow_Sprite_2.x = 300;
            UnknownVarFromLoginFlow_Sprite_2.y = 300;
            UnknownVarFromLoginFlow_Sprite_2.filters = [new GlowFilter(0,0.24,6,6)];
         }
         var _loc2_:Timer = new Timer(3000,1);
         _loc2_.addEventListener("timerComplete",onHideError);
         _loc2_.start();
         UnknownVarFromLoginFlow_Sprite_2.visible = true;
      }
      
      private function onHideError(param1:TimerEvent) : void
      {
         if(UnknownVarFromLoginFlow_Sprite_2)
         {
            UnknownVarFromLoginFlow_Sprite_2.visible = false;
         }
      }
      
      public function editorFinished() : void
      {
         dispatchEvent(new Event("LOGIN_FLOW_FINISHED_EVENT"));
      }
      
      public function showScreen(param1:int) : void
      {
         hideViews();
         var _loc2_:String = "";
         var _loc3_:String = "";
         switch(param1 - 1)
         {
            case 0:
               UnknownVarFromLoginFlow_Sprite_1.addChild(UnknownVarFromLoginFlow_EnvironmentView_1);
               UnknownVarFromLoginFlow_EnvironmentView_1.init();
               break;
            case 1:
               UnknownVarFromLoginFlow_Sprite_1.addChild(UnknownVarFromLoginFlow_LoginView_1);
               UnknownVarFromLoginFlow_LoginView_1.init();
               UnknownVarFromLoginFlow_ILoginProvider_1.init(_communication);
               break;
            case 2:
               UnknownVarFromLoginFlow_Sprite_1.addChild(UnknownVarFromLoginFlow_AvatarView_1);
               UnknownVarFromLoginFlow_AvatarView_1.init();
               UnknownVarFromLoginFlow_AvatarView_1.baseUrl = getProperty("web.api");
               layoutMainElements();
               break;
            case 3:
               UnknownVarFromLoginFlow_Sprite_1.addChild(UnknownVarFromLoginFlow_SsoTokenView_1);
               UnknownVarFromLoginFlow_SsoTokenView_1.init();
         }
         layoutMainElements();
      }
      
      public function get debugText() : TextField
      {
         return null;
      }
      
      private function hideViews() : void
      {
         while(UnknownVarFromLoginFlow_Sprite_1.numChildren > 0)
         {
            UnknownVarFromLoginFlow_Sprite_1.removeChildAt(0);
         }
      }
      
      public function initLogin(param1:String, param2:String) : void
      {
         UnknownVarFromLoginFlow_ILoginProvider_1.loginWithCredentials(param1,param2);
      }
      
      public function loginWithAvatar(param1:AvatarData) : void
      {
         UnknownVarFromLoginFlow_ILoginProvider_1.loginWithCredentialsWeb(param1.uniqueId);
      }
      
      public function showLoginScreen() : void
      {
      }
      
      public function showRegistrationError(param1:Object) : void
      {
         showError(param1);
      }
      
      public function showInvalidLoginError(param1:Object) : void
      {
         showError(param1);
      }
      
      public function nameCheckResponse(param1:Object, param2:Boolean) : void
      {
      }
      
      public function showAccountError(param1:Object) : void
      {
         showError(param1);
      }
      
      public function showLoadingScreen() : void
      {
      }
      
      public function saveLooksError(param1:Object) : void
      {
         showError(param1);
      }
      
      public function showTOS() : void
      {
         showErrorMessage("Need to show TOS");
      }
      
      public function environmentReady() : void
      {
         UnknownVarFromLoginFlow_LoginView_1.ready();
      }
      
      public function populateCharacterList(param1:Vector.<AvatarData>) : void
      {
         showScreen(3);
         UnknownVarFromLoginFlow_AvatarView_1.populateAvatars(param1);
      }
      
      public function showSelectAvatar(param1:Object) : void
      {
      }
      
      public function showPromoHabbos(param1:XML) : void
      {
      }
      
      public function showSelectRoom() : void
      {
      }
      
      public function showCaptchaError() : void
      {
         showScreen(2);
         showErrorMessage("Error with captcha");
      }
      
      private function showError(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = param1.errors;
         var _loc2_:String = _loc4_ && _loc4_.length > 0 ? _loc4_[0] : "";
         if(_loc2_ == "" && param1 != null)
         {
            if(param1.error != null)
            {
               _loc2_ = param1.error;
            }
            else if(param1.message != null)
            {
               _loc2_ = param1.message;
            }
         }
         switch(_loc2_)
         {
            case "invalid-captcha":
               showCaptchaError();
               break;
            case "login.user_banned":
               _loc3_ = "connection.login.error.banned.desc";
               break;
            case "login.blocked":
               _loc3_ = "connection.login.error.blocked.desc";
               break;
            case "unauthorized-staff-login":
               _loc3_ = "connection.login.error.unauthorized.staff";
               break;
            case "pocket.auth.login_failed":
               _loc3_ = "connection.login.error.-3.desc";
               break;
            case "pocket.auth.no_avatars":
               _loc3_ = "connection.login.missing_avatars";
               break;
            case "pocket.auth.valid_email_required":
               _loc3_ = "connection.login.missing_credentials";
               break;
            case "pocket.auth.password_required":
               _loc3_ = "connection.login.missing_credentials";
               break;
            case "pocket.auth.facebook_disabled":
               _loc3_ = "connection.login.error.facebook_disabled.desc";
               break;
            case "pocket.auth.facebook_not_connected":
               break;
            case "pocket.auth.access_token_required":
               _loc3_ = "connection.login.error.facebook_accesstoken.desc";
               break;
            case "ioError":
               _loc3_ = "connection.login.error.-400.desc";
               break;
            case "account_issue":
               _loc3_ = "generic.error";
               break;
            default:
               _loc3_ = "generic.error";
         }
         if(_loc3_ && _loc3_.length > 0)
         {
            showErrorMessage(_localization.getLocalization(_loc3_));
         }
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         var _loc3_:String = !!UnknownVarFromLoginFlow_HabboConfigurationManager_1 ? UnknownVarFromLoginFlow_HabboConfigurationManager_1.getProperty(param1,param2) : "";
         if(!_loc3_ || _loc3_.length == 0)
         {
            Logger.log("[LoginFlow] Add property: " + param1);
         }
         return _loc3_;
      }
      
      public function createCaptchaView() : UnknownIHabboCommunicationLogin1
      {
         addChild(UnknownVarFromLoginFlow_ColouredButton_1);
         var _loc1_:WebCaptchaView = new WebCaptchaView(UnknownVarFromLoginFlow_ILoginProvider_1 as WebApiLoginProvider);
         addChild(_loc1_);
         layoutMainElements();
         return _loc1_;
      }
      
      public function captchaReady() : void
      {
         removeChild(UnknownVarFromLoginFlow_ColouredButton_1);
         showScreen(2);
      }
      
      private function onClose(param1:Button) : void
      {
         removeChild(UnknownVarFromLoginFlow_ColouredButton_1);
         UnknownVarFromLoginFlow_ILoginProvider_1.closeCaptcha();
         showScreen(2);
      }
      
      public function updateEnvironment(param1:String, param2:Boolean) : void
      {
         if(param2)
         {
            _localization.loadDefaultEmbedLocalizations(param1);
            return;
         }
         CommunicationUtils.writeSOLProperty("environment",param1);
         UnknownVarFromLoginFlow_HabboConfigurationManager_1.updateEnvironmentId(param1);
         if(UnknownVarFromLoginFlow_EnvironmentView_1)
         {
            UnknownVarFromLoginFlow_EnvironmentView_1.updateEnvironment();
         }
         _localization.loadDefaultEmbedLocalizations(UnknownVarFromLoginFlow_HabboConfigurationManager_1.getProperty("environment.id"));
         Logger.log("[LoginFlow] updated environment to: " + param1);
         _communication.updateHostParameters();
         _localization.requestLocalizationInit();
      }
   }
}

