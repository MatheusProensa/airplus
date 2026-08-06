package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class MyFrequentRoomHistorySearchMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromMyFrequentRoomHistorySearchMessageComposer_Array_1:Array = [];
      
      public function MyFrequentRoomHistorySearchMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromMyFrequentRoomHistorySearchMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromMyFrequentRoomHistorySearchMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

