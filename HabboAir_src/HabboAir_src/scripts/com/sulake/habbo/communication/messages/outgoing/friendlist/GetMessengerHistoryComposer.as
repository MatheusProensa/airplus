package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetMessengerHistoryComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetMessengerHistoryComposer_Array_1:Array = [];
      
      public function GetMessengerHistoryComposer(param1:int, param2:String)
      {
         super();
         this.UnknownVarFromGetMessengerHistoryComposer_Array_1.push(param1);
         this.UnknownVarFromGetMessengerHistoryComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetMessengerHistoryComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetMessengerHistoryComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

