package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CloseChestMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCloseChestMessageComposer_Array_1:Array = [];
      
      public function CloseChestMessageComposer(param1:int)
      {
         super();
         UnknownVarFromCloseChestMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCloseChestMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCloseChestMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

