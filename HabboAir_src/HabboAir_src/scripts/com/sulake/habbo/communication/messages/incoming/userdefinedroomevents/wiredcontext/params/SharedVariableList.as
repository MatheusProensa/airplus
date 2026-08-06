package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.SharedVariable;
   
   public class SharedVariableList extends UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1
   {
      private var _sharedVariables:Array;
      
      private var _variables:Array;
      
      public function SharedVariableList(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         var _loc3_:SharedVariable = null;
         _sharedVariables = [];
         _variables = [];
         super();
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new SharedVariable(param1);
            _sharedVariables.push(_loc3_);
            _variables.push(_loc3_.wiredVariable);
            _loc4_++;
         }
      }
      
      override public function get variables() : Array
      {
         return _variables;
      }
      
      public function get sharedVariables() : Array
      {
         return _sharedVariables;
      }
   }
}

