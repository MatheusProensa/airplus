package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ErrorEvent;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.desktop.Clipboard;
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   
   public class ErrorPopupCtrl extends Component
   {
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _sessionData:ISessionDataManager;
      
      private var UnknownVarFromErrorPopupCtrl_IModalDialog_1:IModalDialog;
      
      private var _window:IFrameController;
      
      private var _doNotShowAgain:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function ErrorPopupCtrl(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      private static function base64encode(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         var _loc3_:Base64Encoder = new Base64Encoder();
         _loc3_.encodeBytes(_loc2_);
         return _loc3_.toString();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionData = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
      }
      
      private function createWindow() : void
      {
         if(UnknownVarFromErrorPopupCtrl_IModalDialog_1 == null)
         {
            UnknownVarFromErrorPopupCtrl_IModalDialog_1 = _windowManager.buildModalDialogFromXML(XML(XmlAsset(assets.getAssetByName("error_popup")).content));
            _window = UnknownVarFromErrorPopupCtrl_IModalDialog_1.rootWindow as IFrameController;
            closeButton.addEventListener("WME_CLICK",onWindowCloseClicked);
            okButton.addEventListener("WME_CLICK",onWindowCloseClicked);
            copyButton.addEventListener("WME_CLICK",onCopyClicked);
         }
         _window.activate();
         _window.center();
      }
      
      private function onCopyClicked(param1:WindowMouseEvent) : void
      {
         Clipboard.generalClipboard.setData("air:text",errorInfoContents.text);
      }
      
      private function onWindowCloseClicked(param1:WindowMouseEvent) : void
      {
         _doNotShowAgain = doNotShowCheckbox.isSelected;
         destroyWindow();
      }
      
      private function destroyWindow() : void
      {
         if(UnknownVarFromErrorPopupCtrl_IModalDialog_1 != null)
         {
            UnknownVarFromErrorPopupCtrl_IModalDialog_1.dispose();
            UnknownVarFromErrorPopupCtrl_IModalDialog_1 = null;
         }
      }
      
      public function onError(param1:ErrorEvent, param2:Boolean) : void
      {
         if(_windowManager.LilithCustomsInstance && _windowManager.LilithCustomsInstance.ShowCriticalErrors == false)
         {
            return;
         }
         if(_doNotShowAgain)
         {
            return;
         }
         createWindow();
         var _loc3_:Boolean = param2 && param1.error != null;
         errorInfoBorder.visible = _loc3_;
         closeButton.visible = _loc3_;
         messageText.text = param1.error?.message;
         _window.caption = "Critical core error";
         if(_loc3_)
         {
            errorInfoContents.text = base64encode(createErrorText(param1));
         }
         _window.height = contentList.height + 56;
      }
      
      public function createErrorText(param1:ErrorEvent) : String
      {
         return "Error ID: " + param1.error.errorID + "\n" + "Critical: " + param1.critical + "\n" + "Message: " + param1.message + "\n" + "User name: " + _sessionData.userName + "\n" + "User id:" + _sessionData.userId + "\n" + "Hotel: " + getProperty("environment.id") + "\n" + "---------------------" + "\n\n" + param1.error.getStackTrace();
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            destroyWindow();
         }
         _windowManager = null;
         _localizationManager = null;
         _doNotShowAgain = false;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get contentList() : IItemListWindow
      {
         return _window.findChildByName("content_list") as IItemListWindow;
      }
      
      public function get messageText() : ITextWindow
      {
         return _window.findChildByName("error_msg_text") as ITextWindow;
      }
      
      public function get errorInfoBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("error_info_border") as UnknownICoreWindowComponents6;
      }
      
      public function get errorInfoContents() : ITextFieldWindow
      {
         return _window.findChildByName("error_info_contents") as ITextFieldWindow;
      }
      
      public function get doNotShowCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("do_not_show_cbx") as UnknownICoreWindowComponents2;
      }
      
      public function get okButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("ok_button") as UnknownICoreWindowComponents4;
      }
      
      public function get copyButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("copy_button") as UnknownICoreWindowComponents4;
      }
      
      public function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close") as IWindowModel;
      }
   }
}

