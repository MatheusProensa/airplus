package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class OpenChestAndGetContentsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromOpenChestAndGetContentsMessageComposer_Array_1:Array = [];
      
      public function OpenChestAndGetContentsMessageComposer(param1:int)
      {
         super();
         UnknownVarFromOpenChestAndGetContentsMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromOpenChestAndGetContentsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromOpenChestAndGetContentsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

