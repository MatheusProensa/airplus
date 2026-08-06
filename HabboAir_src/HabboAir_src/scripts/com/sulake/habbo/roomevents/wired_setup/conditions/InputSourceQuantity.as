package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class InputSourceQuantity extends DefaultConditionType
   {
      private var UnknownVarFromInputSourceQuantity_SliderSection_1:SliderSection;
      
      private var UnknownVarFromInputSourceQuantity_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromInputSourceQuantity_Boolean_1:Boolean;
      
      public function InputSourceQuantity()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.INPUT_SOURCE_QUANTITY;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromInputSourceQuantity_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(1,l("comparison.1")),new RadioButtonParam(2,l("comparison.2"))]);
         var _loc4_:SectionPreset = param1.createSection(l("comparison_selection"),UnknownVarFromInputSourceQuantity_RadioGroupPreset_1);
         UnknownVarFromInputSourceQuantity_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setamount2","",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),0,100,1);
         param3.addElements(_loc4_,UnknownVarFromInputSourceQuantity_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromInputSourceQuantity_Boolean_1 = param1.getBoolean(0);
         UnknownVarFromInputSourceQuantity_SliderSection_1.value = param1.intParams[1];
         UnknownVarFromInputSourceQuantity_RadioGroupPreset_1.selected = param1.intParams[2];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromInputSourceQuantity_Boolean_1 ? 1 : 0,UnknownVarFromInputSourceQuantity_SliderSection_1.value,UnknownVarFromInputSourceQuantity_RadioGroupPreset_1.selected];
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromInputSourceQuantity_Boolean_1 = param2 == WiredInputSourcePicker.USER_SOURCE;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromInputSourceQuantity_Boolean_1 ? WiredInputSourcePicker.USER_SOURCE : WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

