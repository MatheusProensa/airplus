package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredGetVariableOwnersPageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1:Array = [];
      
      public function WiredGetVariableOwnersPageComposer(param1:String, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1.push(param1);
         UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1.push(param2);
         UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1.push(param3);
         UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1.push(param4);
         UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1.push(param5);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredGetVariableOwnersPageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

