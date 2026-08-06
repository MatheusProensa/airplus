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
   
   public class QuestChainVariable extends NewDefaultVariableType
   {
      public static var STRING_PARAM_SPLITTER:String = "\t";
      
      private var _variableName:VariableNameSection;
      
      private var _questChainName:TextInputPreset;
      
      public function QuestChainVariable()
      {
         super();
      }
      
      override public function get code() : int
      {
         return VariableCodes.UnknownVarFromVariableCodes_Int_3;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc2_:Array = param1.stringParam.split(STRING_PARAM_SPLITTER);
         initialVariableName = _loc2_.length > 0 ? _loc2_[0] : "";
         _questChainName.text = _loc2_.length > 1 ? _loc2_[1] : "";
      }
      
      override public function readStringParamFromForm() : String
      {
         return _variableName.variableName + STRING_PARAM_SPLITTER + _questChainName.text;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _variableName = param1.createVariableNameSection();
         _questChainName = param1.createTextInput(new TextInputParam("",500));
         var _loc4_:SectionPreset = param1.createSection(l("variables.quest_chain_name"),_questChainName);
         param3.addElements(_variableName,_loc4_);
      }
      
      override public function variableType() : int
      {
         return UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.USER;
      }
      
      override protected function get variableNameSection() : VariableNameSection
      {
         return _variableName;
      }
   }
}

