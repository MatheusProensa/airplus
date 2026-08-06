package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValueCountOrUnlimited;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GiveScore extends DefaultActionType
   {
      private static var UnknownVarFromGiveScore_Int_1:int = 10;
      
      private static var UnknownVarFromGiveScore_Int_2:int = UnknownVarFromGiveScore_Int_1 + 1;
      
      private var UnknownVarFromGiveScore_SliderSection_1:SliderSection;
      
      private var UnknownVarFromGiveScore_SliderSection_2:SliderSection;
      
      private var UnknownVarFromGiveScore_RadioGroupPreset_1:RadioGroupPreset;
      
      public function GiveScore()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.GIVE_SCORE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromGiveScore_SliderSection_1 = param1.createSliderSection("wiredfurni.params.setpoints2","",SliderSection.CONVERTER_ECHO,1,1000,1);
         UnknownVarFromGiveScore_SliderSection_2 = param1.createSliderSection("wiredfurni.params.settimesingame","times",new SliderValueCountOrUnlimited(UnknownVarFromGiveScore_Int_2),1,UnknownVarFromGiveScore_Int_2,1,false);
         UnknownVarFromGiveScore_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("points_operation.0")),new RadioButtonParam(1,l("points_operation.1"))]);
         param3.addElements(UnknownVarFromGiveScore_SliderSection_1,UnknownVarFromGiveScore_SliderSection_2,param1.createSection(l("points_operation"),UnknownVarFromGiveScore_RadioGroupPreset_1));
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = 0;
         if(_loc2_ < 0)
         {
            _loc2_ = -_loc2_;
            _loc4_ = 1;
         }
         UnknownVarFromGiveScore_SliderSection_2.visible = _loc3_ != 0;
         UnknownVarFromGiveScore_RadioGroupPreset_1.selected = _loc4_;
         UnknownVarFromGiveScore_SliderSection_1.value = _loc2_;
         UnknownVarFromGiveScore_SliderSection_2.value = _loc3_ == 0 ? UnknownVarFromGiveScore_Int_2 : _loc3_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:int = UnknownVarFromGiveScore_SliderSection_1.value;
         if(UnknownVarFromGiveScore_RadioGroupPreset_1.selected == 1)
         {
            _loc1_ = -_loc1_;
         }
         var _loc2_:int = int(UnknownVarFromGiveScore_SliderSection_2.value == UnknownVarFromGiveScore_Int_2 ? 0 : UnknownVarFromGiveScore_SliderSection_2.value);
         return [_loc1_,_loc2_];
      }
   }
}

