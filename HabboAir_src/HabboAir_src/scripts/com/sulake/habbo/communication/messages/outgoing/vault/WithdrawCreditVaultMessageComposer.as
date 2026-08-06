package com.sulake.habbo.communication.messages.outgoing.vault
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WithdrawCreditVaultMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWithdrawCreditVaultMessageComposer_Array_1:Array = [];
      
      public function WithdrawCreditVaultMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWithdrawCreditVaultMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWithdrawCreditVaultMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

