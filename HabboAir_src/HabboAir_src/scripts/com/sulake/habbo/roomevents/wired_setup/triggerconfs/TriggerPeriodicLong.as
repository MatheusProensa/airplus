package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValueSeconds5;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TriggerPeriodicLong extends TriggerPeriodically
   {
      private var UnknownVarFromTriggerPeriodicLong_SliderSection_1:SliderSection;
      
      public function TriggerPeriodicLong()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.PERIODIC_LONG;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromTriggerPeriodicLong_SliderSection_1.value];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromTriggerPeriodicLong_SliderSection_1 = param1.createSliderSection("wiredfurni.params.settime3","",new SliderValueSeconds5(),1,120,1);
         UnknownVarFromTriggerPeriodicLong_SliderSection_1.value = 1;
         param3.addElements(UnknownVarFromTriggerPeriodicLong_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromTriggerPeriodicLong_SliderSection_1.value = param1.intParams[0];
      }
   }
}

