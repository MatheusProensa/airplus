package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ActorIsInTeam extends DefaultConditionType
   {
      private var UnknownVarFromActorIsInTeam_RadioGroupPreset_1:RadioGroupPreset;
      
      public function ActorIsInTeam()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.ACTOR_IS_IN_TEAM;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_ACTOR_IS_IN_TEAM;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromActorIsInTeam_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("team.any"),null,null,true),new RadioButtonParam(1,l("team.1")),new RadioButtonParam(2,l("team.2")),new RadioButtonParam(3,l("team.3")),new RadioButtonParam(4,l("team.4"))],null,2);
         var _loc4_:SectionPreset = param1.createSection(l("team"),UnknownVarFromActorIsInTeam_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromActorIsInTeam_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromActorIsInTeam_RadioGroupPreset_1.selected];
      }
   }
}

