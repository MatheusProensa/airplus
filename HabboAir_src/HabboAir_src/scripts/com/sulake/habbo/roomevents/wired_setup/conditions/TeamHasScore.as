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
   
   public class TeamHasScore extends DefaultConditionType
   {
      private var UnknownVarFromTeamHasScore_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromTeamHasScore_RadioGroupPreset_2:RadioGroupPreset;
      
      private var UnknownVarFromTeamHasScore_SliderSection_1:SliderSection;
      
      public function TeamHasScore()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.TEAM_HAS_SCORE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromTeamHasScore_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("team.triggerer"),null,null,true),new RadioButtonParam(1,l("team.1")),new RadioButtonParam(2,l("team.2")),new RadioButtonParam(3,l("team.3")),new RadioButtonParam(4,l("team.4"))],null,2);
         UnknownVarFromTeamHasScore_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(1,l("comparison.1")),new RadioButtonParam(2,l("comparison.2"))]);
         UnknownVarFromTeamHasScore_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setscore2","points",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),0,1000,1);
         UnknownVarFromTeamHasScore_SliderSection_1.value = 1;
         param3.addElements(param1.createSection(l("team"),UnknownVarFromTeamHasScore_RadioGroupPreset_1),param1.createSection(l("comparison_selection"),UnknownVarFromTeamHasScore_RadioGroupPreset_2),UnknownVarFromTeamHasScore_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromTeamHasScore_RadioGroupPreset_1.selected = param1.intParams[0];
         UnknownVarFromTeamHasScore_SliderSection_1.value = param1.intParams[1];
         UnknownVarFromTeamHasScore_RadioGroupPreset_2.selected = param1.intParams[2];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromTeamHasScore_RadioGroupPreset_1.selected,UnknownVarFromTeamHasScore_SliderSection_1.value,UnknownVarFromTeamHasScore_RadioGroupPreset_2.selected];
      }
   }
}

