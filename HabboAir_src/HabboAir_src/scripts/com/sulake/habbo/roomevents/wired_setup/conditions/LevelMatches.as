package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class LevelMatches extends DefaultConditionType
   {
      private var UnknownVarFromLevelMatches_SliderSection_1:SliderSection;
      
      private var UnknownVarFromLevelMatches_RadioGroupPreset_1:RadioGroupPreset;
      
      public function LevelMatches()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.USER_LEVEL;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromLevelMatches_SliderSection_1 = param1.createSliderSection("wiredfurni.params.level_selection","level",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),1,30,1);
         UnknownVarFromLevelMatches_SliderSection_1.value = 1;
         UnknownVarFromLevelMatches_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(1,l("comparison.1")),new RadioButtonParam(2,l("comparison.2"))]);
         param3.addElements(UnknownVarFromLevelMatches_SliderSection_1,param1.createSection(l("comparison_selection"),UnknownVarFromLevelMatches_RadioGroupPreset_1));
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromLevelMatches_SliderSection_1.value = param1.intParams[0];
         UnknownVarFromLevelMatches_RadioGroupPreset_1.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromLevelMatches_SliderSection_1.value,UnknownVarFromLevelMatches_RadioGroupPreset_1.selected];
      }
   }
}

