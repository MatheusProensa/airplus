package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetThreadMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetThreadMessageComposer_Array_1:Array = [];
      
      public function GetThreadMessageComposer(param1:int, param2:int)
      {
         super();
         this.UnknownVarFromGetThreadMessageComposer_Array_1 = [param1,param2];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetThreadMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetThreadMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

