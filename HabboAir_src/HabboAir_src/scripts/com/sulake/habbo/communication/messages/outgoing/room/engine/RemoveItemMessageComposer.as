package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveItemMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRemoveItemMessageComposer_Int_1:int;
      
      public function RemoveItemMessageComposer(param1:int)
      {
         super();
         UnknownVarFromRemoveItemMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRemoveItemMessageComposer_Int_1];
      }
   }
}

