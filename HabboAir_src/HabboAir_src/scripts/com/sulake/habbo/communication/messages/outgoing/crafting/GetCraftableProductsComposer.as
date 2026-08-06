package com.sulake.habbo.communication.messages.outgoing.crafting
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetCraftableProductsComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetCraftableProductsComposer_Array_1:Array = [];
      
      public function GetCraftableProductsComposer(param1:int)
      {
         super();
         UnknownVarFromGetCraftableProductsComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetCraftableProductsComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetCraftableProductsComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

