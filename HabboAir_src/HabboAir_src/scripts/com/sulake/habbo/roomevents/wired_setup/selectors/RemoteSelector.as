package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RemoteSelector extends DefaultSelectorType
   {
      private var UnknownVarFromRemoteSelector_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromRemoteSelector_RadioGroupPreset_2:RadioGroupPreset;
      
      private var UnknownVarFromRemoteSelector_NumberInputPreset_1:NumberInputPreset;
      
      public function RemoteSelector()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.REMOTE_SELECTOR;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromRemoteSelector_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("remote_selection.type.0")),new RadioButtonParam(1,l("remote_selection.type.1"))]);
         var _loc5_:SectionPreset = param1.createSection(l("remote_selection.type"),UnknownVarFromRemoteSelector_RadioGroupPreset_1);
         UnknownVarFromRemoteSelector_NumberInputPreset_1 = param1.createNumberInput(new NumberInputParam(0,0,2147483647,40,0,false));
         UnknownVarFromRemoteSelector_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,l("remote_selection.filter.0")),new RadioButtonParam(1,l("remote_selection.filter.1"),UnknownVarFromRemoteSelector_NumberInputPreset_1)]);
         var _loc4_:SectionPreset = param1.createSection(l("remote_selection.filter"),UnknownVarFromRemoteSelector_RadioGroupPreset_2);
         param3.addElements(_loc5_,_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromRemoteSelector_RadioGroupPreset_1.selected = param1.intParams[0];
         var _loc2_:int = int(param1.intParams[1]);
         UnknownVarFromRemoteSelector_RadioGroupPreset_2.selected = _loc2_ > 0 ? 1 : 0;
         UnknownVarFromRemoteSelector_NumberInputPreset_1.value = _loc2_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:int = int(UnknownVarFromRemoteSelector_RadioGroupPreset_2.selected == 1 ? UnknownVarFromRemoteSelector_NumberInputPreset_1.value : 0);
         return [UnknownVarFromRemoteSelector_RadioGroupPreset_1.selected,_loc1_];
      }
   }
}

