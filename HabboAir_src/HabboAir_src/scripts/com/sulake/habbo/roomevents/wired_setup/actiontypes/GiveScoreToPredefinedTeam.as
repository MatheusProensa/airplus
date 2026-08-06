package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GiveScoreToPredefinedTeam extends GiveScore
   {
      private var UnknownVarFromGiveScoreToPredefinedTeam_RadioGroupPreset_1:RadioGroupPreset;
      
      public function GiveScoreToPredefinedTeam()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.GIVE_SCORE_TO_PREDEFINED_TEAM;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         super.buildInputs(param1,param2,param3);
         UnknownVarFromGiveScoreToPredefinedTeam_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("team.1")),new RadioButtonParam(2,l("team.2")),new RadioButtonParam(3,l("team.3")),new RadioButtonParam(4,l("team.4"))],null,2);
         var _loc4_:SectionPreset = param1.createSection(l("team"),UnknownVarFromGiveScoreToPredefinedTeam_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc2_:int = int(param1.intParams[2]);
         UnknownVarFromGiveScoreToPredefinedTeam_RadioGroupPreset_1.selected = _loc2_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = super.readIntParamsFromForm();
         _loc1_.push(UnknownVarFromGiveScoreToPredefinedTeam_RadioGroupPreset_1.selected);
         return _loc1_;
      }
   }
}

