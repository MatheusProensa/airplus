package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class BlockUserMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromBlockUserMessageComposer_Array_1:Array = [];
      
      public function BlockUserMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromBlockUserMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromBlockUserMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromBlockUserMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

