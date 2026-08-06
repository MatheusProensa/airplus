package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredUpdateContractMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredUpdateContractMessageComposer_Array_1:Array = [];
      
      public function WiredUpdateContractMessageComposer(param1:Array)
      {
         super();
         UnknownVarFromWiredUpdateContractMessageComposer_Array_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredUpdateContractMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredUpdateContractMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

