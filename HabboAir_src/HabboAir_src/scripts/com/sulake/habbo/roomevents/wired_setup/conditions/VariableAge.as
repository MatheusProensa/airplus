package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SpacingPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VariableAge extends DefaultConditionType
   {
      private var _section1:SectionPreset;
      
      private var _picker:VariablePickerPreset;
      
      private var UnknownVarFromVariableAge_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromVariableAge_RadioGroupPreset_2:RadioGroupPreset;
      
      private var UnknownVarFromVariableAge_NamedNumberInputPreset_1:NamedNumberInputPreset;
      
      private var _timeUnit:DropdownPreset;
      
      private var _mergedType:int = 0;
      
      public function VariableAge()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canReadCreationTime || param1.canReadLastUpdateTime;
      }
      
      override public function get code() : int
      {
         return ConditionCodes.VARIABLE_AGE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_mergedType);
         _loc1_.push(UnknownVarFromVariableAge_RadioGroupPreset_1.selected);
         _loc1_.push(UnknownVarFromVariableAge_RadioGroupPreset_2.selected);
         Util.pushIntAsLong(_loc1_,UnknownVarFromVariableAge_NamedNumberInputPreset_1.value);
         _loc1_.push(_timeUnit.selectedId);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_picker.finalizeSelection];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc3_:Array = param1.intParams;
         var _loc5_:String = param1.variableIds[0];
         _mergedType = _loc3_[0];
         _picker.init(param1.wiredContext.roomVariablesList,_loc5_,_mergedType);
         var _loc2_:int = int(_loc3_[1]);
         var _loc6_:int = int(_loc3_[2]);
         var _loc7_:int = int(_loc3_[4]);
         var _loc4_:int = int(_loc3_[5]);
         UnknownVarFromVariableAge_RadioGroupPreset_1.selected = _loc2_;
         UnknownVarFromVariableAge_RadioGroupPreset_2.selected = _loc6_;
         UnknownVarFromVariableAge_NamedNumberInputPreset_1.value = _loc7_;
         _timeUnit.selectedId = _loc4_;
         updateAgeOptions(_picker.selected);
      }
      
      override public function onEditInitialized() : void
      {
         _section1.getSourceTypeSelector().select(_mergedType);
      }
      
      private function updateAgeOptions(param1:WiredVariable) : void
      {
         UnknownVarFromVariableAge_RadioGroupPreset_2.setOptionDisabled(0,false);
         UnknownVarFromVariableAge_RadioGroupPreset_2.setOptionDisabled(1,false);
         if(param1 == null)
         {
            return;
         }
         if(!param1.canReadCreationTime)
         {
            UnknownVarFromVariableAge_RadioGroupPreset_2.setOptionDisabled(0,true);
         }
         else if(!param1.canReadLastUpdateTime)
         {
            UnknownVarFromVariableAge_RadioGroupPreset_2.setOptionDisabled(1,true);
         }
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc6_:SourceTypeSelectorParam = new SourceTypeSelectorParam(mergedSourceOptions(0),createSourceTypeListener(0));
         _picker = param1.createVariablePicker(variableSelectionFilter,updateAgeOptions);
         var _loc4_:SectionParam = new SectionParam(_loc6_);
         _section1 = param1.createSection(l("variables.variable_selection"),_picker,_loc4_);
         UnknownVarFromVariableAge_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,l("variables.compare_value.0")),new RadioButtonParam(1,l("variables.compare_value.1"))]);
         var _loc8_:SectionPreset = param1.createSection(l("variables.compare_value"),UnknownVarFromVariableAge_RadioGroupPreset_2);
         UnknownVarFromVariableAge_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(2,l("comparison.2"))]);
         var _loc9_:SectionPreset = param1.createSection(l("comparison_selection"),UnknownVarFromVariableAge_RadioGroupPreset_1);
         UnknownVarFromVariableAge_NamedNumberInputPreset_1 = param1.createNamedNumberInput(new NumberInputParam(0,-2147483648,2147483647),l("variables.duration"));
         _timeUnit = param1.createDropdown(new DropdownParam("",Vector.<ExpandableDropdownOption>([new ExpandableDropdownOption(0,l("variables.duration.0")),new ExpandableDropdownOption(1,l("variables.duration.1")),new ExpandableDropdownOption(2,l("variables.duration.2")),new ExpandableDropdownOption(3,l("variables.duration.3")),new ExpandableDropdownOption(4,l("variables.duration.4")),new ExpandableDropdownOption(5,l("variables.duration.5")),new ExpandableDropdownOption(6,l("variables.duration.6")),new ExpandableDropdownOption(7,l("variables.duration.7"))])));
         var _loc5_:SpacingPreset = param1.createSpacing(false,5);
         var _loc7_:SimpleListViewPreset = param1.createSimpleListView(false,[UnknownVarFromVariableAge_NamedNumberInputPreset_1,_loc5_,_timeUnit],true);
         var _loc10_:SectionPreset = param1.createSection(l("variables.time_selection"),_loc7_);
         param3.addElements(_section1,_loc8_,_loc9_,_loc10_);
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         _mergedType = param2;
         _picker.variableTarget = _mergedType;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return _mergedType;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

