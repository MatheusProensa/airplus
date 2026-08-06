package com.sulake.habbo.roomevents.wired_setup.actiontypes.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.*;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class InitiateTransaction extends DefaultActionType
   {
      private var _transactionMode:RadioGroupPreset;
      
      private var UnknownVarFromInitiateTransaction_ValueOrVariableSection_1:ValueOrVariableSection;
      
      private var UnknownVarFromInitiateTransaction_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var UnknownVarFromInitiateTransaction_NamedNumberInputPreset_1:NamedNumberInputPreset;
      
      public function InitiateTransaction()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.INITIATE_TRANSACTION;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [_transactionMode.selected,UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.numberValue,UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.option,UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.target,UnknownVarFromInitiateTransaction_CheckboxGroupPreset_1.get(0).selected ? 1 : 0,UnknownVarFromInitiateTransaction_NamedNumberInputPreset_1.value];
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.finalizeSelection];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc6_:String = param1.variableIds[0];
         var _loc2_:int = param1.getInt(0);
         _transactionMode.selected = _loc2_;
         var _loc4_:int = param1.getInt(1);
         var _loc3_:int = param1.getInt(2);
         var _loc5_:int = param1.getInt(3);
         if(_loc3_ == 0)
         {
            _loc6_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
         }
         else
         {
            _loc4_ = 1;
         }
         UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc6_,_loc5_,_loc3_,_loc4_);
         UnknownVarFromInitiateTransaction_CheckboxGroupPreset_1.get(0).selected = param1.getBoolean(4);
         UnknownVarFromInitiateTransaction_NamedNumberInputPreset_1.value = param1.getInt(5);
         onModeChange(_loc2_);
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _transactionMode = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.contract.mode.0}"),new RadioButtonParam(1,"${wiredfurni.params.contract.mode.1}"),new RadioButtonParam(2,"${wiredfurni.params.contract.mode.2}")],onModeChange);
         var _loc5_:SectionPreset = param1.createSection("${wiredfurni.params.contract.mode}",_transactionMode);
         UnknownVarFromInitiateTransaction_ValueOrVariableSection_1 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),"${wiredfurni.params.contract.multiplier_selection}",1,500);
         UnknownVarFromInitiateTransaction_NamedNumberInputPreset_1 = param1.createNamedNumberInput(new NumberInputParam(300,30,3600),"${wiredfurni.params.contract.timeout.selection}");
         var _loc4_:CheckboxOptionParam = new CheckboxOptionParam("${wiredfurni.params.contract.timeout.desc}");
         _loc4_.extra2 = UnknownVarFromInitiateTransaction_NamedNumberInputPreset_1;
         UnknownVarFromInitiateTransaction_CheckboxGroupPreset_1 = param1.createCheckboxGroup([_loc4_]);
         var _loc6_:SectionPreset = param1.createSection("${wiredfurni.params.contract.timeout}",UnknownVarFromInitiateTransaction_CheckboxGroupPreset_1);
         param3.addElements(_loc5_,UnknownVarFromInitiateTransaction_ValueOrVariableSection_1,_loc6_);
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.onEditInitialized();
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 0)
         {
            return UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.isSourcePickingDisabled();
         }
         return false;
      }
      
      private function onModeChange(param1:int) : void
      {
         var _loc3_:* = param1 == UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1.UnknownVarFromUnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1_Int_3;
         var _loc2_:* = param1 == UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1.UnknownVarFromUnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1_Int_1;
         UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.sectionTitle = _loc3_ ? "${wiredfurni.params.contract.multiplier_selection2}" : "${wiredfurni.params.contract.multiplier_selection}";
         UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.disabled = _loc2_;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.furni.title.chests";
         }
         return "wiredfurni.params.sources.furni.title.contracts";
      }
      
      override public function mergedSelections() : Array
      {
         return [[2,1]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromInitiateTransaction_ValueOrVariableSection_1.target;
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

