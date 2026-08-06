package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AddItemToTradeComposer implements IMessageComposer
   {
      private var UnknownVarFromAddItemToTradeComposer_Int_1:int;
      
      public function AddItemToTradeComposer(param1:int)
      {
         super();
         UnknownVarFromAddItemToTradeComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromAddItemToTradeComposer_Int_1];
      }
   }
}

