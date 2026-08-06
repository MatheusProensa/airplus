package com.sulake.habbo.communication.messages.outgoing.crafting
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetCraftingRecipeComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetCraftingRecipeComposer_Array_1:Array = [];
      
      public function GetCraftingRecipeComposer(param1:String)
      {
         super();
         UnknownVarFromGetCraftingRecipeComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetCraftingRecipeComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetCraftingRecipeComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

