package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValuePulses;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ClockTimeMatches extends DefaultConditionType
   {
      private var UnknownVarFromClockTimeMatches_SliderSection_1:SliderSection;
      
      private var UnknownVarFromClockTimeMatches_SliderSection_2:SliderSection;
      
      private var UnknownVarFromClockTimeMatches_RadioGroupPreset_1:RadioGroupPreset;
      
      public function ClockTimeMatches()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.CLOCK_TIME_MATCHES;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromClockTimeMatches_SliderSection_1 = param1.createSliderSection("wiredfurni.params.clock_seconds_elapsed","seconds",new SliderValuePulses(),0,119,1,false);
         UnknownVarFromClockTimeMatches_SliderSection_2 = param1.createSliderSection("wiredfurni.params.clock_minutes_elapsed","minutes",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),0,99,1,false);
         UnknownVarFromClockTimeMatches_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(1,l("comparison.1")),new RadioButtonParam(2,l("comparison.2"))]);
         param3.addElements(param1.createSection(l("comparison_selection"),UnknownVarFromClockTimeMatches_RadioGroupPreset_1),UnknownVarFromClockTimeMatches_SliderSection_2,UnknownVarFromClockTimeMatches_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = int(param1.intParams[2]);
         UnknownVarFromClockTimeMatches_SliderSection_1.value = _loc2_ * 2 + _loc4_;
         UnknownVarFromClockTimeMatches_SliderSection_2.value = _loc3_;
         UnknownVarFromClockTimeMatches_RadioGroupPreset_1.selected = param1.intParams[3];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc3_:Number = UnknownVarFromClockTimeMatches_SliderSection_1.value;
         var _loc1_:int = Math.floor(_loc3_ / 2);
         var _loc2_:int = _loc3_ % 2;
         return [_loc1_,UnknownVarFromClockTimeMatches_SliderSection_2.value,_loc2_,UnknownVarFromClockTimeMatches_RadioGroupPreset_1.selected];
      }
   }
}

