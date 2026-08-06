package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class DailyTaskVariable extends NewDefaultVariableType
   {
      public static var STRING_PARAM_SPLITTER:String = "\t";
      
      private var _variableName:VariableNameSection;
      
      private var UnknownVarFromDailyTaskVariable_TextInputPreset_1:TextInputPreset;
      
      public function DailyTaskVariable()
      {
         super();
      }
      
      override public function get code() : int
      {
         return VariableCodes.UnknownVarFromVariableCodes_Int_4;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _variableName = param1.createVariableNameSection();
         UnknownVarFromDailyTaskVariable_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",100,"1234.."));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.variables.daily_task_name}",UnknownVarFromDailyTaskVariable_TextInputPreset_1);
         param3.addElements(_variableName,_loc4_);
      }
      
      override public function readStringParamFromForm() : String
      {
         return _variableName.variableName + STRING_PARAM_SPLITTER + UnknownVarFromDailyTaskVariable_TextInputPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:Array = param1.stringParam.split(STRING_PARAM_SPLITTER);
         initialVariableName = _loc2_.length > 0 ? _loc2_[0] : "";
         UnknownVarFromDailyTaskVariable_TextInputPreset_1.text = _loc2_.length > 1 ? _loc2_[1] : "";
      }
      
      override protected function get variableNameSection() : VariableNameSection
      {
         return _variableName;
      }
      
      override public function variableType() : int
      {
         return UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.USER;
      }
   }
}

