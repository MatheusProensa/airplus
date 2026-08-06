package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredOpenContractMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredOpenContractMessageComposer_Array_1:Array = [];
      
      public function WiredOpenContractMessageComposer(param1:int)
      {
         super();
         UnknownVarFromWiredOpenContractMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredOpenContractMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredOpenContractMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

