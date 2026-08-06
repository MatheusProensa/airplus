package com.sulake.habbo.discord.settings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.WindowUtils;
   import com.sulake.habbo.communication.messages.parser.discord.DiscordPreferences;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class DiscordSettingsView implements IComponentInterfaceQueue
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var UnknownVarFromDiscordSettingsView_DiscordSettingsController_1:DiscordSettingsController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IFrameController;
      
      private var _disposed:Boolean = false;
      
      public function DiscordSettingsView(param1:DiscordSettingsController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromDiscordSettingsView_DiscordSettingsController_1 = param1;
         _windowManager = param2;
         _window = param2.buildFromXML(XML(UnknownVarFromDiscordSettingsView_DiscordSettingsController_1.assets.getAssetByName("discord_settings_xml").content),1) as IFrameController;
         _window.enableLookupCache();
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         funnyButton.addEventListener("WME_CLICK",onWindowClose);
         var _loc3_:Array = [discordStatusCheckbox,shareActivityCheckbox,hideHiddenRoomsCheckbox,allowJoiningCheckbox];
         for each(var _loc4_ in _loc3_)
         {
            _loc4_.addEventListener("WE_SELECTED",onCheckboxChanged);
            _loc4_.addEventListener("WE_UNSELECTED",onCheckboxChanged);
         }
         collectiblesServerButton.addEventListener("WME_CLICK",onClickCollectiblesDiscord);
         wiredServerButton.addEventListener("WME_CLICK",onClickWiredDiscord);
         originsServerButton.addEventListener("WME_CLICK",onClickOriginsDiscord);
         show();
         hide();
      }
      
      private function onCheckboxChanged(param1:WindowEvent) : void
      {
         updateUI();
      }
      
      private function updateUI() : void
      {
         discordBox.greyscale = !discordStatusCheckbox.isSelected;
         discordBox.invalidate();
         WindowUtils.disableSection(shareActivityCheckbox.parent,!discordStatusCheckbox.isSelected);
         WindowUtils.disableSection(hideHiddenRoomsCheckbox.parent,!discordStatusCheckbox.isSelected || !shareActivityCheckbox.isSelected);
         WindowUtils.disableSection(allowJoiningCheckbox.parent,!discordStatusCheckbox.isSelected || !shareActivityCheckbox.isSelected);
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromDiscordSettingsView_DiscordSettingsController_1.updatePreferences(discordStatusCheckbox.isSelected,shareActivityCheckbox.isSelected,hideHiddenRoomsCheckbox.isSelected,allowJoiningCheckbox.isSelected);
         hide();
      }
      
      public function initialize(param1:DiscordPreferences) : void
      {
         discordStatusCheckbox.isSelected = param1.showHabbo;
         shareActivityCheckbox.isSelected = param1.shareActivity;
         hideHiddenRoomsCheckbox.isSelected = param1.hideInHiddenRooms;
         allowJoiningCheckbox.isSelected = param1.allowJoining;
         updateUI();
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
               _window.center();
               _window.activate();
            }
         }
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
      }
      
      private function onClickCollectiblesDiscord(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(UnknownVarFromDiscordSettingsView_DiscordSettingsController_1.getProperty("collectibles.discord.link"));
      }
      
      private function onClickWiredDiscord(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(UnknownVarFromDiscordSettingsView_DiscordSettingsController_1.getProperty("wired.discord.link"));
      }
      
      private function onClickOriginsDiscord(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(UnknownVarFromDiscordSettingsView_DiscordSettingsController_1.getProperty("origins.discord.link"));
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _windowManager = null;
         UnknownVarFromDiscordSettingsView_DiscordSettingsController_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get discordBox() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("discord_box") as IStaticBitmapWrapperWindow;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close") as IWindowModel;
      }
      
      private function get discordStatusCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("show_habbo_cbx") as UnknownICoreWindowComponents2;
      }
      
      private function get shareActivityCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("share_activity_cbx") as UnknownICoreWindowComponents2;
      }
      
      private function get hideHiddenRoomsCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("hide_in_hidden_cbx") as UnknownICoreWindowComponents2;
      }
      
      private function get allowJoiningCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("allow_joining_cbx") as UnknownICoreWindowComponents2;
      }
      
      private function get collectiblesServerButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("collectibles_server") as UnknownICoreWindowComponents5;
      }
      
      private function get wiredServerButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("wired_server") as UnknownICoreWindowComponents5;
      }
      
      private function get originsServerButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("origins_server") as UnknownICoreWindowComponents5;
      }
      
      private function get funnyButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("funny_button") as UnknownICoreWindowComponents4;
      }
   }
}

