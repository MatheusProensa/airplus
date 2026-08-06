package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseBasicMembershipExtensionComposer implements IMessageComposer
   {
      private var UnknownVarFromPurchaseBasicMembershipExtensionComposer_Array_1:Array = [];
      
      public function PurchaseBasicMembershipExtensionComposer(param1:int)
      {
         super();
         UnknownVarFromPurchaseBasicMembershipExtensionComposer_Array_1.push(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return UnknownVarFromPurchaseBasicMembershipExtensionComposer_Array_1;
      }
   }
}

