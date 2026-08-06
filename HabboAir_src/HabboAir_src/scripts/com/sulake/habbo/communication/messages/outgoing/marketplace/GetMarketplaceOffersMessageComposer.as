package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetMarketplaceOffersMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1:Array = [];
      
      public function GetMarketplaceOffersMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean = true)
      {
         super();
         UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1.push(param1);
         UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1.push(param2);
         UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1.push(param3);
         UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1.push(param4);
         UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1.push(param5);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetMarketplaceOffersMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

