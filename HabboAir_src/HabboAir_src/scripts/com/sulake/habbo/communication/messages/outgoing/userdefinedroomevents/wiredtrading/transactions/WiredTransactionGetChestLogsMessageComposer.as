package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionGetChestLogsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredTransactionGetChestLogsMessageComposer_Array_1:Array = [];
      
      public function WiredTransactionGetChestLogsMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         UnknownVarFromWiredTransactionGetChestLogsMessageComposer_Array_1.push(param1);
         UnknownVarFromWiredTransactionGetChestLogsMessageComposer_Array_1.push(param2);
         UnknownVarFromWiredTransactionGetChestLogsMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredTransactionGetChestLogsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredTransactionGetChestLogsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

