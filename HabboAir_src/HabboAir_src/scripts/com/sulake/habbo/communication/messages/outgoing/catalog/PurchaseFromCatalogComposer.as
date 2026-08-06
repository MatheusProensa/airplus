package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseFromCatalogComposer implements IMessageComposer
   {
      private var UnknownVarFromPurchaseFromCatalogComposer_Array_1:Array = [];
      
      public function PurchaseFromCatalogComposer(param1:int, param2:int, param3:String, param4:int)
      {
         super();
         UnknownVarFromPurchaseFromCatalogComposer_Array_1.push(param1);
         UnknownVarFromPurchaseFromCatalogComposer_Array_1.push(param2);
         UnknownVarFromPurchaseFromCatalogComposer_Array_1.push(param3);
         UnknownVarFromPurchaseFromCatalogComposer_Array_1.push(param4);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return UnknownVarFromPurchaseFromCatalogComposer_Array_1;
      }
   }
}

