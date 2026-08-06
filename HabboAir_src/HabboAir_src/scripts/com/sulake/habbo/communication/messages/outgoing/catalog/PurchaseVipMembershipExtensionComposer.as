package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseVipMembershipExtensionComposer implements IMessageComposer
   {
      private var UnknownVarFromPurchaseVipMembershipExtensionComposer_Array_1:Array = [];
      
      public function PurchaseVipMembershipExtensionComposer(param1:int)
      {
         super();
         UnknownVarFromPurchaseVipMembershipExtensionComposer_Array_1.push(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return UnknownVarFromPurchaseVipMembershipExtensionComposer_Array_1;
      }
   }
}

