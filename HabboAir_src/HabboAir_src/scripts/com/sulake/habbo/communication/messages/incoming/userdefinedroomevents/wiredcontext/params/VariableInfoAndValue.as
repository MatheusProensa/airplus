package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class VariableInfoAndValue
   {
      private var _variable:WiredVariable;
      
      private var _value:int;
      
      public function VariableInfoAndValue(param1:IMessageDataWrapper)
      {
         super();
         _variable = new WiredVariable(param1);
         _value = param1.readInteger();
      }
      
      public function get variable() : WiredVariable
      {
         return _variable;
      }
      
      public function get value() : int
      {
         return _value;
      }
   }
}

