package com.sulake.habbo.roomevents.wired_setup.conditions.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.conditions.ConditionCodes;
   import com.sulake.habbo.roomevents.wired_setup.conditions.DefaultConditionType;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ChestHasAmount extends DefaultConditionType
   {
      protected var UnknownVarFromChestHasAmount_SectionPreset_1:SectionPreset;
      
      protected var UnknownVarFromChestHasAmount_ValueOrVariableSection_1:ValueOrVariableSection;
      
      private var _compareRadioGroup:RadioGroupPreset;
      
      public function ChestHasAmount()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.CHEST_HAS_ITEMS;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromChestHasAmount_ValueOrVariableSection_1.numberValue);
         _loc1_.push(UnknownVarFromChestHasAmount_ValueOrVariableSection_1.option);
         _loc1_.push(UnknownVarFromChestHasAmount_ValueOrVariableSection_1.target);
         _loc1_.push(_compareRadioGroup.selected);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromChestHasAmount_ValueOrVariableSection_1.finalizeSelection];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc5_:Array = param1.intParams;
         var _loc7_:String = param1.variableIds[0];
         var _loc3_:int = int(_loc5_[0]);
         var _loc2_:int = int(_loc5_[1]);
         var _loc6_:int = int(_loc5_[2]);
         if(_loc2_ == 0)
         {
            _loc7_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
         }
         else
         {
            _loc3_ = 1;
         }
         UnknownVarFromChestHasAmount_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc7_,_loc6_,_loc2_,_loc3_);
         var _loc4_:int = int(_loc5_[3]);
         _compareRadioGroup.selected = _loc4_;
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromChestHasAmount_ValueOrVariableSection_1.onEditInitialized();
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 0)
         {
            return UnknownVarFromChestHasAmount_ValueOrVariableSection_1.isSourcePickingDisabled();
         }
         return false;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _compareRadioGroup = param1.createRadioGroup([new RadioButtonParam(2,">"),new RadioButtonParam(5,"≥"),new RadioButtonParam(1,"="),new RadioButtonParam(3,"≤"),new RadioButtonParam(0,"<"),new RadioButtonParam(4,"≠")],null,6);
         UnknownVarFromChestHasAmount_SectionPreset_1 = param1.createSection(l("comparison_selection"),_compareRadioGroup);
         UnknownVarFromChestHasAmount_ValueOrVariableSection_1 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),l("chest_compare_amount"),0,1000000);
         param3.addElements(UnknownVarFromChestHasAmount_SectionPreset_1,UnknownVarFromChestHasAmount_ValueOrVariableSection_1);
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.chests";
      }
      
      override public function mergedSelections() : Array
      {
         return [[1,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromChestHasAmount_ValueOrVariableSection_1.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromChestHasAmount_ValueOrVariableSection_1.target;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
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

