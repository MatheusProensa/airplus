package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PickOneRandomlyPropagation extends DefaultAddonType
   {
      private var UnknownVarFromPickOneRandomlyPropagation_SliderSection_1:SliderSection;
      
      private var UnknownVarFromPickOneRandomlyPropagation_SliderSection_2:SliderSection;
      
      public function PickOneRandomlyPropagation()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.UnknownVarFromAddonCodes_Int_1;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromPickOneRandomlyPropagation_SliderSection_2.value,UnknownVarFromPickOneRandomlyPropagation_SliderSection_1.value];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromPickOneRandomlyPropagation_SliderSection_2.value = param1.intParams[0];
         UnknownVarFromPickOneRandomlyPropagation_SliderSection_1.value = param1.intParams[1];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromPickOneRandomlyPropagation_SliderSection_2 = param1.createSliderSection("wiredfurni.params.skipactions","skips",SliderSection.CONVERTER_ECHO,0,100,1,false);
         UnknownVarFromPickOneRandomlyPropagation_SliderSection_1 = param1.createSliderSection("wiredfurni.params.pickamount","picks",SliderSection.CONVERTER_ECHO,1,100,1,false);
         param3.addElements(UnknownVarFromPickOneRandomlyPropagation_SliderSection_1,UnknownVarFromPickOneRandomlyPropagation_SliderSection_2);
      }
   }
}

