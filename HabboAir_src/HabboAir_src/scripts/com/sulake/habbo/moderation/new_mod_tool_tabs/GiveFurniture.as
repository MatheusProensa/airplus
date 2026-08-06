package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.moderation.NewModerationTool;
   
   [SecureSWF(rename="true")]
   public class GiveFurniture extends AbstractModToolTab
   {
      public function GiveFurniture(param1:NewModerationTool, param2:IWindowController_1)
      {
         super(param1,param2);
         plusButton.addEventListener("WME_CLICK",onPlusButtonClick);
         minusButton.addEventListener("WME_CLICK",onMinusButtonClick);
         donateFurniButton.addEventListener("WME_CLICK",onDonateClick);
      }
      
      private function onDonateClick(param1:WindowMouseEvent) : void
      {
         tool.windowManager.alert("${error.title}","${moderation.give_furni.too_many_requests}",0,onAlertConfirm);
      }
      
      private function onAlertConfirm(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
         tool.setToolCompletion(4);
      }
      
      override public function onOpen() : void
      {
         super.onOpen();
         usernameInput.text = tool.sessionDataManager.userName;
      }
      
      private function onPlusButtonClick(param1:WindowMouseEvent) : void
      {
         if(amount < 100)
         {
            amount += 1;
         }
      }
      
      private function onMinusButtonClick(param1:WindowMouseEvent) : void
      {
         if(amount > 1)
         {
            amount -= 1;
         }
      }
      
      private function get amount() : int
      {
         return parseInt(amountFurniInput.text);
      }
      
      private function set amount(param1:int) : void
      {
         amountFurniInput.text = "" + param1;
      }
      
      private function get usernameInput() : ITextFieldWindow
      {
         return window.findChildByName("give_furni_username_input") as ITextFieldWindow;
      }
      
      private function get productNameInput() : ITextFieldWindow
      {
         return window.findChildByName("product_name_input") as ITextFieldWindow;
      }
      
      private function get amountFurniInput() : ITextFieldWindow
      {
         return window.findChildByName("amount_furni_input") as ITextFieldWindow;
      }
      
      private function get plusButton() : IIconButtonWindow
      {
         return window.findChildByName("plus_btn_furni") as IIconButtonWindow;
      }
      
      private function get minusButton() : IIconButtonWindow
      {
         return window.findChildByName("minus_btn_furni") as IIconButtonWindow;
      }
      
      private function get donateFurniButton() : UnknownICoreWindowComponents4
      {
         return window.findChildByName("add_furni_btn") as UnknownICoreWindowComponents4;
      }
   }
}

