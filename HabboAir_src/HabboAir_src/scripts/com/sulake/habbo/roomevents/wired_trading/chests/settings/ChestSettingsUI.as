package com.sulake.habbo.roomevents.wired_trading.chests.settings
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.chests.ChestPreferencesUpdateSuccessMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.SetChestPreferencesMessageComposer;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.ListScrollParams;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ContainerButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.StaticBitmapAssetWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.BorderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.roomevents.wired_trading.AbstractUbuntuWiredUI;
   import com.sulake.habbo.roomevents.wired_trading.chests.UnknownHabboRoomeventsWired_TradingChests1;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestController;
   import flash.system.Capabilities;
   
   public class ChestSettingsUI extends AbstractUbuntuWiredUI
   {
      private var _chestController:WiredChestController;
      
      private var UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var _chestName:TextInputPreset;
      
      private var _chestDesc:TextAreaPreset;
      
      private var _chestState:DropdownPreset;
      
      private var UnknownVarFromChestSettingsUI_SectionPreset_1:SectionPreset;
      
      private var _openStateDropdown:DropdownPreset;
      
      private var UnknownVarFromChestSettingsUI_SectionPreset_2:SectionPreset;
      
      private var _amountPreviewDropdown:DropdownPreset;
      
      private var UnknownVarFromChestSettingsUI_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var UnknownVarFromChestSettingsUI_ContainerButtonPreset_1:ContainerButtonPreset;
      
      private var UnknownVarFromChestSettingsUI_StaticBitmapAssetWrapperPreset_1:StaticBitmapAssetWrapperPreset;
      
      private var UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1:WiredChestWiredUpdateConfirmationView;
      
      private var UnknownVarFromChestSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1:ChestPreferencesUpdateSuccessMessageEvent;
      
      private var _chestType:int;
      
      private var _chestId:int;
      
      private var _chestItemType:int;
      
      private var UnknownVarFromChestSettingsUI_Boolean_1:Boolean;
      
      public function ChestSettingsUI(param1:WiredChestController, param2:PresetManager)
      {
         super(param1.roomEvents,param2);
         UnknownVarFromChestSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1 = new ChestPreferencesUpdateSuccessMessageEvent(onUpdateSuccess);
         param1.addMessageEvent(UnknownVarFromChestSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1);
         _chestController = param1;
         var _loc13_:WiredStyle = param2.wiredStyle;
         var _loc16_:Array = [new CheckboxOptionParam("${wiredchests.settings.access.open}"),new CheckboxOptionParam("${wiredchests.settings.access.donate}")];
         UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1 = param2.createCheckboxGroup(_loc16_);
         var _loc8_:BorderSection = param2.createBorderSection("${wiredchests.settings.access}",UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1);
         _chestName = param2.createTextInput(new TextInputParam("",30));
         _chestDesc = param2.createTextArea(new TextAreaParam(64,-1,4,-1,200,"",null,null,true,true));
         var _loc9_:SectionPreset = param2.createSection("${wiredchests.settings.info.name}",_chestName);
         _loc9_.splitterVisible = false;
         var _loc6_:SectionPreset = param2.createSection("${wiredchests.settings.info.desc}",_chestDesc);
         var _loc14_:SimpleListViewPreset = param2.createSimpleListView(true,[_loc9_,_loc6_]);
         _loc14_.spacing = _loc13_.sectionSpacing;
         var _loc17_:BorderSection = param2.createBorderSection("${wiredchests.settings.info}",_loc14_);
         var _loc12_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc12_.push(new ExpandableDropdownOption(0,"${wiredchests.settings.appearance.state.0}"));
         _loc12_.push(new ExpandableDropdownOption(1,"${wiredchests.settings.appearance.state.1}"));
         _loc12_.push(new ExpandableDropdownOption(2,"${wiredchests.settings.appearance.state.2}"));
         _loc12_.push(new ExpandableDropdownOption(3,"${wiredchests.settings.appearance.state.3}"));
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc3_.push(new ExpandableDropdownOption(0,"${wiredchests.settings.appearance.preview.0}"));
         _loc3_.push(new ExpandableDropdownOption(1,"${wiredchests.settings.appearance.preview.1}"));
         _loc3_.push(new ExpandableDropdownOption(2,"${wiredchests.settings.appearance.preview.2}"));
         _loc3_.push(new ExpandableDropdownOption(3,"${wiredchests.settings.appearance.preview.3}"));
         _loc3_.push(new ExpandableDropdownOption(4,"${wiredchests.settings.appearance.preview.4}"));
         _loc3_.push(new ExpandableDropdownOption(5,"${wiredchests.settings.appearance.preview.5}"));
         _loc3_.push(new ExpandableDropdownOption(6,"${wiredchests.settings.appearance.preview.6}"));
         _loc3_.push(new ExpandableDropdownOption(7,"${wiredchests.settings.appearance.preview.7}"));
         var _loc5_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc5_.push(new ExpandableDropdownOption(1,"1"));
         _loc5_.push(new ExpandableDropdownOption(2,"2"));
         _loc5_.push(new ExpandableDropdownOption(3,"3"));
         _loc5_.push(new ExpandableDropdownOption(4,"4"));
         _chestState = param2.createDropdown(new DropdownParam("${wiredchests.settings.appearance.state}",_loc12_));
         var _loc4_:SectionPreset = param2.createSection("${wiredchests.settings.appearance.state}",_chestState);
         _loc4_.splitterVisible = false;
         _openStateDropdown = param2.createDropdown(new DropdownParam("${wiredchests.settings.appearance.preview}",_loc3_,onChangePreviewItems));
         UnknownVarFromChestSettingsUI_SectionPreset_1 = param2.createSection("${wiredchests.settings.appearance.preview}",param2.createSimpleListView(true,[_openStateDropdown,param2.createText("${wiredchests.settings.appearance.preview.note}").halfBlend()]));
         _amountPreviewDropdown = param2.createDropdown(new DropdownParam("${wiredchests.settings.appearance.preview_amount}",_loc5_));
         UnknownVarFromChestSettingsUI_SectionPreset_2 = param2.createSection("${wiredchests.settings.appearance.preview_amount}",_amountPreviewDropdown);
         var _loc18_:SimpleListViewPreset = param2.createSimpleListView(true,[_loc4_,UnknownVarFromChestSettingsUI_SectionPreset_1,UnknownVarFromChestSettingsUI_SectionPreset_2]);
         _loc18_.spacing = _loc13_.sectionSpacing;
         var _loc15_:BorderSection = param2.createBorderSection("${wiredchests.settings.appearance}",_loc18_);
         var _loc20_:SimpleListViewPreset = param2.createSimpleListView(false,[param2.createBitmapWrapperPreset("${image.library.url}catalogue/icon_80.png"),param2.createText("${wiredchests.settings.wired.upgrade}",new TextParam(0))],true);
         UnknownVarFromChestSettingsUI_ContainerButtonPreset_1 = param2.createContainerButtonPreset(_loc20_.alignCenter(),onClickUpgrade,false);
         UnknownVarFromChestSettingsUI_StaticBitmapAssetWrapperPreset_1 = param2.createBitmapWrapperPreset("icon_checkmark_small");
         UnknownVarFromChestSettingsUI_SimpleListViewPreset_1 = param2.createSimpleListView(false,[UnknownVarFromChestSettingsUI_ContainerButtonPreset_1,UnknownVarFromChestSettingsUI_StaticBitmapAssetWrapperPreset_1],true);
         var _loc10_:BorderSection = param2.createBorderSection("${wiredchests.settings.wired}",UnknownVarFromChestSettingsUI_SimpleListViewPreset_1);
         var _loc7_:int = 420;
         var _loc11_:int = Capabilities.screenResolutionY / 2.4;
         var _loc19_:ListScrollParams = new ListScrollParams(false,_loc7_,_loc11_,true);
         framePreset = param2.createFramePreset([_loc8_,_loc17_,_loc15_,_loc10_,footerPreset],onCloseClicked,null,-1,false,false,_loc19_);
         framePreset.resizeToWidth(300);
      }
      
      private function onUpdateSuccess(param1:ChestPreferencesUpdateSuccessMessageEvent) : void
      {
         if(param1.getParser().chestId == _chestId && !param1.getParser().isNotificationPreferences)
         {
            hideFrame();
         }
      }
      
      override protected function hideFrame() : void
      {
         super.hideFrame();
         if(UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1 != null)
         {
            UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1.hide();
         }
      }
      
      private function onClickUpgrade() : void
      {
         if(UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1 == null)
         {
            UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1 = new WiredChestWiredUpdateConfirmationView(this);
         }
         UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1.initialize(_chestId,_chestType,_chestItemType,UnknownVarFromChestSettingsUI_Boolean_1);
         UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1.show();
      }
      
      internal function confirmUpgrade() : void
      {
         UnknownVarFromChestSettingsUI_ContainerButtonPreset_1.disabled = true;
         UnknownVarFromChestSettingsUI_StaticBitmapAssetWrapperPreset_1.visible = true;
         onSaveClicked();
      }
      
      private function onChangePreviewItems(param1:ExpandableDropdownOption) : void
      {
         UnknownVarFromChestSettingsUI_SectionPreset_2.disabled = param1.id == 0;
      }
      
      public function set chestType(param1:int) : void
      {
         _chestType = param1;
         UnknownVarFromChestSettingsUI_SectionPreset_1.visible = _chestType == UnknownHabboRoomeventsWired_TradingChests1.TYPE_FURNI;
         UnknownVarFromChestSettingsUI_SectionPreset_2.visible = _chestType == UnknownHabboRoomeventsWired_TradingChests1.TYPE_FURNI;
         var _loc2_:String = localization.getLocalization("wiredchests." + (param1 == UnknownHabboRoomeventsWired_TradingChests1.TYPE_FURNI ? "furni" : "coin") + "_chest");
         framePreset.title = localization.getLocalizationWithParams("wiredchests.settings.title","","chest_type",_loc2_);
      }
      
      public function onEdit(param1:int, param2:int, param3:int, param4:Boolean, param5:Map) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         chestType = param2;
         _chestId = param1;
         _chestItemType = param3;
         UnknownVarFromChestSettingsUI_Boolean_1 = param4;
         var _loc6_:String = param5.getValue("chest_name");
         var _loc10_:String = param5.getValue("chest_desc");
         var _loc7_:* = param5.getValue("everyone_can_open") == "1";
         var _loc13_:* = param5.getValue("everyone_can_donate") == "1";
         var _loc11_:int = param5.getValue("state_control_mode");
         var _loc12_:* = param5.getValue("is_wired_enabled") == "1";
         if(param2 == UnknownHabboRoomeventsWired_TradingChests1.TYPE_FURNI)
         {
            _loc8_ = param5.getValue("preview_mode");
            _loc9_ = param5.getValue("preview_amount");
         }
         UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1.get(0).selected = _loc7_;
         UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1.get(1).selected = _loc13_;
         _chestName.text = _loc6_;
         _chestDesc.text = _loc10_;
         _chestState.selectedId = _loc11_;
         UnknownVarFromChestSettingsUI_ContainerButtonPreset_1.disabled = _loc12_;
         UnknownVarFromChestSettingsUI_StaticBitmapAssetWrapperPreset_1.visible = _loc12_;
         if(param2 == UnknownHabboRoomeventsWired_TradingChests1.TYPE_FURNI)
         {
            _openStateDropdown.selectedId = _loc8_;
            _amountPreviewDropdown.selectedId = _loc9_;
            UnknownVarFromChestSettingsUI_SectionPreset_2.disabled = _loc8_ == 0;
         }
         showFrame();
      }
      
      override public function onSaveClicked() : void
      {
         _chestController.send(new SetChestPreferencesMessageComposer(_chestId,_chestName.text,_chestDesc.text,UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1.get(0).selected,UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1.get(1).selected,_chestState.selectedId,_openStateDropdown.selectedId,_amountPreviewDropdown.selectedId,UnknownVarFromChestSettingsUI_ContainerButtonPreset_1.disabled));
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
         if(UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1 != null)
         {
            UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1.dispose();
            UnknownVarFromChestSettingsUI_WiredChestWiredUpdateConfirmationView_1 = null;
         }
         _chestController.removeMessageEvent(UnknownVarFromChestSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1);
         UnknownVarFromChestSettingsUI_ChestPreferencesUpdateSuccessMessageEvent_1 = null;
         UnknownVarFromChestSettingsUI_CheckboxGroupPreset_1 = null;
         _chestName = null;
         _chestDesc = null;
         _chestState = null;
         UnknownVarFromChestSettingsUI_SectionPreset_1 = null;
         _openStateDropdown = null;
         UnknownVarFromChestSettingsUI_SectionPreset_2 = null;
         _amountPreviewDropdown = null;
         UnknownVarFromChestSettingsUI_ContainerButtonPreset_1 = null;
         UnknownVarFromChestSettingsUI_StaticBitmapAssetWrapperPreset_1 = null;
         _chestController = null;
         _chestType = 0;
         _chestId = -1;
         super.dispose();
      }
   }
}

