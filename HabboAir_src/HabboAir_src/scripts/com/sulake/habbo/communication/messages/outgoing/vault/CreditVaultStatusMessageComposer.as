package com.sulake.habbo.communication.messages.outgoing.vault
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CreditVaultStatusMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCreditVaultStatusMessageComposer_Array_1:Array = [];
      
      public function CreditVaultStatusMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCreditVaultStatusMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCreditVaultStatusMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

