package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SourceTypeSelectorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ValueOrVariableSection extends AbstractSectionPreset implements IWiredInputSourcePicker
   {
      private var UnknownVarFromValueOrVariableSection_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromValueOrVariableSection_NumberInputPreset_1:NumberInputPreset;
      
      private var _picker:VariablePickerPreset;
      
      private var UnknownVarFromValueOrVariableSection_SourceTypeSelectorPreset_1:SourceTypeSelectorPreset;
      
      private var UnknownVarFromValueOrVariableSection_Int_1:int;
      
      private var _target:int;
      
      public function ValueOrVariableSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:int, param5:Array, param6:String, param7:int, param8:int)
      {
         super(param1,param2,param3);
         UnknownVarFromValueOrVariableSection_Int_1 = param4;
         UnknownVarFromValueOrVariableSection_NumberInputPreset_1 = param2.createNumberInput(new NumberInputParam(0,param7,param8,45,0,false,true));
         UnknownVarFromValueOrVariableSection_SourceTypeSelectorPreset_1 = param2.createSourceTypeSelector(new SourceTypeSelectorParam(param5,this));
         _picker = param2.createVariablePicker(variableSelectionFilter);
         UnknownVarFromValueOrVariableSection_RadioGroupPreset_1 = param2.createRadioGroup([new RadioButtonParam(0,l("variables.reference_value.set_value"),UnknownVarFromValueOrVariableSection_NumberInputPreset_1),new RadioButtonParam(1,l("variables.reference_value.from_variable"),UnknownVarFromValueOrVariableSection_SourceTypeSelectorPreset_1.alignRight(),_picker)],onChangeRadioOption);
         initializeSection(param6,UnknownVarFromValueOrVariableSection_RadioGroupPreset_1);
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      public function init(param1:UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1, param2:String, param3:int, param4:int, param5:int) : void
      {
         _picker.init(param1,param2,param3);
         _target = param3;
         UnknownVarFromValueOrVariableSection_RadioGroupPreset_1.selected = param4;
         UnknownVarFromValueOrVariableSection_NumberInputPreset_1.value = param5;
      }
      
      public function onEditInitialized() : void
      {
         UnknownVarFromValueOrVariableSection_SourceTypeSelectorPreset_1.select(_target);
      }
      
      public function set target(param1:int) : void
      {
         _target = param1;
         _picker.variableTarget = _target;
      }
      
      public function get target() : int
      {
         return _target;
      }
      
      public function get option() : int
      {
         return UnknownVarFromValueOrVariableSection_RadioGroupPreset_1.selected;
      }
      
      public function get numberValue() : int
      {
         return UnknownVarFromValueOrVariableSection_NumberInputPreset_1.value;
      }
      
      public function get finalizeSelection() : String
      {
         return _picker.finalizeSelection;
      }
      
      private function onChangeRadioOption(param1:int) : void
      {
         _roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,UnknownVarFromValueOrVariableSection_Int_1);
      }
      
      public function isSourcePickingDisabled() : Boolean
      {
         return UnknownVarFromValueOrVariableSection_RadioGroupPreset_1.selected == 0;
      }
      
      public function set sourceType(param1:int) : void
      {
         _roomEvents.wiredCtrl.setMergedSourceType(UnknownVarFromValueOrVariableSection_Int_1,param1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromValueOrVariableSection_RadioGroupPreset_1 = null;
         UnknownVarFromValueOrVariableSection_NumberInputPreset_1 = null;
         _picker = null;
         UnknownVarFromValueOrVariableSection_SourceTypeSelectorPreset_1 = null;
      }
   }
}

