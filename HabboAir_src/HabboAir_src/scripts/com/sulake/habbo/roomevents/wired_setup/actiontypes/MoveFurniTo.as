package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MoveFurniTo extends DefaultActionType
   {
      private var UnknownVarFromMoveFurniTo_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromMoveFurniTo_SliderSection_1:SliderSection;
      
      public function MoveFurniTo()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MOVE_FURNI_TO;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMoveFurniTo_RadioGroupPreset_1.selected,UnknownVarFromMoveFurniTo_SliderSection_1.value];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMoveFurniTo_RadioGroupPreset_1.selected = param1.intParams[0];
         UnknownVarFromMoveFurniTo_SliderSection_1.value = param1.intParams[1];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromMoveFurniTo_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("movefurni.0")),new RadioButtonParam(2,l("movefurni.2")),new RadioButtonParam(4,l("movefurni.4")),new RadioButtonParam(6,l("movefurni.6"))]);
         UnknownVarFromMoveFurniTo_RadioGroupPreset_1.selected = 0;
         var _loc4_:SectionPreset = param1.createSection(l("movefurni"),UnknownVarFromMoveFurniTo_RadioGroupPreset_1);
         UnknownVarFromMoveFurniTo_SliderSection_1 = param1.createSliderSection("wiredfurni.params.emptytiles","tiles",SliderSection.CONVERTER_ECHO,1,5,1);
         UnknownVarFromMoveFurniTo_SliderSection_1.value = 1;
         param3.addElements(_loc4_,UnknownVarFromMoveFurniTo_SliderSection_1);
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv." + param1;
      }
   }
}

