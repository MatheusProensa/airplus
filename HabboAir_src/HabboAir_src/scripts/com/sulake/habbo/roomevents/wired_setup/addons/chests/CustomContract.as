package com.sulake.habbo.roomevents.wired_setup.addons.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.*;
   import com.sulake.habbo.roomevents.wired_setup.addons.AddonCodes;
   import com.sulake.habbo.roomevents.wired_setup.addons.DefaultAddonType;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WindowWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageWarningSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CustomContract extends DefaultAddonType
   {
      private var UnknownVarFromCustomContract_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var UnknownVarFromCustomContract_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromCustomContract_ValueOrVariableSection_1:ValueOrVariableSection;
      
      private var UnknownVarFromCustomContract_CheckboxGroupPreset_2:CheckboxGroupPreset;
      
      private var UnknownVarFromCustomContract_RadioGroupPreset_2:RadioGroupPreset;
      
      private var UnknownVarFromCustomContract_ValueOrVariableSection_2:ValueOrVariableSection;
      
      public function CustomContract()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.CUSTOM_CONTRACT;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromCustomContract_CheckboxGroupPreset_1.get(0).selected,UnknownVarFromCustomContract_RadioGroupPreset_1.selected,UnknownVarFromCustomContract_ValueOrVariableSection_1.option,UnknownVarFromCustomContract_ValueOrVariableSection_1.numberValue,UnknownVarFromCustomContract_ValueOrVariableSection_1.target,UnknownVarFromCustomContract_CheckboxGroupPreset_2.get(0).selected,UnknownVarFromCustomContract_RadioGroupPreset_2.selected,UnknownVarFromCustomContract_ValueOrVariableSection_2.option,UnknownVarFromCustomContract_ValueOrVariableSection_2.numberValue,UnknownVarFromCustomContract_ValueOrVariableSection_2.target];
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromCustomContract_ValueOrVariableSection_1.finalizeSelection,UnknownVarFromCustomContract_ValueOrVariableSection_2.finalizeSelection];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:String = param1.variableIds[0];
         var _loc4_:Boolean = param1.getBoolean(0);
         var _loc13_:int = param1.getInt(1);
         var _loc12_:int = param1.getInt(2);
         var _loc5_:int = param1.getInt(3);
         var _loc11_:int = param1.getInt(4);
         if(_loc4_)
         {
            if(_loc12_ == 0)
            {
               _loc2_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
            }
            else
            {
               _loc5_ = 1;
            }
         }
         else
         {
            _loc2_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
            _loc5_ = 1;
         }
         UnknownVarFromCustomContract_CheckboxGroupPreset_1.get(0).selected = _loc4_;
         UnknownVarFromCustomContract_RadioGroupPreset_1.selected = _loc13_;
         UnknownVarFromCustomContract_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc2_,_loc11_,_loc12_,_loc5_);
         var _loc8_:String = param1.variableIds[1];
         var _loc9_:Boolean = param1.getBoolean(5);
         var _loc3_:int = param1.getInt(6);
         var _loc7_:int = param1.getInt(7);
         var _loc10_:int = param1.getInt(8);
         var _loc6_:int = param1.getInt(9);
         if(_loc9_)
         {
            if(_loc7_ == 0)
            {
               _loc8_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
            }
            else
            {
               _loc10_ = 1;
            }
         }
         else
         {
            _loc8_ = WiredVariable.UnknownVarFromWiredVariable_String_1;
            _loc10_ = 1;
         }
         UnknownVarFromCustomContract_CheckboxGroupPreset_2.get(0).selected = _loc9_;
         UnknownVarFromCustomContract_RadioGroupPreset_2.selected = _loc3_;
         UnknownVarFromCustomContract_ValueOrVariableSection_2.init(param1.wiredContext.roomVariablesList,_loc8_,_loc6_,_loc7_,_loc10_);
         onPaymentSelectedChanged(0,_loc4_);
         onRewardSelectedChanged(0,_loc9_);
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc8_:UsageWarningSection = param1.createUsageWarningSection("${wiredfurni.params.custom_contract.usage_warning}");
         UnknownVarFromCustomContract_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.custom_contract.element_type_selection.0}"),new RadioButtonParam(1,"${wiredfurni.params.custom_contract.element_type_selection.1}")],onPaymentTypeChanged,2);
         var _loc9_:SectionPreset = param1.createSection("${wiredfurni.params.custom_contract.element_type_selection}",UnknownVarFromCustomContract_RadioGroupPreset_1);
         UnknownVarFromCustomContract_ValueOrVariableSection_1 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),"${wiredfurni.params.custom_contract.amount_selection}",1,100000);
         var _loc5_:SimpleListViewPreset = param1.createSimpleListView(true,[_loc9_,param1.createSpacer(param2.sectionSpacing),UnknownVarFromCustomContract_ValueOrVariableSection_1]);
         _loc5_.spacing = 0;
         var _loc7_:CheckboxOptionParam = new CheckboxOptionParam("${wiredfurni.params.custom_contract.enable_payment}");
         _loc7_.extra2 = _loc5_;
         UnknownVarFromCustomContract_CheckboxGroupPreset_1 = param1.createCheckboxGroup([_loc7_],onPaymentSelectedChanged);
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.custom_contract.payment}",UnknownVarFromCustomContract_CheckboxGroupPreset_1,SectionParam.COLLAPSED);
         UnknownVarFromCustomContract_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.custom_contract.element_type_selection.0}"),new RadioButtonParam(1,"${wiredfurni.params.custom_contract.element_type_selection.1}")],onRewardTypeChanged,2);
         var _loc6_:SectionPreset = param1.createSection("${wiredfurni.params.custom_contract.element_type_selection}",UnknownVarFromCustomContract_RadioGroupPreset_2);
         UnknownVarFromCustomContract_ValueOrVariableSection_2 = param1.createValueOrVariableSection(1,mergedSourceOptions(1),"${wiredfurni.params.custom_contract.amount_selection}",1,100000);
         var _loc10_:SimpleListViewPreset = param1.createSimpleListView(true,[_loc6_,param1.createSpacer(param2.sectionSpacing),UnknownVarFromCustomContract_ValueOrVariableSection_2]);
         _loc10_.spacing = 0;
         var _loc11_:CheckboxOptionParam = new CheckboxOptionParam("${wiredfurni.params.custom_contract.enable_reward}");
         _loc11_.extra2 = _loc10_;
         UnknownVarFromCustomContract_CheckboxGroupPreset_2 = param1.createCheckboxGroup([_loc11_],onRewardSelectedChanged);
         var _loc12_:SectionPreset = param1.createSection("${wiredfurni.params.custom_contract.reward}",UnknownVarFromCustomContract_CheckboxGroupPreset_2,SectionParam.COLLAPSED);
         param3.addElements(_loc8_,_loc4_,_loc12_,new WindowWrapperPreset(roomEvents,param1,param2,param2.createSplitterView(),false));
      }
      
      override public function get widthModifier() : Number
      {
         return 1.2;
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromCustomContract_ValueOrVariableSection_1.onEditInitialized();
         UnknownVarFromCustomContract_ValueOrVariableSection_2.onEditInitialized();
      }
      
      private function onPaymentSelectedChanged(param1:int, param2:Boolean) : void
      {
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,0);
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      private function onRewardSelectedChanged(param1:int, param2:Boolean) : void
      {
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,1);
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,1);
      }
      
      private function onPaymentTypeChanged(param1:int) : void
      {
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,0);
      }
      
      private function onRewardTypeChanged(param1:int) : void
      {
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,1);
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 0)
         {
            return !UnknownVarFromCustomContract_CheckboxGroupPreset_1.get(0).selected || UnknownVarFromCustomContract_ValueOrVariableSection_1.isSourcePickingDisabled();
         }
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 1)
         {
            return !UnknownVarFromCustomContract_CheckboxGroupPreset_2.get(0).selected || UnknownVarFromCustomContract_ValueOrVariableSection_2.isSourcePickingDisabled();
         }
         if(param2 == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1 && param1 == 0)
         {
            return !UnknownVarFromCustomContract_CheckboxGroupPreset_1.get(0).selected || UnknownVarFromCustomContract_RadioGroupPreset_1.selected != TradeRequirementNode.TYPE_FURNI;
         }
         if(param2 == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1 && param1 == 1)
         {
            return !UnknownVarFromCustomContract_CheckboxGroupPreset_2.get(0).selected || UnknownVarFromCustomContract_RadioGroupPreset_2.selected != TradeRequirementNode.TYPE_FURNI;
         }
         return false;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.merged.title.variables_reference_payment";
         }
         return "wiredfurni.params.sources.merged.title.variables_reference_reward";
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.furni.title.payment";
         }
         return "wiredfurni.params.sources.furni.title.reward";
      }
      
      override public function mergedSelections() : Array
      {
         return [[2,0],[3,1]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            UnknownVarFromCustomContract_ValueOrVariableSection_1.target = param2;
         }
         else
         {
            UnknownVarFromCustomContract_ValueOrVariableSection_2.target = param2;
         }
      }
      
      override public function getMergedType(param1:int) : int
      {
         if(param1 == 0)
         {
            return UnknownVarFromCustomContract_ValueOrVariableSection_1.target;
         }
         return UnknownVarFromCustomContract_ValueOrVariableSection_2.target;
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
   }
}

