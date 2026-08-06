package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class GlobalVariable extends NewDefaultVariableType
   {
      private var _variableName:VariableNameSection;
      
      private var UnknownVarFromGlobalVariable_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromGlobalVariable_TextPreset_1:TextPreset;
      
      public function GlobalVariable()
      {
         super();
      }
      
      override public function get code() : int
      {
         return VariableCodes.GLOBAL_VARIABLE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromGlobalVariable_RadioGroupPreset_1.selected);
         return _loc1_;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc2_:int = int(param1.intParams[0]);
         UnknownVarFromGlobalVariable_RadioGroupPreset_1.selected = _loc2_;
         initialVariableName = param1.stringParam;
         var _loc3_:int = param1.wiredContext.globalVariableInfo.value;
         roomEvents.localization.registerParameter("wiredfurni.params.variables.inspection.current_value","value","" + _loc3_);
      }
      
      override public function readStringParamFromForm() : String
      {
         return _variableName.variableName;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _variableName = param1.createVariableNameSection();
         UnknownVarFromGlobalVariable_TextPreset_1 = param1.createText(l("variables.inspection.current_value"));
         var _loc5_:SectionPreset = param1.createSection(l("variables.inspection"),UnknownVarFromGlobalVariable_TextPreset_1);
         UnknownVarFromGlobalVariable_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("variables.availability.1")),new RadioButtonParam(10,l("variables.availability.10")),new RadioButtonParam(11,l("variables.availability.11"))]);
         var _loc4_:SectionPreset = param1.createSection(l("variables.availability"),UnknownVarFromGlobalVariable_RadioGroupPreset_1);
         param3.addElements(_variableName,_loc5_,_loc4_);
      }
      
      override public function variableType() : int
      {
         return UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4_Int_1;
      }
      
      override protected function get variableNameSection() : VariableNameSection
      {
         return _variableName;
      }
   }
}

