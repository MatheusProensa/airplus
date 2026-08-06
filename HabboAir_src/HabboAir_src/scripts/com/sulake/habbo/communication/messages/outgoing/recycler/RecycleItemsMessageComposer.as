package com.sulake.habbo.communication.messages.outgoing.recycler
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RecycleItemsMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRecycleItemsMessageComposer_Array_1:Array;
      
      public function RecycleItemsMessageComposer(param1:Array)
      {
         super();
         UnknownVarFromRecycleItemsMessageComposer_Array_1 = [];
         UnknownVarFromRecycleItemsMessageComposer_Array_1.push(param1.length);
         UnknownVarFromRecycleItemsMessageComposer_Array_1 = UnknownVarFromRecycleItemsMessageComposer_Array_1.concat(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return UnknownVarFromRecycleItemsMessageComposer_Array_1;
      }
   }
}

