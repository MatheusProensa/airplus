package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FurniOnFurni extends DefaultSelectorType
   {
      private var UnknownVarFromFurniOnFurni_RadioGroupPreset_1:RadioGroupPreset;
      
      public function FurniOnFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.FURNI_ON_FURNI;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromFurniOnFurni_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("onfurni.0")),new RadioButtonParam(1,l("onfurni.1")),new RadioButtonParam(2,l("onfurni.2")),new RadioButtonParam(3,l("onfurni.3"))]);
         UnknownVarFromFurniOnFurni_RadioGroupPreset_1.selected = 0;
         var _loc4_:SectionPreset = param1.createSection(l("selection_type"),UnknownVarFromFurniOnFurni_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromFurniOnFurni_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromFurniOnFurni_RadioGroupPreset_1.selected];
      }
   }
}

