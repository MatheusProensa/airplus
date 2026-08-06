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
   
   public class ControlClock extends DefaultActionType
   {
      private var UnknownVarFromControlClock_RadioGroupPreset_1:RadioGroupPreset;
      
      public function ControlClock()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.CONTROL_CLOCK;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromControlClock_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("clock_control.0")),new RadioButtonParam(1,l("clock_control.1")),new RadioButtonParam(2,l("clock_control.2")),new RadioButtonParam(3,l("clock_control.3")),new RadioButtonParam(4,l("clock_control.4"))]);
         UnknownVarFromControlClock_RadioGroupPreset_1.selected = 0;
         var _loc4_:SectionPreset = param1.createSection(l("clock_control"),UnknownVarFromControlClock_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromControlClock_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromControlClock_RadioGroupPreset_1.selected];
      }
   }
}

