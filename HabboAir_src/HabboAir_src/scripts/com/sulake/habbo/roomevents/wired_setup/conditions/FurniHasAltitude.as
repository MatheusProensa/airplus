package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValueHundredth;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FurniHasAltitude extends DefaultConditionType
   {
      private var UnknownVarFromFurniHasAltitude_SliderSection_1:SliderSection;
      
      private var UnknownVarFromFurniHasAltitude_RadioGroupPreset_1:RadioGroupPreset;
      
      public function FurniHasAltitude()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.FURNI_HAS_ALTITUDE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromFurniHasAltitude_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setaltitude","",new SliderValueHundredth(),0,8000,1);
         UnknownVarFromFurniHasAltitude_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(1,l("comparison.1")),new RadioButtonParam(2,l("comparison.2"))]);
         param3.addElements(param1.createSection(l("comparison_selection"),UnknownVarFromFurniHasAltitude_RadioGroupPreset_1),UnknownVarFromFurniHasAltitude_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromFurniHasAltitude_SliderSection_1.value = param1.intParams[0];
         UnknownVarFromFurniHasAltitude_RadioGroupPreset_1.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromFurniHasAltitude_SliderSection_1.value,UnknownVarFromFurniHasAltitude_RadioGroupPreset_1.selected];
      }
   }
}

