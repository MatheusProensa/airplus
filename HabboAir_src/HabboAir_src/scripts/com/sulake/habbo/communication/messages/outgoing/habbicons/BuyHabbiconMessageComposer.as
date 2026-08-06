package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BuyHabbiconMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromBuyHabbiconMessageComposer_Int_1:int;
      
      public function BuyHabbiconMessageComposer(param1:int)
      {
         super();
         UnknownVarFromBuyHabbiconMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromBuyHabbiconMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

