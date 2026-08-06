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
   
   public class OverrideHeight extends DefaultActionType
   {
      private var UnknownVarFromOverrideHeight_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromOverrideHeight_SliderSection_1:SliderSection;
      
      public function OverrideHeight()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.OVERRIDE_HEIGHT;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromOverrideHeight_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.override_height.type.0}"),new RadioButtonParam(1,"${wiredfurni.params.override_height.type.1}")],onChangeType);
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.override_height.type}",UnknownVarFromOverrideHeight_RadioGroupPreset_1);
         UnknownVarFromOverrideHeight_SliderSection_1 = param1.createSliderSection("wiredfurni.params.override_height.height","",SliderSection.CONVERTER_ECHO,0,8000,1);
         param3.addElements(_loc4_,UnknownVarFromOverrideHeight_SliderSection_1);
      }
      
      private function onChangeType(param1:int) : void
      {
         UnknownVarFromOverrideHeight_SliderSection_1.disabled = param1 == 1;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromOverrideHeight_SliderSection_1.value = param1.getInt(0);
         UnknownVarFromOverrideHeight_RadioGroupPreset_1.selected = param1.getBoolean(1) ? 1 : 0;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromOverrideHeight_SliderSection_1.value,UnknownVarFromOverrideHeight_RadioGroupPreset_1.selected];
      }
   }
}

