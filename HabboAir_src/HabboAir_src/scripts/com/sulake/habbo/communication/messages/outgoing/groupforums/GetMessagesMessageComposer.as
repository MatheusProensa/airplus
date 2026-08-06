package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetMessagesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetMessagesMessageComposer_Array_1:Array = [];
      
      public function GetMessagesMessageComposer(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         this.UnknownVarFromGetMessagesMessageComposer_Array_1 = [param1,param2,param3,param4];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetMessagesMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetMessagesMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

