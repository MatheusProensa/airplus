package com.sulake.habbo.communication.messages.outgoing.crafting
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetCraftingRecipesAvailableComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetCraftingRecipesAvailableComposer_Array_1:Array;
      
      public function GetCraftingRecipesAvailableComposer(param1:int, param2:Vector.<int>)
      {
         var _loc3_:int = 0;
         UnknownVarFromGetCraftingRecipesAvailableComposer_Array_1 = [];
         super();
         UnknownVarFromGetCraftingRecipesAvailableComposer_Array_1.push(param1);
         UnknownVarFromGetCraftingRecipesAvailableComposer_Array_1.push(param2.length);
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            UnknownVarFromGetCraftingRecipesAvailableComposer_Array_1.push(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetCraftingRecipesAvailableComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetCraftingRecipesAvailableComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

