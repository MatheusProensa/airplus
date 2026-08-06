package com.sulake.habbo.roomevents.wired_setup.actiontypes.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionTypeCodes;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GiveItemsFromChest extends AbstractGiveFromChest
   {
      private var UnknownVarFromGiveItemsFromChest_SectionPreset_1:SectionPreset;
      
      private var _iterationModeRadioGroup:RadioGroupPreset;
      
      public function GiveItemsFromChest()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.GIVE_FURNI_FROM_CHEST;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = super.readIntParamsFromForm();
         _loc1_.push(_iterationModeRadioGroup.selected);
         return _loc1_;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc2_:int = int(param1.intParams[5]);
         _iterationModeRadioGroup.selected = _loc2_;
         UnknownVarFromGiveItemsFromChest_SectionPreset_1.disabled = rewardingMode == 1;
      }
      
      override protected function onModeChange(param1:int) : void
      {
         super.onModeChange(param1);
         UnknownVarFromGiveItemsFromChest_SectionPreset_1.disabled = param1 == 1;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:Array = [new RadioButtonParam(0,l("chest_iteration_type.0")),new RadioButtonParam(1,l("chest_iteration_type.1")),new RadioButtonParam(2,l("chest_iteration_type.2"))];
         _iterationModeRadioGroup = param1.createRadioGroup(_loc4_);
         UnknownVarFromGiveItemsFromChest_SectionPreset_1 = param1.createSection(l("chest_iteration_type"),_iterationModeRadioGroup,SectionParam.COLLAPSED);
         super.buildInputs(param1,param2,param3);
      }
      
      override protected function finalizeBuilding(param1:WiredUIBuilder) : void
      {
         super.finalizeBuilding(param1);
         param1.addElements(UnknownVarFromGiveItemsFromChest_SectionPreset_1);
      }
   }
}

