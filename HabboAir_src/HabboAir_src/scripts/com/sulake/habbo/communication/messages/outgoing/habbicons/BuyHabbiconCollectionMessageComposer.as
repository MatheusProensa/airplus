package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BuyHabbiconCollectionMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromBuyHabbiconCollectionMessageComposer_Int_1:int;
      
      public function BuyHabbiconCollectionMessageComposer(param1:int)
      {
         super();
         UnknownVarFromBuyHabbiconCollectionMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromBuyHabbiconCollectionMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

