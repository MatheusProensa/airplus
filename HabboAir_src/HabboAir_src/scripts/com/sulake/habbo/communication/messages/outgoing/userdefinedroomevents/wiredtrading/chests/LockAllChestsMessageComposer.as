package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class LockAllChestsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromLockAllChestsMessageComposer_Array_1:Array = [];
      
      public function LockAllChestsMessageComposer(param1:Boolean, param2:Boolean)
      {
         super();
         UnknownVarFromLockAllChestsMessageComposer_Array_1.push(param1);
         UnknownVarFromLockAllChestsMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromLockAllChestsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromLockAllChestsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

