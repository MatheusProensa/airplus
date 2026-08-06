package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.moderation.NewModerationTool;
   
   [SecureSWF(rename="true")]
   public class UserBanManagementTool extends AbstractModToolTab
   {
      public function UserBanManagementTool(param1:NewModerationTool, param2:IWindowController_1)
      {
         super(param1,param2);
         getBanRadio.select();
         performBanAction.addEventListener("WME_CLICK",onBanClick);
      }
      
      private function onBanClick(param1:WindowMouseEvent) : void
      {
         usernameInput.text = tool.sessionDataManager.userName;
         getBanRadio.select();
         getDurationSelector.selection = getDurationSelector.numMenuItems - 1;
         tool.windowManager.confirm("${moderation.ban_management.do.title}",tool.localizationManager.getLocalizationWithParams("moderation.ban_management.do.desc","","action",!!getBanRadio.isSelected ? "BAN" : "UNBAN","user",usernameInput.text,"duration",getDurationSelector.enumerateSelection()[getDurationSelector.selection]),0,onConfirmClicked);
      }
      
      private function onConfirmClicked(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
         tool.setToolCompletion(0);
      }
      
      private function get usernameInput() : ITextFieldWindow
      {
         return window.findChildByName("ban_username_input") as ITextFieldWindow;
      }
      
      private function get getBanRadio() : IRadioButtonWindow
      {
         return window.findChildByName("ban_radio") as IRadioButtonWindow;
      }
      
      private function get getUnbanRadio() : IRadioButtonWindow
      {
         return window.findChildByName("unban_radio") as IRadioButtonWindow;
      }
      
      private function get getDurationSelector() : IDropBaseController_1
      {
         return window.findChildByName("duration_selector") as IDropBaseController_1;
      }
      
      private function get performBanAction() : UnknownICoreWindowComponents4
      {
         return window.findChildByName("ban_btn") as UnknownICoreWindowComponents4;
      }
   }
}

