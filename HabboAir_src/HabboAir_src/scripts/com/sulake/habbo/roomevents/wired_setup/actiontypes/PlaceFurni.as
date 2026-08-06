package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ChooseVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PlaceFurni extends DefaultActionType
   {
      private static const TARGET_LOCATION_SOURCE:int = 0;
      
      private static const TARGET_LOCATION_CUSTOM:int = 1;
      
      private static const TARGET_ALTITUDE_ON_TOP:int = 0;
      
      private static const TARGET_ALTITUDE_SOURCE:int = 1;
      
      private static const TARGET_ALTITUDE_CUSTOM:int = 2;
      
      private static const OFFSET_MIN:int = -64;
      
      private static const UnknownConstFromPlaceFurni_Int_1:int = 64;
      
      private var UnknownVarFromPlaceFurni_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromPlaceFurni_RadioGroupPreset_2:RadioGroupPreset;
      
      private var _offsetCheckboxes:CheckboxGroupPreset;
      
      private var UnknownVarFromPlaceFurni_NumberInputPreset_1:NumberInputPreset;
      
      private var UnknownVarFromPlaceFurni_NumberInputPreset_2:NumberInputPreset;
      
      private var UnknownVarFromPlaceFurni_NumberInputPreset_3:NumberInputPreset;
      
      private var UnknownVarFromPlaceFurni_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var UnknownVarFromPlaceFurni_SectionPreset_1:SectionPreset;
      
      private var UnknownVarFromPlaceFurni_ChooseVariableSection_1:ChooseVariableSection;
      
      private var UnknownVarFromPlaceFurni_ValueOrVariableSection_1:ValueOrVariableSection;
      
      private var UnknownVarFromPlaceFurni_Boolean_1:Boolean;
      
      public function PlaceFurni()
      {
         super();
      }
      
      private static function filterSpawnVariable(param1:WiredVariable) : Boolean
      {
         return param1.variableTarget == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.FURNI && param1.canCreateAndDelete && param1.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_1;
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.PLACE_FURNI;
      }
      
      override public function get hasStateSnapshot() : Boolean
      {
         return true;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.place_furni.usage_info}");
         var _loc5_:TextParam = new TextParam(1);
         _loc5_.textColor = param2.softTextColor;
         UnknownVarFromPlaceFurni_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.place_furni.target_location.0}",null,param1.createText("${wiredfurni.params.place_furni.target_location.0.info}",_loc5_)),new RadioButtonParam(1,"${wiredfurni.params.place_furni.target_location.1}")],onTargetLocationChange);
         UnknownVarFromPlaceFurni_RadioGroupPreset_1.selected = 0;
         var _loc7_:SectionPreset = param1.createSection("${wiredfurni.params.place_furni.target_location}",UnknownVarFromPlaceFurni_RadioGroupPreset_1,SectionParam.UnknownVarFromSectionParam_SectionParam_1);
         UnknownVarFromPlaceFurni_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.place_furni.target_altitude.0}"),new RadioButtonParam(1,"${wiredfurni.params.place_furni.target_altitude.1}"),new RadioButtonParam(2,"${wiredfurni.params.place_furni.target_altitude.2}")],onTargetAltitudeChange);
         UnknownVarFromPlaceFurni_RadioGroupPreset_2.selected = 0;
         var _loc8_:SectionPreset = param1.createSection("${wiredfurni.params.place_furni.target_altitude}",UnknownVarFromPlaceFurni_RadioGroupPreset_2,SectionParam.UnknownVarFromSectionParam_SectionParam_1);
         UnknownVarFromPlaceFurni_NumberInputPreset_1 = param1.createNumberInput(new NumberInputParam(0,-64,64));
         UnknownVarFromPlaceFurni_NumberInputPreset_2 = param1.createNumberInput(new NumberInputParam(0,-64,64));
         UnknownVarFromPlaceFurni_NumberInputPreset_3 = param1.createNumberInput(new NumberInputParam(0,-8000,8000));
         var _loc6_:Array = [new CheckboxOptionParam("${wiredfurni.params.place_furni.offsets.x}",0,UnknownVarFromPlaceFurni_NumberInputPreset_1),new CheckboxOptionParam("${wiredfurni.params.place_furni.offsets.y}",1,UnknownVarFromPlaceFurni_NumberInputPreset_2),new CheckboxOptionParam("${wiredfurni.params.place_furni.offsets.altitude}",2,UnknownVarFromPlaceFurni_NumberInputPreset_3)];
         _offsetCheckboxes = param1.createCheckboxGroup(_loc6_);
         var _loc10_:SectionPreset = param1.createSection("${wiredfurni.params.place_furni.offsets}",_offsetCheckboxes,SectionParam.COLLAPSED);
         UnknownVarFromPlaceFurni_ChooseVariableSection_1 = param1.createChooseVariableSection(-1,null,filterSpawnVariable,onSpawnVariableSelected);
         UnknownVarFromPlaceFurni_ValueOrVariableSection_1 = param1.createValueOrVariableSection(1,mergedSourceOptions(1),"${wiredfurni.params.place_furni.spawn_with_value}",-2147483648,2147483647);
         var _loc9_:SimpleListViewPreset = param1.createSimpleListView(true,[UnknownVarFromPlaceFurni_ChooseVariableSection_1,UnknownVarFromPlaceFurni_ValueOrVariableSection_1]);
         UnknownVarFromPlaceFurni_CheckboxGroupPreset_1 = param1.createCheckboxGroup([new CheckboxOptionParam("${wiredfurni.params.place_furni.spawn_with_variable}",0,null,_loc9_)],onSpawnWithVariableChanged);
         UnknownVarFromPlaceFurni_SectionPreset_1 = param1.createSection("${wiredfurni.params.place_furni.spawn_with_variable}",UnknownVarFromPlaceFurni_CheckboxGroupPreset_1,SectionParam.COLLAPSED);
         param3.addElements(_loc4_,_loc7_,_loc8_,_loc10_,UnknownVarFromPlaceFurni_SectionPreset_1);
         updateCustomReferenceSourceState();
         updateSpawnValueState();
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromPlaceFurni_Boolean_1 = param1.getBoolean(0);
         UnknownVarFromPlaceFurni_RadioGroupPreset_1.selected = param1.getInt(1);
         UnknownVarFromPlaceFurni_RadioGroupPreset_2.selected = param1.getInt(2);
         updateOffsetField(UnknownVarFromPlaceFurni_NumberInputPreset_1,_offsetCheckboxes,0,param1.getInt(3));
         updateOffsetField(UnknownVarFromPlaceFurni_NumberInputPreset_2,_offsetCheckboxes,1,param1.getInt(4));
         updateOffsetField(UnknownVarFromPlaceFurni_NumberInputPreset_3,_offsetCheckboxes,2,param1.getInt(5));
         var _loc6_:int = param1.getInt(7);
         var _loc3_:int = param1.getInt(8);
         var _loc4_:int = param1.getInt(9);
         var _loc2_:String = param1.variableIds.length > 0 ? param1.variableIds[0] : WiredVariable.UnknownVarFromWiredVariable_String_1;
         var _loc5_:String = param1.variableIds.length > 1 ? param1.variableIds[1] : WiredVariable.UnknownVarFromWiredVariable_String_1;
         UnknownVarFromPlaceFurni_ChooseVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc2_,UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.FURNI);
         UnknownVarFromPlaceFurni_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc5_,_loc4_,_loc6_,_loc3_);
         UnknownVarFromPlaceFurni_CheckboxGroupPreset_1.get(0).selected = param1.getBoolean(6);
         updateCustomReferenceSourceState();
         updateSpawnValueState();
         UnknownVarFromPlaceFurni_SectionPreset_1.updateDisabledState();
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromPlaceFurni_ChooseVariableSection_1.onEditInitialized();
         UnknownVarFromPlaceFurni_ValueOrVariableSection_1.onEditInitialized();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc3_:Boolean = UnknownVarFromPlaceFurni_CheckboxGroupPreset_1.get(0).selected && !UnknownVarFromPlaceFurni_ValueOrVariableSection_1.disabled;
         var _loc2_:int = int(_loc3_ ? UnknownVarFromPlaceFurni_ValueOrVariableSection_1.option : 0);
         var _loc1_:int = int(_loc3_ ? UnknownVarFromPlaceFurni_ValueOrVariableSection_1.numberValue : 0);
         return [UnknownVarFromPlaceFurni_Boolean_1 ? 1 : 0,UnknownVarFromPlaceFurni_RadioGroupPreset_1.selected,UnknownVarFromPlaceFurni_RadioGroupPreset_2.selected,readOffsetValue(0,UnknownVarFromPlaceFurni_NumberInputPreset_1),readOffsetValue(1,UnknownVarFromPlaceFurni_NumberInputPreset_2),readOffsetValue(2,UnknownVarFromPlaceFurni_NumberInputPreset_3),UnknownVarFromPlaceFurni_CheckboxGroupPreset_1.get(0).selected ? 1 : 0,_loc2_,_loc1_,UnknownVarFromPlaceFurni_ValueOrVariableSection_1.target];
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         var _loc1_:String = UnknownVarFromPlaceFurni_CheckboxGroupPreset_1.get(0).selected ? UnknownVarFromPlaceFurni_ChooseVariableSection_1.finalizeSelection : WiredVariable.UnknownVarFromWiredVariable_String_1;
         var _loc3_:Boolean = UnknownVarFromPlaceFurni_CheckboxGroupPreset_1.get(0).selected && !UnknownVarFromPlaceFurni_ValueOrVariableSection_1.disabled;
         var _loc2_:String = _loc3_ && UnknownVarFromPlaceFurni_ValueOrVariableSection_1.option == 1 ? UnknownVarFromPlaceFurni_ValueOrVariableSection_1.finalizeSelection : WiredVariable.UnknownVarFromWiredVariable_String_1;
         return [_loc1_,_loc2_];
      }
      
      override public function mergedSelections() : Array
      {
         return [[1,0],[2,1]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            UnknownVarFromPlaceFurni_Boolean_1 = param2 == WiredInputSourcePicker.USER_SOURCE;
         }
         else if(param1 == 1)
         {
            UnknownVarFromPlaceFurni_ValueOrVariableSection_1.target = param2;
         }
      }
      
      override public function getMergedType(param1:int) : int
      {
         if(param1 == 0)
         {
            return UnknownVarFromPlaceFurni_Boolean_1 ? WiredInputSourcePicker.USER_SOURCE : WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
         }
         return UnknownVarFromPlaceFurni_ValueOrVariableSection_1.target;
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 != WiredInputSourcePicker.MERGED_SOURCE)
         {
            return false;
         }
         if(param1 == 0)
         {
            return !requiresCustomReferenceSource();
         }
         return UnknownVarFromPlaceFurni_ValueOrVariableSection_1.isSourcePickingDisabled() || !UnknownVarFromPlaceFurni_CheckboxGroupPreset_1.get(0).selected || UnknownVarFromPlaceFurni_ValueOrVariableSection_1.disabled;
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return param1 == 1;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         if(param1 == 1)
         {
            return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
         }
         return [];
      }
      
      private function onTargetLocationChange(param1:int) : void
      {
         updateCustomReferenceSourceState();
      }
      
      private function onTargetAltitudeChange(param1:int) : void
      {
         updateCustomReferenceSourceState();
      }
      
      private function onSpawnWithVariableChanged(param1:int, param2:Boolean) : void
      {
         if(param1 != 0)
         {
            return;
         }
         updateSpawnValueState();
      }
      
      private function onSpawnVariableSelected(param1:WiredVariable) : void
      {
         updateSpawnValueState();
      }
      
      private function updateCustomReferenceSourceState() : void
      {
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      private function updateSpawnValueState() : void
      {
         var _loc2_:WiredVariable = UnknownVarFromPlaceFurni_ChooseVariableSection_1.selected;
         var _loc3_:Boolean = _loc2_ != null && _loc2_.hasValue;
         var _loc1_:Boolean = UnknownVarFromPlaceFurni_CheckboxGroupPreset_1.get(0).selected;
         UnknownVarFromPlaceFurni_ValueOrVariableSection_1.disabled = !_loc1_ || !_loc3_;
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,1);
      }
      
      private function requiresCustomReferenceSource() : Boolean
      {
         return UnknownVarFromPlaceFurni_RadioGroupPreset_1.selected == 1 || UnknownVarFromPlaceFurni_RadioGroupPreset_2.selected == 2;
      }
      
      private function readOffsetValue(param1:int, param2:NumberInputPreset) : int
      {
         return _offsetCheckboxes.get(param1).selected ? param2.value : 0;
      }
      
      private function updateOffsetField(param1:NumberInputPreset, param2:CheckboxGroupPreset, param3:int, param4:int) : void
      {
         param1.value = param4;
         param2.get(param3).selected = param4 != 0;
      }
      
      override public function get widthModifier() : Number
      {
         return 1.2;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.place_furni";
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.merged.title.custom_target";
         }
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

