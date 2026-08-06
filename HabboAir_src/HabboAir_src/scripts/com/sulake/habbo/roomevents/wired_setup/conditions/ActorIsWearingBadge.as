package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ActorIsWearingBadge extends DefaultConditionType
   {
      private var UnknownVarFromActorIsWearingBadge_TextInputPreset_1:TextInputPreset;
      
      public function ActorIsWearingBadge()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.ACTOR_IS_WEARING_BADGE;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_ACTOR_IS_WEARING_BADGE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromActorIsWearingBadge_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",1000,null,-1,null,true,loc("wiredfurni.tooltip.badgecode")));
         var _loc4_:SectionPreset = param1.createSection(l("badgecode"),UnknownVarFromActorIsWearingBadge_TextInputPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromActorIsWearingBadge_TextInputPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromActorIsWearingBadge_TextInputPreset_1.text = param1.stringParam;
      }
   }
}

