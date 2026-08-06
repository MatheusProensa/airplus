package com.sulake.habbo.toolbar.extensions.settings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   
   public class ChatSettingsView
   {
      private var _window:IWindowController_1;
      
      private var _toolbar:HabboToolbar;
      
      private var UnknownVarFromChatSettingsView_IDropBaseController_1_1:IDropBaseController_1;
      
      private var UnknownVarFromChatSettingsView_IDropBaseController_1_2:IDropBaseController_1;
      
      private var UnknownVarFromChatSettingsView_IDropBaseController_1_3:IDropBaseController_1;
      
      private var UnknownVarFromChatSettingsView_Boolean_1:Boolean;
      
      public function ChatSettingsView(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         saveSettings();
         _window.dispose();
         _window = null;
         UnknownVarFromChatSettingsView_IDropBaseController_1_1 = null;
         UnknownVarFromChatSettingsView_IDropBaseController_1_2 = null;
         UnknownVarFromChatSettingsView_IDropBaseController_1_3 = null;
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = _toolbar.assets.getAssetByName("toolbar_chat_settings_xml") as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc1_.content as XML) as IWindowController_1;
         _window.procedure = onWindowEvent;
         UnknownVarFromChatSettingsView_IDropBaseController_1_1 = _window.findChildByName("chat_mode") as IDropBaseController_1;
         UnknownVarFromChatSettingsView_IDropBaseController_1_2 = _window.findChildByName("chat_bubble_width") as IDropBaseController_1;
         UnknownVarFromChatSettingsView_IDropBaseController_1_3 = _window.findChildByName("chat_scroll_speed") as IDropBaseController_1;
         UnknownVarFromChatSettingsView_IDropBaseController_1_1.addEventListener("WE_SELECTED",onDropMenuSelectionChanged);
         UnknownVarFromChatSettingsView_IDropBaseController_1_2.addEventListener("WE_SELECTED",onDropMenuSelectionChanged);
         UnknownVarFromChatSettingsView_IDropBaseController_1_3.addEventListener("WE_SELECTED",onDropMenuSelectionChanged);
         UnknownVarFromChatSettingsView_Boolean_1 = true;
         populateTexts();
         populateDropMenus();
         updateSelections();
         UnknownVarFromChatSettingsView_Boolean_1 = false;
      }
      
      private function populateTexts() : void
      {
         ITextWindow(_window.findChildByName("settings_title")).caption = localize("toolbar.chat.settings.title","Chat settings");
         ITextWindow(_window.findChildByName("chat_settings_info")).caption = localize("toolbar.chat.settings.info","Choose how chat appears for you.");
         ITextWindow(_window.findChildByName("chat_mode_label")).caption = localize("toolbar.chat.settings.mode","Chat mode");
         ITextWindow(_window.findChildByName("chat_bubble_width_label")).caption = localize("toolbar.chat.settings.bubble_width","Bubble width");
         ITextWindow(_window.findChildByName("chat_scroll_speed_label")).caption = localize("toolbar.chat.settings.scroll_speed","Scroll speed");
      }
      
      private function populateDropMenus() : void
      {
         UnknownVarFromChatSettingsView_IDropBaseController_1_1.populate([localize("navigator.roomsettings.chat.mode.free.flow","Free flow"),localize("navigator.roomsettings.chat.mode.line.by.line","Line by line")]);
         UnknownVarFromChatSettingsView_IDropBaseController_1_2.populate([localize("navigator.roomsettings.chat.bubbles.width.wide","Wide"),localize("navigator.roomsettings.chat.bubbles.width.normal","Normal"),localize("navigator.roomsettings.chat.bubbles.width.thin","Thin")]);
         UnknownVarFromChatSettingsView_IDropBaseController_1_3.populate([localize("navigator.roomsettings.chat.speed.fast","Fast"),localize("navigator.roomsettings.chat.speed.normal","Normal"),localize("navigator.roomsettings.chat.speed.slow","Slow")]);
      }
      
      private function updateSelections() : void
      {
         if(_toolbar.freeFlowChat == null)
         {
            return;
         }
         UnknownVarFromChatSettingsView_IDropBaseController_1_1.selection = _toolbar.freeFlowChat.chatMode;
         UnknownVarFromChatSettingsView_IDropBaseController_1_2.selection = _toolbar.freeFlowChat.chatBubbleWidth;
         UnknownVarFromChatSettingsView_IDropBaseController_1_3.selection = _toolbar.freeFlowChat.chatScrollSpeed;
      }
      
      private function saveSettings() : void
      {
         if(_toolbar == null || _toolbar.freeFlowChat == null || UnknownVarFromChatSettingsView_IDropBaseController_1_1 == null || UnknownVarFromChatSettingsView_IDropBaseController_1_2 == null || UnknownVarFromChatSettingsView_IDropBaseController_1_3 == null)
         {
            return;
         }
         _toolbar.freeFlowChat.updateChatPreferences(clampSelection(UnknownVarFromChatSettingsView_IDropBaseController_1_1.selection,0),clampSelection(UnknownVarFromChatSettingsView_IDropBaseController_1_2.selection,1),clampSelection(UnknownVarFromChatSettingsView_IDropBaseController_1_3.selection,1));
      }
      
      private function clampSelection(param1:int, param2:int) : int
      {
         return param1 >= 0 ? param1 : param2;
      }
      
      private function onDropMenuSelectionChanged(param1:WindowEvent) : void
      {
         if(UnknownVarFromChatSettingsView_Boolean_1)
         {
            return;
         }
         saveSettings();
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2.name == "back_btn")
         {
            dispose();
         }
      }
      
      private function localize(param1:String, param2:String) : String
      {
         return _toolbar.localization != null ? _toolbar.localization.getLocalization(param1,param2) : param2;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
   }
}

