package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.*;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.communication.login.AvatarData;
   import com.sulake.habbo.communication.login.ILoginViewer;
   import com.sulake.habbo.communication.login.UnknownIHabboCommunicationLogin1;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class HabboLoginDemoScreen extends EventDispatcherWrapper implements ILoginViewer
   {
      public static const INIT_LOGIN:String = "INIT_LOGIN";
      
      public static const AVATAR_SELECTED:String = "AVATAR_SELECTED";
      
      public static const ENVIRONMENT_SELECTED:String = "ENVIRONMENT_SELECTED";
      
      private var UnknownVarFromHabboLoginDemoScreen_IComponent_1_1:IComponent_1;
      
      private var UnknownVarFromHabboLoginDemoScreen_IHabboWindowManagerComponent_1:IHabboWindowManagerComponent;
      
      private var UnknownVarFromHabboLoginDemoScreen_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromHabboLoginDemoScreen_IModalDialog_1:IModalDialog;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabboLoginDemoScreen_Boolean_1:Boolean = false;
      
      public var name:String = "";
      
      public var password:String = "";
      
      private var _defaultPropertyValues:Dictionary;
      
      private var UnknownVarFromHabboLoginDemoScreen_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2:ITextFieldWindow;
      
      private var UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1:LoginEnvironmentsController;
      
      private var _avatarId:int;
      
      private var UnknownVarFromHabboLoginDemoScreen_Vector_1:Vector.<AvatarData>;
      
      private var _selectedAccount:AvatarData;
      
      public function HabboLoginDemoScreen(param1:IComponent_1, param2:IAssetLibraryCollection, param3:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromHabboLoginDemoScreen_IComponent_1_1 = param1;
         UnknownVarFromHabboLoginDemoScreen_IAssetLibraryCollection_1 = param2;
         UnknownVarFromHabboLoginDemoScreen_IHabboWindowManagerComponent_1 = param3;
         _defaultPropertyValues = new Dictionary();
         UnknownVarFromHabboLoginDemoScreen_IModalDialog_1 = getModalXmlWindow("login_window",UnknownVarFromHabboLoginDemoScreen_IAssetLibraryCollection_1,UnknownVarFromHabboLoginDemoScreen_IHabboWindowManagerComponent_1,"");
         _window = UnknownVarFromHabboLoginDemoScreen_IModalDialog_1.rootWindow as IWindowController_1;
         createWindow();
      }
      
      public static function getModalXmlWindow(param1:String, param2:IAssetLibraryCollection, param3:IHabboWindowManagerComponent, param4:String = "_xml") : IModalDialog
      {
         var _loc7_:ISoundAsset = null;
         var _loc5_:XmlAsset = null;
         var _loc6_:IModalDialog = null;
         try
         {
            _loc7_ = param2.getAssetByName(param1 + param4);
            _loc5_ = XmlAsset(_loc7_);
            _loc6_ = param3.buildModalDialogFromXML(XML(_loc5_.content));
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("Communication","Failed to build modal window " + param1 + "_xml, " + _loc7_ + "!");
            throw e;
         }
         return _loc6_;
      }
      
      public function get avatarId() : int
      {
         return _avatarId;
      }
      
      public function get selectedAccount() : AvatarData
      {
         return _selectedAccount;
      }
      
      public function get selectedEnvironment() : String
      {
         return UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.selectedEnvironment;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(UnknownVarFromHabboLoginDemoScreen_IModalDialog_1)
         {
            UnknownVarFromHabboLoginDemoScreen_IModalDialog_1.dispose();
            UnknownVarFromHabboLoginDemoScreen_IModalDialog_1 = null;
         }
         if(UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1)
         {
            UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.removeEventListener("ENVIRONMENT_SELECTED_EVENT",onEnvironmentSelected);
            UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.dispose();
            UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1 = null;
         }
         _defaultPropertyValues = null;
      }
      
      public function closeLoginWindow() : void
      {
         if(UnknownVarFromHabboLoginDemoScreen_IModalDialog_1)
         {
            UnknownVarFromHabboLoginDemoScreen_IModalDialog_1.dispose();
            UnknownVarFromHabboLoginDemoScreen_IModalDialog_1 = null;
         }
      }
      
      public function get useWebApi() : Boolean
      {
         var _loc1_:ISelectableWindow = _window.findChildByName("useTicket") as ISelectableWindow;
         if(_loc1_ != null)
         {
            return _loc1_.isSelected;
         }
         return false;
      }
      
      public function get useExistingSession() : Boolean
      {
         return false;
      }
      
      private function createWindow() : void
      {
         _window.center();
         _window.caption += " (air)";
         _window.findChildByName("useExistingSession").disable();
         _window.findChildByName("useExistingSession").blend = 0.5;
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1 = _window.findChildByName("login_btn") as UnknownICoreWindowComponents4;
         UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1 = _window.findChildByName("name_field") as ITextFieldWindow;
         UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2 = _window.findChildByName("pwd_field") as ITextFieldWindow;
         var _loc3_:String = CommunicationUtils.readSOLString("environment");
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.addEventListener("WME_CLICK",windowEventProcessor);
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.caption = _loc3_ == null ? "Select environment above" : "Initializing (" + _loc3_ + ")";
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.disable();
         if(UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1 != null)
         {
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.textBackground = true;
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.textBackgroundColor = 16777215;
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.text = CommunicationUtils.readSOLString("login");
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.focus();
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.setSelection(UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.text.length,UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.text.length);
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.addEventListener("WKE_KEY_UP",windowEventProcessor);
         }
         if(UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2 != null)
         {
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2.textBackground = true;
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2.textBackgroundColor = 16777215;
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2.text = CommunicationUtils.restorePassword();
            UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2.addEventListener("WKE_KEY_UP",windowEventProcessor);
         }
         var _loc2_:ISelectableWindow = _window.findChildByName("useTicket") as ISelectableWindow;
         _loc2_.addEventListener("WME_CLICK",windowEventProcessorCheckbox);
         if(_loc2_)
         {
            _loc2_.select();
         }
         var _loc1_:ISelectableWindow = _window.findChildByName("useExistingSession") as ISelectableWindow;
         if(_loc1_)
         {
            _loc1_.unselect();
         }
         if(UnknownVarFromHabboLoginDemoScreen_IComponent_1_1.getBoolean("try.existing.session"))
         {
            UnknownVarFromHabboLoginDemoScreen_Boolean_1 = true;
            _window.visible = false;
            windowEventProcessor(WindowEvent.allocate("WE_OK",_window,null,false));
         }
         var _loc4_:IItemListWindow = _window.findChildByName("list") as IItemListWindow;
         UnknownVarFromHabboLoginDemoScreen_IWindowModel_1 = _loc4_.removeListItemAt(0);
         UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1 = new LoginEnvironmentsController(_window.findChildByName("environment_list") as IDropBaseController_2,UnknownVarFromHabboLoginDemoScreen_IComponent_1_1,UnknownVarFromHabboLoginDemoScreen_IHabboWindowManagerComponent_1,UnknownVarFromHabboLoginDemoScreen_IAssetLibraryCollection_1);
         UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.addEventListener("ENVIRONMENT_SELECTED_EVENT",onEnvironmentSelected);
      }
      
      private function onEnvironmentSelected(param1:Event = null) : void
      {
         dispatchEvent(new Event("ENVIRONMENT_SELECTED"));
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.disable();
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.caption = "Initializing (" + UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.selectedEnvironment + ")";
         showInfoMessage("Initializing Web Api connection to (" + UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.getEnvironmentName(UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.selectedEnvironment) + ")");
      }
      
      public function populateUserList(param1:Map) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc4_:int = 0;
         var _loc5_:IItemListWindow = _window.findChildByName("list") as IItemListWindow;
         if(!_loc5_)
         {
            return;
         }
         _window.findChildByName("users_info").visible = false;
         var _loc2_:IWindowModel = UnknownVarFromHabboLoginDemoScreen_IWindowModel_1.clone();
         _loc2_.procedure = listEventHandler;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = _loc2_.clone();
            _loc3_.id = param1.getKey(_loc4_);
            _loc3_.caption = param1.getWithIndex(_loc4_);
            _loc5_.addListItem(_loc3_);
            _loc4_++;
         }
         _loc2_.dispose();
      }
      
      public function displayResults(param1:String) : void
      {
         var _loc2_:ITextWindow = _window.findChildByName("text002") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function handleKeyUp(param1:WindowKeyboardEvent) : void
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc5_:ITextFieldWindow = null;
         var _loc2_:ITextFieldWindow = null;
         var _loc7_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc7_.ctrlKey)
         {
            _loc3_ = _loc7_.keyCode - 49;
            if(_loc3_ >= 0 && _loc3_ < 10)
            {
               _loc6_ = UnknownVarFromHabboLoginDemoScreen_IComponent_1_1.getProperty("login.user." + _loc3_ + ".name");
               _loc4_ = UnknownVarFromHabboLoginDemoScreen_IComponent_1_1.getProperty("login.user." + _loc3_ + ".pass");
               _loc5_ = _window.findChildByName("name_field") as ITextFieldWindow;
               _loc2_ = _window.findChildByName("pwd_field") as ITextFieldWindow;
               if(_loc6_ != "")
               {
                  _loc5_.caption = _loc6_;
               }
               if(_loc4_ != "")
               {
                  _loc2_.caption = _loc4_;
               }
               _loc5_.setSelection(_loc5_.text.length,_loc5_.text.length);
               if(_loc7_.cancelable)
               {
                  _loc7_.preventDefault();
                  _loc7_.preventWindowOperation();
               }
               param1.stopImmediatePropagation();
               param1.stopPropagation();
            }
         }
      }
      
      private function windowEventProcessor(param1:WindowEvent = null, param2:IWindowModel = null) : void
      {
         if(param1.type == "WKE_KEY_UP")
         {
            handleKeyUp(param1 as WindowKeyboardEvent);
            if((param1 as WindowKeyboardEvent).keyCode != 13)
            {
               return;
            }
         }
         if(UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1 != null)
         {
            name = UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_1.text;
         }
         if(UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2 != null)
         {
            password = UnknownVarFromHabboLoginDemoScreen_ITextFieldWindow_2.text;
         }
         CommunicationUtils.writeSOLProperty("login",name);
         dispatchEvent(new Event("INIT_LOGIN"));
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.disable();
      }
      
      private function windowEventProcessorCheckbox(param1:WindowEvent = null, param2:IWindowModel = null) : void
      {
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.enable();
      }
      
      private function listEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(useWebApi)
         {
            _selectedAccount = UnknownVarFromHabboLoginDemoScreen_Vector_1[param2.id];
         }
         else
         {
            _avatarId = UnknownVarFromHabboLoginDemoScreen_Vector_1[param2.id].id;
         }
         dispatchEvent(new Event("AVATAR_SELECTED"));
      }
      
      public function showError(param1:int, param2:int, param3:String) : void
      {
         _window.findChildByName("users_info").caption = "Received error: " + param1 + " regarding message: " + param2;
      }
      
      private function showErrorMessage(param1:String) : void
      {
         _window.findChildByName("users_info").caption = "Error:\n\n" + param1;
      }
      
      private function showInfoMessage(param1:String) : void
      {
         _window.findChildByName("users_info").caption = param1;
      }
      
      public function showLoginScreen() : void
      {
      }
      
      public function showRegistrationError(param1:Object) : void
      {
         showErrorMessage("Registration error");
      }
      
      public function showInvalidLoginError(param1:Object) : void
      {
         showErrorMessage("Invalid login");
      }
      
      public function nameCheckResponse(param1:Object, param2:Boolean) : void
      {
      }
      
      public function showCaptchaError() : void
      {
         showErrorMessage("Captcha required, please add your IP to Housekeeping property to avoid this.");
      }
      
      public function showAccountError(param1:Object) : void
      {
         showErrorMessage("Error with account during login");
      }
      
      public function showLoadingScreen() : void
      {
         dispose();
      }
      
      public function saveLooksError(param1:Object) : void
      {
         showErrorMessage("Save looks error ");
      }
      
      public function showTOS() : void
      {
         showErrorMessage("Web-api wants to show Terms of Service");
      }
      
      public function environmentReady() : void
      {
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.enable();
         UnknownVarFromHabboLoginDemoScreen_UnknownICoreWindowComponents4_1.caption = "Login (" + UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.selectedEnvironment + ")";
         showInfoMessage("Web Api connection is established for (" + UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.getEnvironmentName(UnknownVarFromHabboLoginDemoScreen_LoginEnvironmentsController_1.selectedEnvironment) + "). Ready to connect.");
      }
      
      public function populateCharacterList(param1:Vector.<AvatarData>) : void
      {
         var _loc3_:* = null;
         UnknownVarFromHabboLoginDemoScreen_Vector_1 = param1;
         var _loc6_:String = CommunicationUtils.readSOLString("useruniqueid");
         var _loc2_:Map = new Map();
         var _loc4_:int = 0;
         for each(var _loc5_ in param1)
         {
            if(_loc5_.uniqueId == _loc6_)
            {
               _loc3_ = _loc5_;
            }
            _loc2_[_loc4_] = _loc5_.name;
            _loc4_++;
         }
         populateUserList(_loc2_);
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
      
      public function showDisconnectedWithText(param1:int) : void
      {
         showErrorMessage("Hotel is closed");
      }
      
      public function showDisconnected(param1:int, param2:String) : void
      {
         showErrorMessage("Disconnected reason: " + param2 + " (" + param1 + ")");
      }
      
      public function getProperty(param1:String, param2:Dictionary = null) : String
      {
         return !!UnknownVarFromHabboLoginDemoScreen_IComponent_1_1 ? UnknownVarFromHabboLoginDemoScreen_IComponent_1_1.getProperty(param1,param2) : "";
      }
      
      public function createCaptchaView() : UnknownIHabboCommunicationLogin1
      {
         return undefined;
      }
      
      public function captchaReady() : void
      {
      }
   }
}

