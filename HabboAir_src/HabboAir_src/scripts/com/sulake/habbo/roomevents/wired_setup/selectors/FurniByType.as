package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FurniByType extends DefaultSelectorType
   {
      private var _stateCheckbox:CheckboxGroupPreset;
      
      public function FurniByType()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.FURNI_BY_TYPE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _stateCheckbox = param1.createCheckboxGroup([new CheckboxOptionParam(l("state_match"),0)]);
         var _loc4_:SectionPreset = param1.createSection(l("select_options"),_stateCheckbox);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _stateCheckbox.get(0).selected = param1.getBoolean(0);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [_stateCheckbox.get(0).selected ? 1 : 0];
      }
   }
}

