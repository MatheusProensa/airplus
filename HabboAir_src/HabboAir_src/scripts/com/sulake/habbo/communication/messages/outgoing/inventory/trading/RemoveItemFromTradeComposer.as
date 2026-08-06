package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveItemFromTradeComposer implements IMessageComposer
   {
      private var UnknownVarFromRemoveItemFromTradeComposer_Int_1:int;
      
      public function RemoveItemFromTradeComposer(param1:int)
      {
         super();
         UnknownVarFromRemoveItemFromTradeComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRemoveItemFromTradeComposer_Int_1];
      }
   }
}

