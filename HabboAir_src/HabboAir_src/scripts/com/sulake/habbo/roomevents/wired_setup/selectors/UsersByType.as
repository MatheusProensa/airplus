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
   
   public class UsersByType extends DefaultSelectorType
   {
      private var UnknownVarFromUsersByType_RadioGroupPreset_1:RadioGroupPreset;
      
      public function UsersByType()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_BY_TYPE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromUsersByType_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("usertype.1")),new RadioButtonParam(2,l("usertype.2")),new RadioButtonParam(4,l("usertype.4"))]);
         UnknownVarFromUsersByType_RadioGroupPreset_1.selected = 1;
         var _loc4_:SectionPreset = param1.createSection(l("usertype"),UnknownVarFromUsersByType_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromUsersByType_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromUsersByType_RadioGroupPreset_1.selected];
      }
   }
}

