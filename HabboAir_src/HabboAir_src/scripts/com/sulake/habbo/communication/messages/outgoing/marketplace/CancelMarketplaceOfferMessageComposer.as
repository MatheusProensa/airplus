package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CancelMarketplaceOfferMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCancelMarketplaceOfferMessageComposer_Array_1:Array = [];
      
      public function CancelMarketplaceOfferMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromCancelMarketplaceOfferMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCancelMarketplaceOfferMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCancelMarketplaceOfferMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

