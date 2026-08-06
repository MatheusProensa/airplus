package com.sulake.habbo.communication.messages.outgoing.crafting
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CraftComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCraftComposer_Array_1:Array = [];
      
      public function CraftComposer(param1:int, param2:String)
      {
         super();
         UnknownVarFromCraftComposer_Array_1.push(param1);
         UnknownVarFromCraftComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCraftComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCraftComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

