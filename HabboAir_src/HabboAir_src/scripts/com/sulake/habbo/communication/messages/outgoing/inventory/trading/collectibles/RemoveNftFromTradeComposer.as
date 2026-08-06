package com.sulake.habbo.communication.messages.outgoing.inventory.trading.collectibles
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveNftFromTradeComposer implements IMessageComposer
   {
      private var UnknownVarFromRemoveNftFromTradeComposer_Int_1:int;
      
      public function RemoveNftFromTradeComposer(param1:int)
      {
         super();
         UnknownVarFromRemoveNftFromTradeComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRemoveNftFromTradeComposer_Int_1];
      }
   }
}

