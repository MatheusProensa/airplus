package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValuePulses;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AdjustClock extends DefaultActionType
   {
      private var UnknownVarFromAdjustClock_SliderSection_1:SliderSection;
      
      private var UnknownVarFromAdjustClock_SliderSection_2:SliderSection;
      
      private var UnknownVarFromAdjustClock_RadioGroupPreset_1:RadioGroupPreset;
      
      public function AdjustClock()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.ADJUST_CLOCK;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromAdjustClock_SliderSection_1 = param1.createSliderSection("wiredfurni.params.clock_seconds","seconds",new SliderValuePulses(),0,119,1,false);
         UnknownVarFromAdjustClock_SliderSection_2 = param1.createSliderSection("wiredfurni.params.clock_minutes","minutes",SliderSection.CONVERTER_ECHO,0,99,1,false);
         UnknownVarFromAdjustClock_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("operator.0")),new RadioButtonParam(1,l("operator.1")),new RadioButtonParam(2,l("operator.2"))]);
         param3.addElements(param1.createSection(l("choose_type"),UnknownVarFromAdjustClock_RadioGroupPreset_1),UnknownVarFromAdjustClock_SliderSection_2,UnknownVarFromAdjustClock_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = int(param1.intParams[2]);
         UnknownVarFromAdjustClock_SliderSection_1.value = _loc2_ * 2 + _loc4_;
         UnknownVarFromAdjustClock_SliderSection_2.value = _loc3_;
         UnknownVarFromAdjustClock_RadioGroupPreset_1.selected = param1.intParams[3];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc3_:int = UnknownVarFromAdjustClock_SliderSection_1.value;
         var _loc1_:int = Math.floor(_loc3_ / 2);
         var _loc2_:int = _loc3_ % 2;
         return [_loc1_,UnknownVarFromAdjustClock_SliderSection_2.value,_loc2_,UnknownVarFromAdjustClock_RadioGroupPreset_1.selected];
      }
   }
}

