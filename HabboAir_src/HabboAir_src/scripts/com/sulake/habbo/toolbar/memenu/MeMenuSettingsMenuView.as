package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.memenu.soundsettings.MeMenuSoundSettingsView;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.external.ExternalInterface;
   
   public class MeMenuSettingsMenuView
   {
      private var _widget:MeMenuController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMeMenuSettingsMenuView_ToolbarView_1:ToolbarView;
      
      private var UnknownVarFromMeMenuSettingsMenuView_MeMenuSoundSettingsView_1:MeMenuSoundSettingsView;
      
      public function MeMenuSettingsMenuView()
      {
         super();
      }
      
      public function init(param1:MeMenuController, param2:ToolbarView) : void
      {
         UnknownVarFromMeMenuSettingsMenuView_ToolbarView_1 = param2;
         _widget = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromMeMenuSettingsMenuView_MeMenuSoundSettingsView_1 != null)
         {
            UnknownVarFromMeMenuSettingsMenuView_MeMenuSoundSettingsView_1.dispose();
            UnknownVarFromMeMenuSettingsMenuView_MeMenuSoundSettingsView_1 = null;
         }
         _widget = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = _widget.toolbar.assets.getAssetByName("me_menu_settings_menu_xml") as XmlAsset;
         if(_loc1_)
         {
            _window = _widget.toolbar.windowManager.buildFromXML(_loc1_.content as XML) as IWindowController_1;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct settings window from XML!");
         }
         _window.procedure = eventHandler;
         _window.x = UnknownVarFromMeMenuSettingsMenuView_ToolbarView_1.window.width + 10;
         _window.y = UnknownVarFromMeMenuSettingsMenuView_ToolbarView_1.window.bottom - _window.height;
         if(!ExternalInterface.available || _widget.toolbar.getProperty("has.identity") != "1")
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
               break;
            case "sound_settings":
               UnknownVarFromMeMenuSettingsMenuView_MeMenuSoundSettingsView_1 = new MeMenuSoundSettingsView();
               UnknownVarFromMeMenuSettingsMenuView_MeMenuSoundSettingsView_1.init(this,UnknownVarFromMeMenuSettingsMenuView_ToolbarView_1);
               _window.visible = false;
               break;
            case "back":
               _widget.window.visible = true;
               dispose();
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
      
      public function get widget() : MeMenuController
      {
         return _widget;
      }
   }
}

