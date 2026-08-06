package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AchievementEnablerAddon extends DefaultAddonType
   {
      private var UnknownVarFromAchievementEnablerAddon_TextAreaPreset_1:TextAreaPreset;
      
      public function AchievementEnablerAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.ACHIEVEMENT_ENABLER;
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromAchievementEnablerAddon_TextAreaPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromAchievementEnablerAddon_TextAreaPreset_1.text = param1.stringParam;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromAchievementEnablerAddon_TextAreaPreset_1 = param1.createTextArea(new TextAreaParam(60,-1,-1,100,2000,"","${wiredfurni.params.achievement_enabler.placeholder}"));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.achievement_enabler}",UnknownVarFromAchievementEnablerAddon_TextAreaPreset_1);
         param3.addElements(_loc4_);
      }
   }
}

