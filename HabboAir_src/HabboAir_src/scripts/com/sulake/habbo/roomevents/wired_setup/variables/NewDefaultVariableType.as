package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables3;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   
   public class NewDefaultVariableType extends DefaultElement implements INewDefaultVariableType
   {
      private var _initialVariableName:String;
      
      public function NewDefaultVariableType()
      {
         super();
      }
      
      protected static function isVariableStored(param1:int) : Boolean
      {
         return param1 == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables3.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2_Int_4 || param1 == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables3.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables2_Int_3;
      }
      
      public function set initialVariableName(param1:String) : void
      {
         _initialVariableName = param1;
         variableNameSection.variableName = param1;
      }
      
      public function get initialVariableName() : String
      {
         return _initialVariableName;
      }
      
      public function variableType() : int
      {
         return 0;
      }
      
      protected function get variableNameSection() : VariableNameSection
      {
         return null;
      }
   }
}

