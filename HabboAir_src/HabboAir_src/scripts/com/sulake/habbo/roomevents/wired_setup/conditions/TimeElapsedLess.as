package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TimeElapsedLess extends DefaultConditionType
   {
      private var UnknownVarFromTimeElapsedLess_SliderSection_1:SliderSection;
      
      public function TimeElapsedLess()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.TIME_ELAPSED_LESS;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromTimeElapsedLess_SliderSection_1 = param1.createSliderSection("wiredfurni.params.allowbefore2","",SliderSection.CONVERTER_PULSES,1,1200,1);
         UnknownVarFromTimeElapsedLess_SliderSection_1.value = 1;
         param3.addElements(UnknownVarFromTimeElapsedLess_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromTimeElapsedLess_SliderSection_1.value = param1.intParams[0] - 1;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromTimeElapsedLess_SliderSection_1.value + 1];
      }
   }
}

