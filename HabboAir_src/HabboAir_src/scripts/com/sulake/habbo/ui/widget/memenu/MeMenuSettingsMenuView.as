package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.external.ExternalInterface;
   
   public class MeMenuSettingsMenuView implements IMeMenuView
   {
      private var UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1:MeMenuWidget;
      
      private var _window:IWindowController_1;
      
      public function MeMenuSettingsMenuView()
      {
         super();
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1 = param1;
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:XmlAsset = UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1.assets.getAssetByName("memenu_settings_menu") as XmlAsset;
         if(_loc2_)
         {
            _window = UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct settings window from XML!");
         }
         _window.name = param1;
         _window.procedure = eventHandler;
         if(!ExternalInterface.available || UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1.config.getProperty("has.identity") != "1")
         {
            _window.findChildByName("character_settings").disable();
         }
         else
         {
            _window.findChildByName("identity_text").visible = false;
         }
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "character_settings":
               HabboWebTools.openAvatars();
               UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1.hide();
               break;
            case "sound_settings":
               UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1.changeView("me_menu_sound_settings");
               break;
            case "back":
               UnknownVarFromMeMenuSettingsMenuView_MeMenuWidget_1.changeView("me_menu_top_view");
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
   }
}

