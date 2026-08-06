package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredGetVariablesForObjectMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredGetVariablesForObjectMessageComposer_Array_1:Array = [];
      
      public function WiredGetVariablesForObjectMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromWiredGetVariablesForObjectMessageComposer_Array_1.push(param1);
         UnknownVarFromWiredGetVariablesForObjectMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredGetVariablesForObjectMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredGetVariablesForObjectMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

