package com.sulake.habbo.phonenumber
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class PhoneNumberCollectMinimizedView
   {
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
      
      private var UnknownVarFromPhoneNumberCollectMinimizedView_HabboPhoneNumber_1:HabboPhoneNumber;
      
      private var _window:IWindowModel;
      
      public function PhoneNumberCollectMinimizedView(param1:HabboPhoneNumber)
      {
         super();
         UnknownVarFromPhoneNumberCollectMinimizedView_HabboPhoneNumber_1 = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_CLICK",onClicked);
            _window.dispose();
            _window = null;
         }
         UnknownVarFromPhoneNumberCollectMinimizedView_HabboPhoneNumber_1 = null;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         if(_window)
         {
            return;
         }
         _window = UnknownVarFromPhoneNumberCollectMinimizedView_HabboPhoneNumber_1.windowManager.buildFromXML(XML(UnknownVarFromPhoneNumberCollectMinimizedView_HabboPhoneNumber_1.assets.getAssetByName("phonenumber_collect_minimized_xml").content));
         _window.addEventListener("WME_CLICK",onClicked);
         _window.addEventListener("WME_OVER",onContainerMouseOver);
         _window.addEventListener("WME_OUT",onContainerMouseOut);
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
      }
      
      private function onClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromPhoneNumberCollectMinimizedView_HabboPhoneNumber_1.setCollectViewMinimized(false);
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4286084205;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
      }
   }
}

