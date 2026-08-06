package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RemoveAllRightsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRemoveAllRightsMessageComposer_Array_1:Array = [];
      
      public function RemoveAllRightsMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromRemoveAllRightsMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRemoveAllRightsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRemoveAllRightsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

