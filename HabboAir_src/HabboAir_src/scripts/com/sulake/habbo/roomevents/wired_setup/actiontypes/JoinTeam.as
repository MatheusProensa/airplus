package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class JoinTeam extends DefaultActionType
   {
      private var UnknownVarFromJoinTeam_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromJoinTeam_RadioGroupPreset_2:RadioGroupPreset;
      
      public function JoinTeam()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.JOIN_TEAM;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromJoinTeam_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("team.1")),new RadioButtonParam(2,l("team.2")),new RadioButtonParam(3,l("team.3")),new RadioButtonParam(4,l("team.4"))],null,2);
         var _loc4_:SectionPreset = param1.createSection(l("team"),UnknownVarFromJoinTeam_RadioGroupPreset_1);
         UnknownVarFromJoinTeam_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,l("team_type.0")),new RadioButtonParam(1,l("team_type.1")),new RadioButtonParam(2,l("team_type.2"))]);
         var _loc5_:SectionPreset = param1.createSection(l("choose_type"),UnknownVarFromJoinTeam_RadioGroupPreset_2);
         param3.addElements(_loc4_,_loc5_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromJoinTeam_RadioGroupPreset_1.selected = param1.intParams[0];
         UnknownVarFromJoinTeam_RadioGroupPreset_2.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromJoinTeam_RadioGroupPreset_1.selected,UnknownVarFromJoinTeam_RadioGroupPreset_2.selected];
      }
   }
}

