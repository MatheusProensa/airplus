package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class HasStackedFurnis extends DefaultConditionType
   {
      private var UnknownVarFromHasStackedFurnis_RadioGroupPreset_1:RadioGroupPreset;
      
      public function HasStackedFurnis()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.HAS_STACKED_FURNIS;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromHasStackedFurnis_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("requireall.0")),new RadioButtonParam(1,l("requireall.1"))]);
         var _loc4_:SectionPreset = param1.createSection(l("requireall"),UnknownVarFromHasStackedFurnis_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromHasStackedFurnis_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromHasStackedFurnis_RadioGroupPreset_1.selected];
      }
   }
}

