package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SetClickSettings extends DefaultActionType
   {
      private var UnknownVarFromSetClickSettings_DropdownPreset_1:DropdownPreset;
      
      private var UnknownVarFromSetClickSettings_DropdownPreset_2:DropdownPreset;
      
      public function SetClickSettings()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.UnknownVarFromActionTypeCodes_Int_5;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromSetClickSettings_DropdownPreset_1.selectedId);
         _loc1_.push(UnknownVarFromSetClickSettings_DropdownPreset_2.selectedId);
         return _loc1_;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromSetClickSettings_DropdownPreset_1.selectedId = param1.getInt(0);
         UnknownVarFromSetClickSettings_DropdownPreset_2.selectedId = param1.getInt(1);
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc4_.push(new ExpandableDropdownOption(0,"${wiredfurni.params.click_settings.user.0}"));
         _loc4_.push(new ExpandableDropdownOption(1,"${wiredfurni.params.click_settings.user.1}"));
         _loc4_.push(new ExpandableDropdownOption(2,"${wiredfurni.params.click_settings.user.2}"));
         UnknownVarFromSetClickSettings_DropdownPreset_1 = param1.createDropdown(new DropdownParam("${wiredfurni.params.click_settings.user}",_loc4_));
         var _loc5_:SectionPreset = param1.createSection("${wiredfurni.params.click_settings.user}",UnknownVarFromSetClickSettings_DropdownPreset_1);
         _loc4_ = new Vector.<ExpandableDropdownOption>();
         _loc4_.push(new ExpandableDropdownOption(0,"${wiredfurni.params.click_settings.furni.0}"));
         _loc4_.push(new ExpandableDropdownOption(1,"${wiredfurni.params.click_settings.furni.1}"));
         UnknownVarFromSetClickSettings_DropdownPreset_2 = param1.createDropdown(new DropdownParam("${wiredfurni.params.click_settings.furni}",_loc4_));
         var _loc6_:SectionPreset = param1.createSection("${wiredfurni.params.click_settings.furni}",UnknownVarFromSetClickSettings_DropdownPreset_2);
         param3.addElements(_loc5_,_loc6_);
      }
   }
}

