package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValuePulses;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ClockReachTime extends DefaultTriggerConf
   {
      private var UnknownVarFromClockReachTime_SliderSection_1:SliderSection;
      
      private var _sliderMinutes:SliderSection;
      
      public function ClockReachTime()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.CLOCK_REACH_TIME;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc3_:Number = UnknownVarFromClockReachTime_SliderSection_1.value;
         var _loc1_:int = Math.floor(_loc3_ / 2);
         var _loc2_:int = _loc3_ % 2;
         return [_loc1_,_sliderMinutes.value,_loc2_];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromClockReachTime_SliderSection_1 = param1.createSliderSection("wiredfurni.params.clock_seconds_elapsed","seconds",new SliderValuePulses(),0,119,1,false);
         _sliderMinutes = param1.createSliderSection("wiredfurni.params.clock_minutes_elapsed","minutes",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),0,99,1,false);
         param3.addElements(_sliderMinutes,UnknownVarFromClockReachTime_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = int(param1.intParams[2]);
         UnknownVarFromClockReachTime_SliderSection_1.value = _loc2_ * 2 + _loc4_;
         _sliderMinutes.value = _loc3_;
      }
   }
}

