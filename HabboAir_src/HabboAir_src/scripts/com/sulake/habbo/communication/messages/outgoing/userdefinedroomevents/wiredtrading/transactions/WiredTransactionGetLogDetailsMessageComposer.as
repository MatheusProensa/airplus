package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.util.Long;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionGetLogDetailsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredTransactionGetLogDetailsMessageComposer_Array_1:Array = [];
      
      public function WiredTransactionGetLogDetailsMessageComposer(param1:Number)
      {
         super();
         UnknownVarFromWiredTransactionGetLogDetailsMessageComposer_Array_1.push(new Long(param1));
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredTransactionGetLogDetailsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredTransactionGetLogDetailsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

