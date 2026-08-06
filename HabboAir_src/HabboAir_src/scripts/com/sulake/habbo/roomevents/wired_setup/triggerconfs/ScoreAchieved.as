package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ScoreAchieved extends DefaultTriggerConf
   {
      private var UnknownVarFromScoreAchieved_SliderSection_1:SliderSection;
      
      private var UnknownVarFromScoreAchieved_RadioGroupPreset_1:RadioGroupPreset;
      
      public function ScoreAchieved()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.SCORE_ACHIEVED;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromScoreAchieved_SliderSection_1.value,UnknownVarFromScoreAchieved_RadioGroupPreset_1.selected];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromScoreAchieved_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("team.any"),null,null,true),new RadioButtonParam(1,l("team.1")),new RadioButtonParam(2,l("team.2")),new RadioButtonParam(3,l("team.3")),new RadioButtonParam(4,l("team.4"))],null,2);
         UnknownVarFromScoreAchieved_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setscore2","points",new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1(),1,1000,1);
         UnknownVarFromScoreAchieved_SliderSection_1.value = 1;
         param3.addElements(param1.createSection(l("team"),UnknownVarFromScoreAchieved_RadioGroupPreset_1),UnknownVarFromScoreAchieved_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         UnknownVarFromScoreAchieved_SliderSection_1.value = _loc2_;
         UnknownVarFromScoreAchieved_RadioGroupPreset_1.selected = _loc3_;
      }
   }
}

