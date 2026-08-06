package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables3;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VariableUpdate extends DefaultTriggerConf implements IWiredInputSourcePicker
   {
      private static var CREATED_INDEX:int = 0;
      
      private static var UnknownVarFromVariableUpdate_Int_1:int = 1;
      
      private static var DELETED_INDEX:int = 2;
      
      private var _section1:SectionPreset;
      
      private var _picker:VariablePickerPreset;
      
      private var _optionGroup:CheckboxGroupPreset;
      
      private var _subOptionGroup:CheckboxGroupPreset;
      
      public function VariableUpdate()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canInterceptChanges;
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.VARIABLE_UPDATE;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc3_:String = param1.variableIds[0];
         var _loc4_:int = WiredInputSourcePicker.USER_SOURCE;
         var _loc2_:WiredVariable = Util.findVariableById(param1.wiredContext.roomVariablesList.variables,_loc3_);
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.variableTarget;
         }
         _section1.getSourceTypeSelector().select(_loc4_);
         _picker.init(param1.wiredContext.roomVariablesList,_loc3_,_loc4_);
         onChangeVariable(_picker.selected);
         _optionGroup.get(CREATED_INDEX).selected = param1.getBoolean(0);
         _optionGroup.get(UnknownVarFromVariableUpdate_Int_1).selected = param1.getBoolean(1);
         _optionGroup.get(DELETED_INDEX).selected = param1.getBoolean(2);
         _subOptionGroup.mask = param1.getInt(3);
      }
      
      private function onChangeVariable(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 == null || param1.canCreateAndDelete;
         var _loc3_:Boolean = param1 != null && (param1.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_2 || param1.availabilityType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables3.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2_Int_6);
         var _loc5_:Boolean = param1 != null && (param1.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_3 || param1.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.INTERNAL);
         var _loc4_:Boolean = param1 == null || param1.hasValue;
         _optionGroup.get(CREATED_INDEX).disabled = !_loc2_ && !_loc3_ && !_loc5_;
         _optionGroup.get(UnknownVarFromVariableUpdate_Int_1).disabled = !_loc4_ && !_loc5_;
         _optionGroup.get(DELETED_INDEX).disabled = !_loc2_ && !_loc3_ && !_loc5_;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:SourceTypeSelectorParam = new SourceTypeSelectorParam([WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,WiredInputSourcePicker.USER_SOURCE,VariableExtraSourceTypes.GLOBAL_SOURCE],this);
         _picker = param1.createVariablePicker(variableSelectionFilter,onChangeVariable);
         var _loc4_:SectionParam = new SectionParam(_loc5_);
         _section1 = param1.createSection(loc("wiredfurni.params.variables.variable_selection"),_picker,_loc4_);
         var _loc6_:Array = [new CheckboxOptionParam(l("variables.trigger_options.0"),CREATED_INDEX),new CheckboxOptionParam(l("variables.trigger_options.1"),UnknownVarFromVariableUpdate_Int_1),new CheckboxOptionParam(l("variables.trigger_options.2"),DELETED_INDEX)];
         _subOptionGroup = param1.createCheckboxGroup([new CheckboxOptionParam(l("variables.trigger_options.1.0"),0),new CheckboxOptionParam(l("variables.trigger_options.1.1"),1),new CheckboxOptionParam(l("variables.trigger_options.1.2"),2)]);
         _loc6_[1].extra2 = _subOptionGroup;
         _optionGroup = param1.createCheckboxGroup(_loc6_);
         var _loc7_:SectionPreset = param1.createSection(l("variables.trigger_options"),_optionGroup);
         param3.addElements(_section1,_loc7_);
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_picker.finalizeSelection];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_optionGroup.get(CREATED_INDEX).selected ? 1 : 0);
         _loc1_.push(_optionGroup.get(UnknownVarFromVariableUpdate_Int_1).selected ? 1 : 0);
         _loc1_.push(_optionGroup.get(DELETED_INDEX).selected ? 1 : 0);
         _loc1_.push(_subOptionGroup.mask);
         return _loc1_;
      }
      
      public function set sourceType(param1:int) : void
      {
         _picker.variableTarget = param1;
      }
   }
}

