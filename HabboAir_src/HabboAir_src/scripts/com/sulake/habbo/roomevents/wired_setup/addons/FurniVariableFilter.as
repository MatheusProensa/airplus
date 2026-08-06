package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4;
   
   public class FurniVariableFilter extends VariableFilter
   {
      public function FurniVariableFilter()
      {
         super();
      }
      
      override protected function get variableType() : int
      {
         return UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.FURNI;
      }
      
      override public function get code() : int
      {
         return AddonCodes.FURNI_VARIABLE_FILTER;
      }
   }
}

