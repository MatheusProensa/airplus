package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UnblockUserMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUnblockUserMessageComposer_Array_1:Array = [];
      
      public function UnblockUserMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromUnblockUserMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUnblockUserMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUnblockUserMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

