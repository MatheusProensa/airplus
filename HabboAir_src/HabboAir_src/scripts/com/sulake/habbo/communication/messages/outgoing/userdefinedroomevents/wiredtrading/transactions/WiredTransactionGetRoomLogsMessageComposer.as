package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredTransactionGetRoomLogsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredTransactionGetRoomLogsMessageComposer_Array_1:Array = [];
      
      public function WiredTransactionGetRoomLogsMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromWiredTransactionGetRoomLogsMessageComposer_Array_1.push(param1);
         UnknownVarFromWiredTransactionGetRoomLogsMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredTransactionGetRoomLogsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredTransactionGetRoomLogsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

