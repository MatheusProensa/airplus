package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ReplenishRespectMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromReplenishRespectMessageComposer_Array_1:Array = [];
      
      public function ReplenishRespectMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromReplenishRespectMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromReplenishRespectMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

