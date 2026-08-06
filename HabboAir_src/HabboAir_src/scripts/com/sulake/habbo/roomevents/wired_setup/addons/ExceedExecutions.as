package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValuePulses;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ExceedExecutions extends DefaultAddonType
   {
      private var UnknownVarFromExceedExecutions_SliderSection_1:SliderSection;
      
      private var UnknownVarFromExceedExecutions_SliderSection_2:SliderSection;
      
      public function ExceedExecutions()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.UnknownVarFromAddonCodes_Int_3;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromExceedExecutions_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setexecutions","amount",SliderSection.CONVERTER_ECHO,1,100,1,false);
         UnknownVarFromExceedExecutions_SliderSection_2 = param1.createSliderSection("wiredfurni.params.settimewindow","timewindow",new SliderValuePulses(),1,20,1,false);
         param3.addElements(UnknownVarFromExceedExecutions_SliderSection_1,UnknownVarFromExceedExecutions_SliderSection_2);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromExceedExecutions_SliderSection_1.value = param1.intParams[0];
         UnknownVarFromExceedExecutions_SliderSection_2.value = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromExceedExecutions_SliderSection_1.value,UnknownVarFromExceedExecutions_SliderSection_2.value];
      }
   }
}

