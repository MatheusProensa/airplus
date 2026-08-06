package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GiveVariable extends DefaultActionType
   {
      private var _picker:VariablePickerPreset;
      
      private var _overrideVariable:CheckboxOptionPreset;
      
      private var UnknownVarFromGiveVariable_NamedNumberInputPreset_1:NamedNumberInputPreset;
      
      private var _section1:SectionPreset;
      
      private var _section2:SectionPreset;
      
      private var _mergedType:int = 0;
      
      public function GiveVariable()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canCreateAndDelete;
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.GIVE_VARIABLE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_mergedType);
         Util.pushIntAsLong(_loc1_,UnknownVarFromGiveVariable_NamedNumberInputPreset_1.value);
         _loc1_.push(_overrideVariable.selected ? 1 : 0);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_picker.finalizeSelection];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:String = param1.variableIds[0];
         _mergedType = param1.intParams[0];
         var _loc3_:int = int(param1.intParams[2]);
         var _loc4_:* = param1.intParams[3] != 0;
         _picker.init(param1.wiredContext.roomVariablesList,_loc2_,_mergedType);
         var _loc5_:WiredVariable = _picker.selected;
         var _loc6_:Boolean = _loc5_ != null && _loc5_.canWriteValue;
         if(!_loc6_)
         {
            _loc3_ = 0;
         }
         onVariableSelected(_loc5_);
         _overrideVariable.selected = _loc4_;
         UnknownVarFromGiveVariable_NamedNumberInputPreset_1.value = _loc3_;
      }
      
      override public function onEditInitialized() : void
      {
         _section1.getSourceTypeSelector().select(_mergedType);
      }
      
      private function onVariableSelected(param1:WiredVariable) : void
      {
         _section2.disabled = param1 == null || !param1.hasValue;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:SourceTypeSelectorParam = new SourceTypeSelectorParam(mergedSourceOptions(0),createSourceTypeListener(0));
         _picker = param1.createVariablePicker(variableSelectionFilter,onVariableSelected);
         _overrideVariable = param1.createCheckboxOption(new CheckboxOptionParam(l("variables.value_settings.override_existing")));
         var _loc6_:SimpleListViewPreset = param1.createSimpleListView(true,[_picker,_overrideVariable]);
         var _loc4_:SectionParam = new SectionParam(_loc5_);
         _section1 = param1.createSection(l("variables.variable_selection"),_loc6_,_loc4_);
         UnknownVarFromGiveVariable_NamedNumberInputPreset_1 = param1.createNamedNumberInput(new NumberInputParam(0,-2147483648,2147483647),l("variables.value_settings.initial_value"));
         _section2 = param1.createSection(l("variables.value_settings"),UnknownVarFromGiveVariable_NamedNumberInputPreset_1);
         param3.addElements(_section1,_section2);
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_destination";
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
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return _mergedType;
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

