package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class BuyMarketplaceOfferMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromBuyMarketplaceOfferMessageComposer_Array_1:Array = [];
      
      public function BuyMarketplaceOfferMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromBuyMarketplaceOfferMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromBuyMarketplaceOfferMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromBuyMarketplaceOfferMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

