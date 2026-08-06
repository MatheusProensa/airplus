package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RespectPetMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRespectPetMessageComposer_Array_1:Array = [];
      
      public function RespectPetMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromRespectPetMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRespectPetMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRespectPetMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

