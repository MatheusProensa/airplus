package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class AllVariablesInRoom extends UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1
   {
      private var _hash:int;
      
      private var _variables:Array = null;
      
      public function AllVariablesInRoom(param1:IMessageDataWrapper)
      {
         super();
         _hash = param1.readInteger();
      }
      
      override public function get variables() : Array
      {
         return _variables;
      }
      
      public function get needsSynchronize() : Boolean
      {
         return _variables == null;
      }
      
      public function get hash() : int
      {
         return _hash;
      }
      
      public function synchronize(param1:Vector.<WiredVariable>) : void
      {
         _variables = [];
         for each(var _loc2_ in param1)
         {
            _variables.push(_loc2_);
         }
      }
   }
}

