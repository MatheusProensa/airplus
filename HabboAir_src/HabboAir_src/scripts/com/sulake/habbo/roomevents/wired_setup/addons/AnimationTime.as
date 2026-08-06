package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AnimationTime extends DefaultAddonType
   {
      private var UnknownVarFromAnimationTime_SliderSection_1:SliderSection;
      
      public function AnimationTime()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.ANIMATION_TIME;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromAnimationTime_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setanimationtime2","",SliderSection.CONVERTER_ECHO,50,2000,50);
         param3.addElements(UnknownVarFromAnimationTime_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromAnimationTime_SliderSection_1.value = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromAnimationTime_SliderSection_1.value];
      }
   }
}

