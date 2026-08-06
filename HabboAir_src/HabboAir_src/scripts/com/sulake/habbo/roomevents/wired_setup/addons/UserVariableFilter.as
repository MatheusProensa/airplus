package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4;
   
   public class UserVariableFilter extends VariableFilter
   {
      public function UserVariableFilter()
      {
         super();
      }
      
      override protected function get variableType() : int
      {
         return UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables4.USER;
      }
      
      override public function get code() : int
      {
         return AddonCodes.USER_VARIABLE_FILTER;
      }
   }
}

