package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class MyRoomHistorySearchMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromMyRoomHistorySearchMessageComposer_Array_1:Array = [];
      
      public function MyRoomHistorySearchMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromMyRoomHistorySearchMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromMyRoomHistorySearchMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

