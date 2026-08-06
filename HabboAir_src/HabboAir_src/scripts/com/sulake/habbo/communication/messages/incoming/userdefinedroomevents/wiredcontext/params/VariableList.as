package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class VariableList extends UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1
   {
      private var _variables:Array = [];
      
      public function VariableList(param1:Array)
      {
         super();
         _variables = param1;
      }
      
      public static function createFromMessage(param1:IMessageDataWrapper) : VariableList
      {
         var _loc5_:int = 0;
         var _loc4_:WiredVariable = null;
         var _loc2_:Array = [];
         var _loc3_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new WiredVariable(param1);
            _loc2_.push(_loc4_);
            _loc5_++;
         }
         return new VariableList(_loc2_);
      }
      
      override public function get variables() : Array
      {
         return _variables;
      }
   }
}

