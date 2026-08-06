package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SourceTypeSelectorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ChooseVariableSection extends AbstractSectionPreset implements IWiredInputSourcePicker
   {
      private var _picker:VariablePickerPreset;
      
      private var UnknownVarFromChooseVariableSection_Int_1:int;
      
      private var _target:int;
      
      public function ChooseVariableSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:int, param5:Array, param6:Function, param7:Function, param8:String = null)
      {
         super(param1,param2,param3);
         UnknownVarFromChooseVariableSection_Int_1 = param4;
         var _loc9_:SectionParam = null;
         if(param5 != null)
         {
            _loc9_ = new SectionParam(new SourceTypeSelectorParam(param5,this));
         }
         _picker = param2.createVariablePicker(param6,param7);
         initializeSection(param8 == null ? l("variables.variable_selection") : param8,_picker,_loc9_);
      }
      
      public function init(param1:UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1, param2:String, param3:int) : void
      {
         _picker.init(param1,param2,param3);
         _target = param3;
      }
      
      public function onEditInitialized() : void
      {
         var _loc1_:SourceTypeSelectorPreset = UnknownVarFromAbstractSectionPreset_SectionPreset_1.getSourceTypeSelector();
         if(_loc1_ != null)
         {
            _loc1_.select(_target);
         }
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
      
      public function get finalizeSelection() : String
      {
         return _picker.finalizeSelection;
      }
      
      public function get selected() : WiredVariable
      {
         return _picker.selected;
      }
      
      public function set sourceType(param1:int) : void
      {
         if(UnknownVarFromChooseVariableSection_Int_1 != -1)
         {
            _roomEvents.wiredCtrl.setMergedSourceType(UnknownVarFromChooseVariableSection_Int_1,param1);
         }
         else
         {
            target = param1;
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _picker = null;
      }
   }
}

