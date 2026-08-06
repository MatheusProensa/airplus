package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetMarketplaceOwnOffersMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private static const UnknownConstFromGetMarketplaceOwnOffersMessageComposer_Int_1:int = 1;
      
      private var UnknownVarFromGetMarketplaceOwnOffersMessageComposer_Array_1:Array = [];
      
      public function GetMarketplaceOwnOffersMessageComposer(param1:int = 1)
      {
         super();
         UnknownVarFromGetMarketplaceOwnOffersMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetMarketplaceOwnOffersMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetMarketplaceOwnOffersMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

