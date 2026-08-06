package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.moderation.NewModerationTool;
   
   [SecureSWF(rename="true")]
   public class HotelAlertTool extends AbstractModToolTab
   {
      public function HotelAlertTool(param1:NewModerationTool, param2:IWindowController_1)
      {
         super(param1,param2);
         sendHotelAlertButton.addEventListener("WME_CLICK",onSendClicked);
      }
      
      private function onSendClicked(param1:WindowMouseEvent) : void
      {
         tool.windowManager.simpleAlert("${notifications.broadcast.title}","",hotelAlertInput.text,"","",null,"illumina_alert_illustrations_frank_neutral_png");
         hotelAlertInput.text = "";
         tool.setToolCompletion(1);
      }
      
      private function get hotelAlertInput() : ITextFieldWindow
      {
         return window.findChildByName("hotel_alert_input") as ITextFieldWindow;
      }
      
      private function get sendHotelAlertButton() : UnknownICoreWindowComponents4
      {
         return window.findChildByName("send_hotel_alert_btn") as UnknownICoreWindowComponents4;
      }
   }
}

