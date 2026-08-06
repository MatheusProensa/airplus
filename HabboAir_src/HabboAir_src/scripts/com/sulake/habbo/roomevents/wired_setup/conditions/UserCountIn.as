package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UserCountIn extends DefaultConditionType
   {
      private var UnknownVarFromUserCountIn_SliderSection_1:SliderSection;
      
      private var UnknownVarFromUserCountIn_SliderSection_2:SliderSection;
      
      public function UserCountIn()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.USER_COUNT_IN;
      }
      
      override public function get negativeCode() : int
      {
         return ConditionCodes.NOT_USER_COUNT_IN;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromUserCountIn_SliderSection_1 = param1.createSliderSection("wiredfurni.params.usercountmin","value",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),0,125,1,false);
         UnknownVarFromUserCountIn_SliderSection_2 = param1.createSliderSection("wiredfurni.params.usercountmax","value",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),0,125,1,false);
         param3.addElements(UnknownVarFromUserCountIn_SliderSection_1,UnknownVarFromUserCountIn_SliderSection_2);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromUserCountIn_SliderSection_1.value = param1.intParams[0];
         UnknownVarFromUserCountIn_SliderSection_2.value = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromUserCountIn_SliderSection_1.value,UnknownVarFromUserCountIn_SliderSection_2.value];
      }
   }
}

