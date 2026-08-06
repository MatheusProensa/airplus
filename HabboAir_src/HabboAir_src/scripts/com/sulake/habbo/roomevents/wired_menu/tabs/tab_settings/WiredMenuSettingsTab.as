package com.sulake.habbo.roomevents.wired_menu.tabs.tab_settings
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomSettingsEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetRoomSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetRoomSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredUpdateRoomComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredRoomSettingsMessageParser;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_setup.UserDefinedRoomEventsCtrl;
   
   public class WiredMenuSettingsTab extends WiredMenuDefaultTab
   {
      private var MODIFY_PERMISSION_OPTIONS:Array;
      
      private var READ_PERMISSION_OPTIONS:Array;
      
      private var UnknownVarFromWiredMenuSettingsTab_Int_1:int = -1;
      
      private var UnknownVarFromWiredMenuSettingsTab_Int_2:int = -1;
      
      private var UnknownVarFromWiredMenuSettingsTab_String_1:String = null;
      
      private var _ignoringCheckboxEvents:Boolean = false;
      
      private var _ignoringTimezoneEvents:Boolean = false;
      
      private var _ignoringUiStyleEvents:Boolean = false;
      
      public function WiredMenuSettingsTab(param1:WiredMenuController, param2:IWindowController_1)
      {
         var _loc4_:int = 0;
         var _loc3_:UnknownICoreWindowComponents2 = null;
         MODIFY_PERMISSION_OPTIONS = [1,2,3];
         READ_PERMISSION_OPTIONS = [0,1,2,3];
         super(param1,param2);
         addMessageEvent(new WiredRoomSettingsEvent(onWiredSettings));
         updateLoadingState();
         requestData();
         for each(_loc4_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc3_ = getModifyCheckbox(_loc4_);
            _loc3_.addEventListener("WE_SELECTED",onPermissionsChanged);
            _loc3_.addEventListener("WE_UNSELECTED",onPermissionsChanged);
         }
         for each(_loc4_ in READ_PERMISSION_OPTIONS)
         {
            _loc3_ = getReadCheckbox(_loc4_);
            _loc3_.addEventListener("WE_SELECTED",onPermissionsChanged);
            _loc3_.addEventListener("WE_UNSELECTED",onPermissionsChanged);
         }
         toolbarCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         toolbarCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         wiredInspectButton.addEventListener("WE_SELECTED",onPreferencesChanged);
         wiredInspectButton.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         playtestCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         playtestCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         allNotificationsCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         allNotificationsCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         uiStyleDropdown.addEventListener("WE_SELECTED",onPreferencesChanged);
         saveReloadButton.addEventListener("WME_CLICK",onClickReload);
         rollbackButton.addEventListener("WME_CLICK",onClickRollback);
         timezoneDropdown.addEventListener("WE_SELECTED",onSelectTimezone);
         wiredStyleBorder.visible = param1.getBoolean("wired.ui_picker_enabled");
      }
      
      private function onClickRollback(param1:WindowMouseEvent) : void
      {
         controller.windowManager.confirm("${wiredmenu.settings.room_state.roll_back}","${wiredmenu.settings.room_state.roll_back.warning}",0,onRollbackConfirmed).titleBarColor = 13909337;
      }
      
      private function onRollbackConfirmed(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            controller.send(new WiredUpdateRoomComposer(true));
         }
         param1.dispose();
      }
      
      private function onClickReload(param1:WindowMouseEvent) : void
      {
         controller.send(new WiredUpdateRoomComposer(false));
      }
      
      private function onWiredSettings(param1:WiredRoomSettingsEvent) : void
      {
         var _loc2_:WiredRoomSettingsMessageParser = param1.getParser();
         UnknownVarFromWiredMenuSettingsTab_Int_1 = _loc2_.modifyPermissionMask;
         UnknownVarFromWiredMenuSettingsTab_Int_2 = _loc2_.readPermissionMask;
         UnknownVarFromWiredMenuSettingsTab_String_1 = _loc2_.timezone;
         updateLoadingState();
      }
      
      override protected function isDataReady() : Boolean
      {
         return UnknownVarFromWiredMenuSettingsTab_Int_1 != -1 && UnknownVarFromWiredMenuSettingsTab_Int_2 != -1 && UnknownVarFromWiredMenuSettingsTab_String_1 != null;
      }
      
      private function requestData() : void
      {
         controller.send(new WiredGetRoomSettingsMessageComposer());
      }
      
      override public function permissionsUpdated() : void
      {
         updateButtonsUI();
      }
      
      override protected function initializeInterface() : void
      {
         updatePermissionsUI();
         updatePreferencesUI();
         updateTimezoneUI();
         updateButtonsUI();
         updateUiStyleUI();
      }
      
      private function onPermissionsChanged(param1:WindowEvent) : void
      {
         if(_ignoringCheckboxEvents)
         {
            return;
         }
         var _loc3_:UnknownICoreWindowComponents2 = param1.target as UnknownICoreWindowComponents2;
         var _loc2_:int = int(_loc3_.id);
         var _loc5_:* = _loc3_.name.indexOf("modify_") == 0;
         var _loc4_:* = param1.type == "WE_SELECTED";
         if(_loc5_)
         {
            if(_loc4_)
            {
               UnknownVarFromWiredMenuSettingsTab_Int_1 |= 1 << _loc2_;
            }
            else
            {
               UnknownVarFromWiredMenuSettingsTab_Int_1 &= ~(1 << _loc2_);
            }
         }
         else if(_loc4_)
         {
            UnknownVarFromWiredMenuSettingsTab_Int_2 |= 1 << _loc2_;
         }
         else
         {
            UnknownVarFromWiredMenuSettingsTab_Int_2 &= ~(1 << _loc2_);
         }
         updatePermissionsUI();
         updateTimezoneUI();
         controller.send(new WiredSetRoomSettingsMessageComposer(UnknownVarFromWiredMenuSettingsTab_Int_1,UnknownVarFromWiredMenuSettingsTab_Int_2,UnknownVarFromWiredMenuSettingsTab_String_1));
      }
      
      private function onSelectTimezone(param1:WindowEvent) : void
      {
         if(_ignoringTimezoneEvents)
         {
            return;
         }
         var _loc2_:int = timezoneDropdown.selection;
         if(_loc2_ < 0 || _loc2_ >= timezoneDropdown.numMenuItems)
         {
            UnknownVarFromWiredMenuSettingsTab_String_1 = "";
         }
         else
         {
            UnknownVarFromWiredMenuSettingsTab_String_1 = timezoneDropdown.enumerateSelection()[_loc2_];
         }
         controller.send(new WiredSetRoomSettingsMessageComposer(UnknownVarFromWiredMenuSettingsTab_Int_1,UnknownVarFromWiredMenuSettingsTab_Int_2,UnknownVarFromWiredMenuSettingsTab_String_1));
      }
      
      private function updateButtonsUI() : void
      {
         var _loc1_:Boolean = controller.isRoomOwnerOrStaff();
         var _loc2_:Boolean = controller.hasWritePermission;
         Util.disableSection(saveReloadButton,!_loc2_);
         Util.disableSection(rollbackButton,!_loc1_);
      }
      
      private function updateTimezoneUI() : void
      {
         var _loc5_:int = 0;
         var _loc4_:String = null;
         _ignoringTimezoneEvents = true;
         var _loc2_:IDropBaseController_1 = timezoneDropdown;
         var _loc3_:String = controller.getProperty("wired.timezones");
         var _loc1_:Array = _loc3_ == null || _loc3_ == "" ? ["UTC"] : _loc3_.split(",");
         var _loc6_:Vector.<String> = new Vector.<String>();
         if(UnknownVarFromWiredMenuSettingsTab_String_1 != "")
         {
            _loc6_.push(UnknownVarFromWiredMenuSettingsTab_String_1);
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc5_];
            if(_loc4_ != UnknownVarFromWiredMenuSettingsTab_String_1)
            {
               _loc6_.push(_loc4_);
            }
            _loc5_++;
         }
         _loc2_.populateWithVector(_loc6_);
         if(_loc6_.length > 0)
         {
            _loc2_.selection = 0;
         }
         Util.disableSection(_loc2_,_loc6_.length < 2 || !timezoneContainer.isEnabled());
         _ignoringTimezoneEvents = false;
      }
      
      private function updateUiStyleUI() : void
      {
         _ignoringUiStyleEvents = true;
         var _loc1_:IDropBaseController_1 = uiStyleDropdown;
         var _loc4_:String = "illumina";
         var _loc3_:String = localization.getLocalizationWithParams("wiredmenu.settings.preferences.wired_style.default","","name",Util.snakeToTitle(_loc4_));
         var _loc2_:Array = [_loc3_];
         for each(var _loc5_ in UserDefinedRoomEventsCtrl.STYLE_OPTIONS)
         {
            _loc2_.push(Util.snakeToTitle(_loc5_));
         }
         _loc1_.populate(_loc2_);
         pickedWiredStyleName = controller.uiStyle;
         _ignoringUiStyleEvents = false;
      }
      
      private function updatePermissionsUI() : void
      {
         var _loc4_:int = 0;
         var _loc3_:UnknownICoreWindowComponents2 = null;
         var _loc1_:UnknownICoreWindowComponents2 = null;
         _ignoringCheckboxEvents = true;
         selectedModifyMask = UnknownVarFromWiredMenuSettingsTab_Int_1;
         selectedReadMask = UnknownVarFromWiredMenuSettingsTab_Int_2;
         var _loc2_:Boolean = controller.isRoomOwnerOrStaff();
         Util.disableSection(modifySettingsContainer,!_loc2_);
         Util.disableSection(readSettingsContainer,!_loc2_);
         Util.disableSection(timezoneContainer,!_loc2_);
         if(getModifyCheckbox(2).isSelected)
         {
            getModifyCheckbox(3).select();
            Util.disableSection(getModifyCheckbox(3));
         }
         if(getReadCheckbox(2).isSelected)
         {
            getReadCheckbox(3).select();
            Util.disableSection(getReadCheckbox(3));
         }
         if(getReadCheckbox(0).isSelected)
         {
            for each(_loc4_ in READ_PERMISSION_OPTIONS)
            {
               if(_loc4_ != 0)
               {
                  _loc3_ = getReadCheckbox(_loc4_);
                  _loc3_.select();
                  Util.disableSection(_loc3_);
               }
            }
         }
         for each(_loc4_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc3_ = getModifyCheckbox(_loc4_);
            if(_loc3_.isSelected)
            {
               _loc1_ = getReadCheckbox(_loc4_);
               _loc1_.select();
               Util.disableSection(_loc1_);
            }
         }
         _ignoringCheckboxEvents = false;
      }
      
      public function updatePreferencesUI() : void
      {
         _ignoringCheckboxEvents = true;
         Util.select(toolbarCheckbox,controller.wiredMenuButton);
         Util.select(wiredInspectButton,controller.wiredInspectButton);
         Util.select(playtestCheckbox,controller.playTestMode);
         Util.select(allNotificationsCheckbox,controller.showAllNotifications);
         _ignoringCheckboxEvents = false;
      }
      
      private function onPreferencesChanged(param1:WindowEvent) : void
      {
         if(_ignoringCheckboxEvents || _ignoringUiStyleEvents)
         {
            return;
         }
         controller.wiredMenuButton = toolbarCheckbox.isSelected;
         controller.wiredInspectButton = wiredInspectButton.isSelected;
         controller.setPlayTestMode(playtestCheckbox.isSelected,true);
         controller.showAllNotifications = allNotificationsCheckbox.isSelected;
         controller.uiStyle = pickedWiredStyleName;
         controller.sendPreferences();
      }
      
      private function set pickedWiredStyleName(param1:String) : void
      {
         _ignoringUiStyleEvents = true;
         if(param1 == "")
         {
            uiStyleDropdown.selection = 0;
            return;
         }
         var _loc2_:int = UserDefinedRoomEventsCtrl.STYLE_OPTIONS.indexOf(param1) + 1;
         uiStyleDropdown.selection = _loc2_;
         _ignoringUiStyleEvents = false;
      }
      
      private function get pickedWiredStyleName() : String
      {
         if(uiStyleDropdown.selection <= 0)
         {
            return "";
         }
         return UserDefinedRoomEventsCtrl.STYLE_OPTIONS[uiStyleDropdown.selection - 1];
      }
      
      private function get modifySettingsContainer() : IWindowController_1
      {
         return container.findChildByName("modify_settings_container") as IWindowController_1;
      }
      
      private function get readSettingsContainer() : IWindowController_1
      {
         return container.findChildByName("read_settings_container") as IWindowController_1;
      }
      
      private function get timezoneContainer() : IWindowController_1
      {
         return container.findChildByName("timezone_container") as IWindowController_1;
      }
      
      private function get toolbarCheckbox() : UnknownICoreWindowComponents2
      {
         return container.findChildByName("preference_toolbar_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get wiredInspectButton() : UnknownICoreWindowComponents2
      {
         return container.findChildByName("preference_inspect_button_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get playtestCheckbox() : UnknownICoreWindowComponents2
      {
         return container.findChildByName("preference_playtest_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get allNotificationsCheckbox() : UnknownICoreWindowComponents2
      {
         return container.findChildByName("preference_all_notifications_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function getModifyCheckbox(param1:int) : UnknownICoreWindowComponents2
      {
         return container.findChildByName("modify_" + param1 + "_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function getReadCheckbox(param1:int) : UnknownICoreWindowComponents2
      {
         return container.findChildByName("read_" + param1 + "_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get timezoneDropdown() : IDropBaseController_1
      {
         return container.findChildByName("timezone_picker") as IDropBaseController_1;
      }
      
      private function get uiStyleDropdown() : IDropBaseController_1
      {
         return container.findChildByName("wired_style_picker") as IDropBaseController_1;
      }
      
      private function get wiredStyleBorder() : UnknownICoreWindowComponents6
      {
         return container.findChildByName("wired_style_border") as UnknownICoreWindowComponents6;
      }
      
      private function get saveReloadButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("reload_room_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get rollbackButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("roll_back_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get selectedModifyMask() : int
      {
         var _loc1_:UnknownICoreWindowComponents2 = null;
         var _loc3_:* = 0;
         for each(var _loc2_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc1_ = getModifyCheckbox(_loc2_);
            if(_loc1_.isSelected)
            {
               _loc3_ |= 1 << _loc2_;
            }
         }
         return _loc3_;
      }
      
      private function get selectedReadMask() : int
      {
         var _loc1_:UnknownICoreWindowComponents2 = null;
         var _loc3_:* = 0;
         for each(var _loc2_ in READ_PERMISSION_OPTIONS)
         {
            _loc1_ = getReadCheckbox(_loc2_);
            if(_loc1_.isSelected)
            {
               _loc3_ |= 1 << _loc2_;
            }
         }
         return _loc3_;
      }
      
      private function set selectedModifyMask(param1:int) : void
      {
         var _loc2_:UnknownICoreWindowComponents2 = null;
         for each(var _loc3_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc2_ = getModifyCheckbox(_loc3_);
            Util.select(_loc2_,(param1 & 1 << _loc3_) != 0);
         }
      }
      
      private function set selectedReadMask(param1:int) : void
      {
         var _loc2_:UnknownICoreWindowComponents2 = null;
         for each(var _loc3_ in READ_PERMISSION_OPTIONS)
         {
            _loc2_ = getReadCheckbox(_loc3_);
            Util.select(_loc2_,(param1 & 1 << _loc3_) != 0);
         }
      }
   }
}

