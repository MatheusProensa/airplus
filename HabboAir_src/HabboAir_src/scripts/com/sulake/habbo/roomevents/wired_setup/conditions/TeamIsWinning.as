package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TeamIsWinning extends DefaultConditionType
   {
      private var UnknownVarFromTeamIsWinning_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromTeamIsWinning_RadioGroupPreset_2:RadioGroupPreset;
      
      public function TeamIsWinning()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.TEAM_IS_WINNING;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromTeamIsWinning_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("team.triggerer"),null,null,true),new RadioButtonParam(1,l("team.1")),new RadioButtonParam(2,l("team.2")),new RadioButtonParam(3,l("team.3")),new RadioButtonParam(4,l("team.4"))],null,2);
         UnknownVarFromTeamIsWinning_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,l("placement.1")),new RadioButtonParam(1,l("placement.2")),new RadioButtonParam(2,l("placement.3")),new RadioButtonParam(3,l("placement.4"))],null,4);
         param3.addElements(param1.createSection(l("team"),UnknownVarFromTeamIsWinning_RadioGroupPreset_1),param1.createSection(l("placement_selection"),UnknownVarFromTeamIsWinning_RadioGroupPreset_2));
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromTeamIsWinning_RadioGroupPreset_1.selected = param1.intParams[0];
         UnknownVarFromTeamIsWinning_RadioGroupPreset_2.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromTeamIsWinning_RadioGroupPreset_1.selected,UnknownVarFromTeamIsWinning_RadioGroupPreset_2.selected];
      }
   }
}

