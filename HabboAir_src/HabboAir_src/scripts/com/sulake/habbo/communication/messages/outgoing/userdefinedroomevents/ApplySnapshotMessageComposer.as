package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ApplySnapshotMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromApplySnapshotMessageComposer_Array_1:Array = [];
      
      public function ApplySnapshotMessageComposer(param1:int)
      {
         super();
         UnknownVarFromApplySnapshotMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromApplySnapshotMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromApplySnapshotMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

