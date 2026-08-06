package com.sulake.habbo.roomevents.wired_trading.chests.settings
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests.ChestPreferencesUpdateSuccessMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.SetChestNotificationPreferencesMessageComposer;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.ListScrollParams;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.BorderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.roomevents.wired_trading.AbstractUbuntuWiredUI;
   import com.sulake.habbo.roomevents.wired_trading.chests.UnknownHabboRoomeventsWired_TradingChests1;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestController;
   import flash.system.Capabilities;
   
   public class ChestNotificationSettingsUI extends AbstractUbuntuWiredUI
   {
      private var _chestController:WiredChestController;
      
      private var UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var UnknownVarFromChestNotificationSettingsUI_SectionPreset_1:SectionPreset;
      
      private var UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2:CheckboxGroupPreset;
      
      private var _notificationMode:DropdownPreset;
      
      private var UnknownVarFromChestNotificationSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1:ChestPreferencesUpdateSuccessMessageEvent;
      
      private var _chestType:int;
      
      private var _chestId:int;
      
      public function ChestNotificationSettingsUI(param1:WiredChestController, param2:PresetManager)
      {
         super(param1.roomEvents,param2);
         UnknownVarFromChestNotificationSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1 = new ChestPreferencesUpdateSuccessMessageEvent(onUpdateSuccess);
         param1.addMessageEvent(UnknownVarFromChestNotificationSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1);
         _chestController = param1;
         var _loc12_:WiredStyle = param2.wiredStyle;
         var _loc13_:UsageInfoSection = param2.createUsageInfoSection("${wiredchests.notification_settings.notification_info.desc}",true,"${wiredchests.notification_settings.notification_info}");
         var _loc3_:Array = [new CheckboxOptionParam("${wiredchests.notification_settings.enable_notifications.generic.0}",0),new CheckboxOptionParam("${wiredchests.notification_settings.enable_notifications.generic.1}",1)];
         var _loc8_:Array = [new CheckboxOptionParam("${wiredchests.notification_settings.enable_notifications.wired.0}",0),new CheckboxOptionParam("${wiredchests.notification_settings.enable_notifications.wired.1}",1),new CheckboxOptionParam("${wiredchests.notification_settings.enable_notifications.wired.2}",2)];
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1 = param2.createCheckboxGroup(_loc3_);
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2 = param2.createCheckboxGroup(_loc8_);
         var _loc5_:SectionPreset = param2.createSection("${wiredchests.notification_settings.enable_notifications.generic}",UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1);
         _loc5_.splitterVisible = false;
         UnknownVarFromChestNotificationSettingsUI_SectionPreset_1 = param2.createSection("${wiredchests.notification_settings.enable_notifications.wired}",UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2);
         var _loc10_:SimpleListViewPreset = param2.createSimpleListView(true,[_loc5_,UnknownVarFromChestNotificationSettingsUI_SectionPreset_1]);
         _loc10_.spacing = _loc12_.sectionSpacing;
         var _loc14_:BorderSection = param2.createBorderSection("${wiredchests.notification_settings.enable_notifications}",_loc10_);
         var _loc7_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc7_.push(new ExpandableDropdownOption(0,"${wiredchests.notification_settings.notification_mode.when.0}"));
         _loc7_.push(new ExpandableDropdownOption(1,"${wiredchests.notification_settings.notification_mode.when.1}"));
         _notificationMode = param2.createDropdown(new DropdownParam("${wiredchests.notification_settings.notification_mode.when}",_loc7_));
         var _loc4_:SectionPreset = param2.createSection("${wiredchests.notification_settings.notification_mode.when}",_notificationMode);
         _loc4_.splitterVisible = false;
         var _loc11_:BorderSection = param2.createBorderSection("${wiredchests.notification_settings.notification_mode}",_loc4_);
         var _loc6_:int = 320;
         var _loc9_:int = Capabilities.screenResolutionY / 2.4;
         var _loc15_:ListScrollParams = new ListScrollParams(false,_loc6_,_loc9_,true);
         framePreset = param2.createFramePreset([_loc13_,_loc14_,_loc11_,footerPreset],onCloseClicked,null,-1,false,false,_loc15_);
         framePreset.resizeToWidth(350);
      }
      
      private function onUpdateSuccess(param1:ChestPreferencesUpdateSuccessMessageEvent) : void
      {
         if(param1.getParser().chestId == _chestId && param1.getParser().isNotificationPreferences)
         {
            hideFrame();
         }
      }
      
      public function set chestType(param1:int) : void
      {
         _chestType = param1;
         var _loc2_:String = localization.getLocalization("wiredchests." + (param1 == UnknownHabboRoomeventsWired_TradingChests1.TYPE_FURNI ? "furni" : "coin") + "_chest");
         framePreset.title = localization.getLocalizationWithParams("wiredchests.notification_settings.title","","chest_type",_loc2_);
      }
      
      public function onEdit(param1:int, param2:int, param3:Map) : void
      {
         chestType = param2;
         _chestId = param1;
         var _loc6_:* = param3.getValue("notification_chest_full") == "1";
         var _loc7_:* = param3.getValue("notification_donation") == "1";
         var _loc8_:* = param3.getValue("notification_someone_withdraws") == "1";
         var _loc5_:* = param3.getValue("notification_chest_empty") == "1";
         var _loc10_:* = param3.getValue("notification_wired_transaction") == "1";
         var _loc4_:int = param3.getValue("notify_mode");
         var _loc9_:* = param3.getValue("is_wired_enabled") == "1";
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1.get(0).selected = _loc6_;
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1.get(1).selected = _loc7_;
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2.get(0).selected = _loc8_;
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2.get(1).selected = _loc5_;
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2.get(2).selected = _loc10_;
         _notificationMode.selectedId = _loc4_;
         UnknownVarFromChestNotificationSettingsUI_SectionPreset_1.disabled = !_loc9_;
         showFrame();
      }
      
      override public function onSaveClicked() : void
      {
         _chestController.send(new SetChestNotificationPreferencesMessageComposer(_chestId,_notificationMode.selectedId,UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1.get(0).selected,UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1.get(1).selected,UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2.get(0).selected,UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2.get(1).selected,UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2.get(2).selected));
      }
      
      public function get chestController() : WiredChestController
      {
         return _chestController;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _chestController.removeMessageEvent(UnknownVarFromChestNotificationSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1);
         UnknownVarFromChestNotificationSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1 = null;
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_1 = null;
         UnknownVarFromChestNotificationSettingsUI_SectionPreset_1 = null;
         UnknownVarFromChestNotificationSettingsUI_CheckboxGroupPreset_2 = null;
         _notificationMode = null;
         _chestController = null;
         _chestType = 0;
         _chestId = -1;
         super.dispose();
      }
   }
}

