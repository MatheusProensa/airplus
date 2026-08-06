package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.moderation.NewModerationTool;
   
   [SecureSWF(rename="true")]
   public class SendWarning extends AbstractModToolTab
   {
      private static var A:int = 50;
      
      private static var B:int = 40;
      
      private var UnknownVarFromSendWarning_Boolean_1:Boolean = false;
      
      private var UnknownVarFromSendWarning_Boolean_2:Boolean = false;
      
      public function SendWarning(param1:NewModerationTool, param2:IWindowController_1)
      {
         super(param1,param2);
         sendWarningButton.addEventListener("WME_CLICK",onSendWarningClick);
      }
      
      private function onSendWarningClick(param1:WindowMouseEvent) : void
      {
         if(warningInput.length < A)
         {
            tool.windowManager.alert("${moderation.warning.send.warn_title}",tool.localizationManager.getLocalizationWithParams("moderation.warning.send.validation_short","","x",A),0,onAlertConfirm);
            UnknownVarFromSendWarning_Boolean_1 = true;
         }
         else if(warningInput.length > B)
         {
            tool.windowManager.alert("${moderation.warning.send.warn_title}",tool.localizationManager.getLocalizationWithParams("moderation.warning.send.validation_long","","x",B),0,onAlertConfirm);
            UnknownVarFromSendWarning_Boolean_2 = true;
         }
      }
      
      private function onAlertConfirm(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
         if(UnknownVarFromSendWarning_Boolean_1 && UnknownVarFromSendWarning_Boolean_2)
         {
            tool.setToolCompletion(2);
         }
      }
      
      private function get usernameInput() : ITextFieldWindow
      {
         return window.findChildByName("warning_username_input") as ITextFieldWindow;
      }
      
      private function get warningInput() : ITextFieldWindow
      {
         return window.findChildByName("warning_input") as ITextFieldWindow;
      }
      
      private function get sendWarningButton() : UnknownICoreWindowComponents4
      {
         return window.findChildByName("send_warning_btn") as UnknownICoreWindowComponents4;
      }
   }
}

