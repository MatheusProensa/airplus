package com.sulake.habbo.communication.login
{
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.IHabboWebApiSession_1;
   import com.sulake.habbo.communication.IHabboWebApiSession_3;
   import com.sulake.habbo.utils.CommunicationUtils;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class WebApiLoginProvider extends EventDispatcher implements IHabboWebApiSession_1, ILoginProvider, IWebApiLoginProvider
   {
      public static const ERROR_TYPE_IO_ERROR:String = "ioError";
      
      public static const ERROR_CODE_MAINTENANCE:String = "maintenance";
      
      private static const AUTO_RECONNECT:Boolean = false;
      
      private static const POCKET_MODE_LOGIN_AND_REGISTER:int = 1;
      
      private static const UnknownConstFromWebApiLoginProvider_Int_1:int = 2;
      
      private var _communication:IHabboCommunicationManager;
      
      private var UnknownVarFromWebApiLoginProvider_String_1:String;
      
      private var UnknownVarFromWebApiLoginProvider_ILoginViewer_1:ILoginViewer;
      
      private var _pendingLoginError:Object;
      
      private var _autoLogin:Boolean = false;
      
      private var _localizationLoaded:Boolean;
      
      private var UnknownVarFromWebApiLoginProvider_Boolean_1:Boolean;
      
      private var UnknownVarFromWebApiLoginProvider_Boolean_2:Boolean;
      
      private var _pocketSessionMode:int = 1;
      
      private var _name:String;
      
      private var UnknownVarFromWebApiLoginProvider_String_2:String;
      
      private var UnknownVarFromWebApiLoginProvider_Int_1:int;
      
      private var UnknownVarFromWebApiLoginProvider_String_3:String;
      
      private var _ssoToken:String;
      
      private var UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1:IHabboWebApiSession_3;
      
      private var UnknownVarFromWebApiLoginProvider_UnknownIHabboCommunicationLogin1_1:UnknownIHabboCommunicationLogin1;
      
      public function WebApiLoginProvider(param1:ILoginViewer)
      {
         super();
         UnknownVarFromWebApiLoginProvider_ILoginViewer_1 = param1;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function init(param1:IHabboCommunicationManager) : void
      {
         _communication = param1;
         var _loc2_:String = getProperty("web.api");
         Logger.log("[WebApiLoginProvider] Init with: " + _loc2_);
         if(_loc2_ != null)
         {
            _communication.createHabboWebApiSession(this,_loc2_);
         }
         UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1 = createHabboWebApiSession();
         initHabboWebApiSession();
      }
      
      public function loginWithCredentials(param1:String, param2:String, param3:int = 0) : void
      {
         _name = param1;
         UnknownVarFromWebApiLoginProvider_String_2 = param2;
         UnknownVarFromWebApiLoginProvider_Int_1 = param3;
         if(UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1)
         {
            UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.login(param1,param2);
         }
         else
         {
            Logger.log("[WebApiLoginProvider] Login not available");
         }
      }
      
      public function loginWithCredentialsWeb(param1:String) : void
      {
         UnknownVarFromWebApiLoginProvider_String_3 = param1;
         if(UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1)
         {
            UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.selectAvatar(param1);
         }
         else
         {
            Logger.log("[WebApiLoginProvider] Login not available");
         }
      }
      
      private function createHabboWebApiSession() : IHabboWebApiSession_3
      {
         var _loc2_:IHabboWebApiSession_3 = _communication.getHabboWebApiSession();
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
         var _loc1_:String = getProperty("web.api");
         if(_loc1_ == "")
         {
            _loc1_ = getProperty("url.prefix");
            _loc1_ = _loc1_.replace("http:","https:");
         }
         return _communication.createHabboWebApiSession(this,_loc1_);
      }
      
      private function initHabboWebApiSession() : void
      {
         if(UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1)
         {
            UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.hello();
            return;
         }
         throw new Error("Tried to init null IHabboWebApiSession");
      }
      
      public function habboWebApiError(param1:String, param2:int, param3:String, param4:Object, param5:Boolean = false) : void
      {
         var _loc8_:Boolean = false;
         Logger.log("[WebApiLoginProvider] Api Error: id: " + param1 + " type: " + param3 + " captcha: " + param5);
         var _loc7_:String = param4 && param4.error ? param4.error : "";
         if(_loc7_ == "maintenance")
         {
         }
         var _loc9_:Boolean = false;
         if(param3 == "ioError")
         {
            _loc9_ = true;
         }
         var _loc6_:IHabboWebApiSession_3 = _communication.getHabboWebApiSession();
         switch(param1)
         {
            case "/api/ssotoken":
               if(_autoLogin)
               {
                  _loc9_ = true;
                  _loc6_.login(_name,UnknownVarFromWebApiLoginProvider_String_2);
               }
            case "/api/public/info/hello":
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showLoginScreen();
               break;
            case "/api/public/registration/new":
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showRegistrationError(param4);
               break;
            case "/api/ssotoken":
               Logger.log("[WebApiLoginProvider] There was an error getting the SSO-token (is this an employee account?)...");
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showInvalidLoginError(param4);
               break;
            case "/api/user/avatars":
               Logger.log("[WebApiLoginProvider] There was an error getting the Avatars");
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showInvalidLoginError(param4);
               break;
            case "/api/newuser/name/check":
            case "/api/newuser/name/select":
               Logger.log("[WebApiLoginProvider] There was an error checking name");
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.nameCheckResponse(param4,param1 == "/api/newuser/name/check");
               break;
            case "/api/public/authentication/login":
            case "/api/public/authentication/facebook":
            case "/api/force/tos-accept":
               Logger.log("[WebApiLoginProvider] There was an error authorizing connection...");
               if(param4 != null && (param4.message != null || param4.error != null || param4.errors != null))
               {
                  if(param5)
                  {
                     _loc8_ = param4.captcha == true && param4.message == "invalid-captcha";
                     if(!_loc8_)
                     {
                        _pendingLoginError = param4;
                     }
                     showCaptchaView();
                  }
                  else
                  {
                     UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showInvalidLoginError(param4);
                  }
               }
               else if(param5)
               {
                  showCaptchaView();
               }
               else
               {
                  UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showInvalidLoginError(null);
               }
               break;
            case "/api/user/avatars/select":
               Logger.log("[WebApiLoginProvider] There was an error selecting avatar");
               if(_loc6_)
               {
                  UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showAccountError(param4);
                  UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showLoadingScreen();
                  _loc6_.avatars();
               }
               else
               {
                  UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showInvalidLoginError(param4);
               }
               break;
            case "/api/newuser/room/select":
               Logger.log("[WebApiLoginProvider] There was an error selecting home room.");
               break;
            case "/api/user/look/save":
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.saveLooksError(param4);
               break;
            default:
               Logger.log("[WebApiLoginProvider] Did not process Habbo API message: " + param1);
         }
         if(!_loc9_)
         {
            _autoLogin = false;
         }
      }
      
      public function onUserList(param1:Vector.<AvatarData>) : void
      {
         var _loc2_:String = null;
         if(_autoLogin)
         {
            _loc2_ = CommunicationUtils.readSOLString("useruniqueid");
            if(!userExists(param1,_loc2_))
            {
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.populateCharacterList(param1);
            }
         }
         else
         {
            UnknownVarFromWebApiLoginProvider_ILoginViewer_1.populateCharacterList(param1);
         }
      }
      
      public function habboWebApiResponse(param1:String, param2:Object) : void
      {
         var _loc5_:String = null;
         var _loc8_:Array = null;
         var _loc7_:* = undefined;
         var _loc4_:int = 0;
         Logger.log("[WebApiLoginProvider] Got Habbo Web Api Response: " + param1,param2);
         var _loc6_:IHabboWebApiSession_3 = _communication.getHabboWebApiSession();
         if(_loc6_ == null)
         {
            return;
         }
         if(param2 != null && param2.force != null && param2.force is Array)
         {
            _loc8_ = param2.force as Array;
            if(_loc8_.indexOf("TOS") > -1)
            {
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showTOS();
               return;
            }
            if(_loc8_.indexOf("EMAIL") > -1 || _loc8_.indexOf("PASSWORD") > -1)
            {
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showInvalidLoginError({"errors":["account_issue"]});
               return;
            }
         }
         switch(param1)
         {
            case "/api/public/info/hello":
               if(_pocketSessionMode == 1)
               {
               }
               if(_autoLogin)
               {
                  _loc6_.ssoToken();
               }
               else
               {
                  UnknownVarFromWebApiLoginProvider_ILoginViewer_1.environmentReady();
               }
               break;
            case "/api/user/avatars/select":
               if(_pocketSessionMode != 2)
               {
                  _loc6_.ssoToken();
               }
               break;
            case "/api/public/authentication/login":
            case "/api/public/authentication/facebook":
            case "/api/force/tos-accept":
               _loc5_ = param1 == "/api/public/authentication/login" ? "habbo" : "facebook";
               CommunicationUtils.writeSOLProperty("loginmethod",_loc5_);
               fetchAvatars();
               break;
            case "/api/user/avatars":
               if(_pocketSessionMode != 2)
               {
                  _loc7_ = new Vector.<AvatarData>(0);
                  for each(var _loc3_ in param2)
                  {
                     _loc7_.push(new AvatarData(_loc3_));
                  }
                  if(_loc7_.length == 1)
                  {
                     CommunicationUtils.writeSOLProperty("useruniqueid",_loc7_[0].uniqueId);
                     _loc6_.selectAvatar(_loc7_[0].uniqueId);
                  }
                  else if(!_autoLogin)
                  {
                     UnknownVarFromWebApiLoginProvider_ILoginViewer_1.populateCharacterList(_loc7_);
                  }
               }
               break;
            case "/api/ssotoken":
               _ssoToken = param2["ssoToken"];
               _pocketSessionMode = 2;
               dispatchEvent(new SsoTokenAvailableEvent("SSO_TOKEN_AVAILABLE",_ssoToken));
               break;
            case "/api/public/registration/new":
               if(param2 != null)
               {
                  _loc4_ = parseInt(param2.id);
                  CommunicationUtils.writeSOLProperty("userid",_loc4_.toString());
               }
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showSelectAvatar(param2);
               break;
            case "/api/public/lists/hotlooks":
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showPromoHabbos(param2 as XML);
               break;
            case "/api/newuser/name/select":
            case "/api/newuser/name/check":
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.nameCheckResponse(param2,param1 == "/api/newuser/name/check");
               break;
            case "/api/user/look/save":
               UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showSelectRoom();
               break;
            case "/api/newuser/room/select":
               CommunicationUtils.writeSOLProperty("loginmethod","habbo");
               fetchAvatars();
         }
      }
      
      public function habboWebApiRawResponse(param1:String, param2:Object) : void
      {
      }
      
      public function closeCaptcha() : void
      {
         removeCaptchaView();
      }
      
      private function showCaptchaView() : void
      {
         UnknownVarFromWebApiLoginProvider_UnknownIHabboCommunicationLogin1_1 = UnknownVarFromWebApiLoginProvider_ILoginViewer_1.createCaptchaView();
         if(UnknownVarFromWebApiLoginProvider_UnknownIHabboCommunicationLogin1_1 == null)
         {
            UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showCaptchaError();
         }
      }
      
      public function handleCaptchaError() : void
      {
         removeCaptchaView();
         UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showCaptchaError();
      }
      
      public function handleCaptchaResult(param1:String) : void
      {
         removeCaptchaView();
         UnknownVarFromWebApiLoginProvider_ILoginViewer_1.captchaReady();
         if(_pendingLoginError)
         {
            UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showInvalidLoginError(_pendingLoginError);
            _pendingLoginError = null;
         }
         if(param1 == null || UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1 == null)
         {
            UnknownVarFromWebApiLoginProvider_ILoginViewer_1.showCaptchaError();
            return;
         }
         var _loc2_:Boolean = UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.setCaptchaToken(param1);
      }
      
      private function removeCaptchaView() : void
      {
         if(UnknownVarFromWebApiLoginProvider_UnknownIHabboCommunicationLogin1_1 != null)
         {
            UnknownVarFromWebApiLoginProvider_UnknownIHabboCommunicationLogin1_1.dispose();
            UnknownVarFromWebApiLoginProvider_UnknownIHabboCommunicationLogin1_1 = null;
         }
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return UnknownVarFromWebApiLoginProvider_ILoginViewer_1.getProperty(param1,param2);
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
      
      private function fetchAvatars() : void
      {
         var _loc1_:String = null;
         if(UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1 == null)
         {
            return;
         }
         if(_autoLogin)
         {
            _loc1_ = CommunicationUtils.readSOLString("useruniqueid");
            if(_loc1_)
            {
               UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.selectAvatar(_loc1_);
            }
            else
            {
               UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.avatars();
            }
         }
         else if(_pocketSessionMode == 1)
         {
            UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.avatars();
         }
      }
      
      public function selectAvatar(param1:int) : void
      {
      }
      
      public function selectAvatarUniqueid(param1:String) : void
      {
         if(UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1 == null)
         {
            return;
         }
         UnknownVarFromWebApiLoginProvider_IHabboWebApiSession_3_1.selectAvatar(param1);
      }
   }
}

