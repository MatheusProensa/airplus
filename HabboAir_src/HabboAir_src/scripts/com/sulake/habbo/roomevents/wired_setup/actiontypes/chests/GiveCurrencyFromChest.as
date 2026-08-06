package com.sulake.habbo.roomevents.wired_setup.actiontypes.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionTypeCodes;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GiveCurrencyFromChest extends AbstractGiveFromChest
   {
      private var UnknownVarFromGiveCurrencyFromChest_DropdownPreset_1:DropdownPreset;
      
      private var UnknownVarFromGiveCurrencyFromChest_SectionPreset_1:SectionPreset;
      
      public function GiveCurrencyFromChest()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.GIVE_CURRENCY_FROM_CHEST;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = super.readIntParamsFromForm();
         _loc1_.push(UnknownVarFromGiveCurrencyFromChest_DropdownPreset_1.selectedId);
         return _loc1_;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc2_:int = int(param1.intParams[5]);
         UnknownVarFromGiveCurrencyFromChest_DropdownPreset_1.selectedId = _loc2_;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:Vector.<ExpandableDropdownOption> = new <ExpandableDropdownOption>[new ExpandableDropdownOption(11,"${wiredfurni.params.earnings_category.11}"),new ExpandableDropdownOption(13,"${wiredfurni.params.earnings_category.13}")];
         UnknownVarFromGiveCurrencyFromChest_DropdownPreset_1 = param1.createDropdown(new DropdownParam("${wiredfurni.params.earnings_category}",_loc4_));
         UnknownVarFromGiveCurrencyFromChest_SectionPreset_1 = param1.createSection("${wiredfurni.params.earnings_category}",UnknownVarFromGiveCurrencyFromChest_DropdownPreset_1,SectionParam.COLLAPSED);
         super.buildInputs(param1,param2,param3);
      }
      
      override protected function finalizeBuilding(param1:WiredUIBuilder) : void
      {
         super.finalizeBuilding(param1);
         param1.addElements(UnknownVarFromGiveCurrencyFromChest_SectionPreset_1);
      }
   }
}

