package com.sulake.habbo.roomevents.wired_setup.selectors
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
   
   public class FurniWithAltitude extends DefaultSelectorType
   {
      private var UnknownVarFromFurniWithAltitude_SliderSection_1:SliderSection;
      
      private var UnknownVarFromFurniWithAltitude_RadioGroupPreset_1:RadioGroupPreset;
      
      public function FurniWithAltitude()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.FURNI_WITH_ALTITUDE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromFurniWithAltitude_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setaltitude","altitude",new SliderValueHundredth(),0,8000,1);
         UnknownVarFromFurniWithAltitude_SliderSection_1.value = 0;
         UnknownVarFromFurniWithAltitude_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(1,l("comparison.1")),new RadioButtonParam(2,l("comparison.2"))]);
         param3.addElements(param1.createSection(l("comparison_selection"),UnknownVarFromFurniWithAltitude_RadioGroupPreset_1),UnknownVarFromFurniWithAltitude_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromFurniWithAltitude_SliderSection_1.value = param1.intParams[0];
         UnknownVarFromFurniWithAltitude_RadioGroupPreset_1.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromFurniWithAltitude_SliderSection_1.value,UnknownVarFromFurniWithAltitude_RadioGroupPreset_1.selected];
      }
   }
}

