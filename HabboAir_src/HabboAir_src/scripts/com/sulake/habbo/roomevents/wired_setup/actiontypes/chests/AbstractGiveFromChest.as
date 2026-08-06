package com.sulake.habbo.roomevents.wired_setup.actiontypes.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.*;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AbstractGiveFromChest extends DefaultActionType
   {
      protected static const MODE_AMOUNT:int = 0;
      
      protected static const MODE_ALL:int = 1;
      
      private var UnknownVarFromAbstractGiveFromChest_SectionPreset_1:SectionPreset;
      
      private var UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1:ValueOrVariableSection;
      
      private var UnknownVarFromAbstractGiveFromChest_SectionPreset_2:SectionPreset;
      
      private var _rewardingModeRadioGroup:RadioGroupPreset;
      
      private var UnknownVarFromAbstractGiveFromChest_TextAreaPreset_1:TextAreaPreset;
      
      private var _showByDefault:CheckboxGroupPreset;
      
      public function AbstractGiveFromChest()
      {
         super();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_rewardingModeRadioGroup.selected);
         _loc1_.push(UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.numberValue);
         _loc1_.push(UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.option);
         _loc1_.push(UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.target);
         _loc1_.push(_showByDefault.get(0).selected);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.finalizeSelection];
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromAbstractGiveFromChest_TextAreaPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc5_:Array = param1.intParams;
         var _loc7_:String = param1.variableIds[0];
         var _loc2_:int = int(_loc5_[0]);
         _rewardingModeRadioGroup.selected = _loc2_;
         var _loc4_:int = int(_loc5_[1]);
         var _loc3_:int = int(_loc5_[2]);
         var _loc6_:int = int(_loc5_[3]);
         if(_loc2_ == 0)
         {
            if(_loc3_ == 0)
            {
               _loc7_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
            }
            else
            {
               _loc4_ = 1;
            }
         }
         else
         {
            _loc7_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
            _loc4_ = 1;
         }
         UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.disabled = _loc2_ == 1;
         UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc7_,_loc6_,_loc3_,_loc4_);
         _showByDefault.get(0).selected = param1.getBoolean(4);
         UnknownVarFromAbstractGiveFromChest_TextAreaPreset_1.text = param1.stringParam;
      }
      
      protected function get rewardingMode() : int
      {
         return _rewardingModeRadioGroup.selected;
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.onEditInitialized();
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 0)
         {
            return UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.isSourcePickingDisabled() || UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.disabled;
         }
         return false;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:Array = [new RadioButtonParam(0,l("rewarding_mode.0")),new RadioButtonParam(1,l("rewarding_mode.1"))];
         _rewardingModeRadioGroup = param1.createRadioGroup(_loc4_,onModeChange);
         UnknownVarFromAbstractGiveFromChest_SectionPreset_1 = param1.createSection(l("rewarding_mode"),_rewardingModeRadioGroup);
         UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),l("amount_to_give"),1,2147483647);
         UnknownVarFromAbstractGiveFromChest_TextAreaPreset_1 = param1.createTextArea(new TextAreaParam(45,-1,3,-1,200,"","${wiredfurni.reward_contract.reward_popup.text.tooltip}"));
         _showByDefault = param1.createCheckboxGroup([new CheckboxOptionParam("${wiredfurni.reward_contract.reward_popup.show_by_default}")]);
         var _loc5_:SimpleListViewPreset = param1.createSimpleListView(true,[UnknownVarFromAbstractGiveFromChest_TextAreaPreset_1,_showByDefault]);
         UnknownVarFromAbstractGiveFromChest_SectionPreset_2 = param1.createSection("${wiredfurni.reward_contract.reward_popup}",_loc5_);
         finalizeBuilding(param3);
      }
      
      protected function finalizeBuilding(param1:WiredUIBuilder) : void
      {
         param1.addElements(UnknownVarFromAbstractGiveFromChest_SectionPreset_1,UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1,UnknownVarFromAbstractGiveFromChest_SectionPreset_2);
      }
      
      protected function onModeChange(param1:int) : void
      {
         UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.disabled = param1 == 1;
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.chests";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.reward_user";
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
      
      override public function mergedSelections() : Array
      {
         return [[1,1]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromAbstractGiveFromChest_ValueOrVariableSection_1.target;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

