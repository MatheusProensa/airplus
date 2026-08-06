package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UsersInTeam extends DefaultSelectorType
   {
      private var UnknownVarFromUsersInTeam_RadioGroupPreset_1:RadioGroupPreset;
      
      public function UsersInTeam()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_IN_TEAM;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromUsersInTeam_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("team.any"),null,null,true),new RadioButtonParam(1,l("team.1")),new RadioButtonParam(2,l("team.2")),new RadioButtonParam(3,l("team.3")),new RadioButtonParam(4,l("team.4"))],null,2);
         var _loc4_:SectionPreset = param1.createSection(l("team"),UnknownVarFromUsersInTeam_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromUsersInTeam_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromUsersInTeam_RadioGroupPreset_1.selected];
      }
   }
}

