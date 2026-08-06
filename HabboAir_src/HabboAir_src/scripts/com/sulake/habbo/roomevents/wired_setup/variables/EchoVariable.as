package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ChooseVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class EchoVariable extends NewDefaultVariableType
   {
      private var _variableName:VariableNameSection;
      
      private var UnknownVarFromEchoVariable_ChooseVariableSection_1:ChooseVariableSection;
      
      private var UnknownVarFromEchoVariable_WiredVariable_1:WiredVariable;
      
      public function EchoVariable()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.variableType != UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_1;
      }
      
      override public function get code() : int
      {
         return VariableCodes.ECHO_VARIABLE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _variableName = param1.createVariableNameSection();
         UnknownVarFromEchoVariable_ChooseVariableSection_1 = param1.createChooseVariableSection(-1,[WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,WiredInputSourcePicker.USER_SOURCE,VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE],variableSelectionFilter,onVariableSelected);
         param3.addElements(_variableName,UnknownVarFromEchoVariable_ChooseVariableSection_1);
      }
      
      override public function readStringParamFromForm() : String
      {
         return _variableName.variableName;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromEchoVariable_ChooseVariableSection_1.finalizeSelection];
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
         UnknownVarFromEchoVariable_ChooseVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc3_,_loc4_);
         UnknownVarFromEchoVariable_WiredVariable_1 = UnknownVarFromEchoVariable_ChooseVariableSection_1.selected;
         initialVariableName = param1.stringParam;
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromEchoVariable_ChooseVariableSection_1.onEditInitialized();
      }
      
      private function onVariableSelected(param1:WiredVariable) : void
      {
         if(_variableName.variableName.length == 0 || UnknownVarFromEchoVariable_WiredVariable_1 != null && defaultEchoVarName(UnknownVarFromEchoVariable_WiredVariable_1) == _variableName.variableName)
         {
            _variableName.variableName = param1 == null ? "" : defaultEchoVarName(param1);
         }
         UnknownVarFromEchoVariable_WiredVariable_1 = param1;
      }
      
      private function defaultEchoVarName(param1:WiredVariable) : String
      {
         return Util.flatVariableName(param1);
      }
      
      override protected function get variableNameSection() : VariableNameSection
      {
         return _variableName;
      }
      
      override public function variableType() : int
      {
         return UnknownVarFromEchoVariable_ChooseVariableSection_1.target;
      }
   }
}

