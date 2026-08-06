package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CancelAllMarketplaceOffersMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCancelAllMarketplaceOffersMessageComposer_Array_1:Array = [];
      
      public function CancelAllMarketplaceOffersMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCancelAllMarketplaceOffersMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCancelAllMarketplaceOffersMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

