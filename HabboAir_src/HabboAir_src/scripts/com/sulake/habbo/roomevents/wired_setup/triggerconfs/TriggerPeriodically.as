package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValuePulses;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TriggerPeriodically extends DefaultTriggerConf
   {
      private var UnknownVarFromTriggerPeriodically_SliderSection_1:SliderSection;
      
      public function TriggerPeriodically()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.TRIGGER_PERIODICALLY;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromTriggerPeriodically_SliderSection_1.value];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromTriggerPeriodically_SliderSection_1 = param1.createSliderSection("wiredfurni.params.settime3","",new SliderValuePulses(),1,120,1);
         UnknownVarFromTriggerPeriodically_SliderSection_1.value = 1;
         param3.addElements(UnknownVarFromTriggerPeriodically_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromTriggerPeriodically_SliderSection_1.value = param1.intParams[0];
      }
   }
}

