package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FurniVariable extends NewDefaultVariableType
   {
      private var _variableName:VariableNameSection;
      
      private var UnknownVarFromFurniVariable_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromFurniVariable_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      public function FurniVariable()
      {
         super();
      }
      
      override public function get code() : int
      {
         return VariableCodes.UnknownVarFromVariableCodes_Int_1;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromFurniVariable_CheckboxGroupPreset_1.get(0).selected ? 1 : 0);
         _loc1_.push(UnknownVarFromFurniVariable_RadioGroupPreset_1.selected);
         return _loc1_;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc3_:* = param1.intParams[0] != 0;
         var _loc2_:int = int(param1.intParams[1]);
         UnknownVarFromFurniVariable_CheckboxGroupPreset_1.get(0).selected = _loc3_;
         UnknownVarFromFurniVariable_RadioGroupPreset_1.selected = _loc2_;
         initialVariableName = param1.stringParam;
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
         UnknownVarFromFurniVariable_CheckboxGroupPreset_1 = param1.createCheckboxGroup([new CheckboxOptionParam(l("variables.settings.has_value"))]);
         var _loc4_:SectionPreset = param1.createSection(l("variables.settings"),UnknownVarFromFurniVariable_CheckboxGroupPreset_1);
         UnknownVarFromFurniVariable_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(1,l("variables.availability.1")),new RadioButtonParam(10,l("variables.availability.10"))]);
         var _loc5_:SectionPreset = param1.createSection(l("variables.availability"),UnknownVarFromFurniVariable_RadioGroupPreset_1);
         param3.addElements(_variableName,_loc4_,_loc5_);
      }
      
      override public function variableType() : int
      {
         return UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.FURNI;
      }
      
      override protected function get variableNameSection() : VariableNameSection
      {
         return _variableName;
      }
   }
}

