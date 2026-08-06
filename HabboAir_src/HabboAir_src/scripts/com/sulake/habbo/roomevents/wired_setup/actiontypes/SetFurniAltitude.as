package com.sulake.habbo.roomevents.wired_setup.actiontypes
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
   
   public class SetFurniAltitude extends DefaultActionType
   {
      private var UnknownVarFromSetFurniAltitude_SliderSection_1:SliderSection;
      
      private var UnknownVarFromSetFurniAltitude_RadioGroupPreset_1:RadioGroupPreset;
      
      public function SetFurniAltitude()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.SET_FURNI_ALTITUDE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromSetFurniAltitude_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setaltitude","altitude",new SliderValueHundredth(),0,8000,1);
         UnknownVarFromSetFurniAltitude_SliderSection_1.value = 0;
         UnknownVarFromSetFurniAltitude_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("operator.0")),new RadioButtonParam(1,l("operator.1")),new RadioButtonParam(2,l("operator.2"))]);
         param3.addElements(param1.createSection(l("choose_type"),UnknownVarFromSetFurniAltitude_RadioGroupPreset_1),UnknownVarFromSetFurniAltitude_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromSetFurniAltitude_SliderSection_1.value = param1.intParams[0];
         UnknownVarFromSetFurniAltitude_RadioGroupPreset_1.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromSetFurniAltitude_SliderSection_1.value,UnknownVarFromSetFurniAltitude_RadioGroupPreset_1.selected];
      }
   }
}

