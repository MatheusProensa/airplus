package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class StateChange extends DefaultTriggerConf
   {
      private var UnknownVarFromStateChange_RadioGroupPreset_1:RadioGroupPreset;
      
      public function StateChange()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.STATE_CHANGE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromStateChange_RadioGroupPreset_1.selected];
      }
      
      override public function get hasStateSnapshot() : Boolean
      {
         return true;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromStateChange_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("state_trigger.1")),new RadioButtonParam(0,l("state_trigger.0"))]);
         var _loc4_:SectionPreset = param1.createSection(l("select_options"),UnknownVarFromStateChange_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromStateChange_RadioGroupPreset_1.selected = param1.intParams[0];
      }
   }
}

