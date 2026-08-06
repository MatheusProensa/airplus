package com.sulake.habbo.communication.messages.outgoing.vault
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.util.Byte;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class IncomeRewardClaimMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromIncomeRewardClaimMessageComposer_Array_1:Array = [];
      
      public function IncomeRewardClaimMessageComposer(param1:int)
      {
         super();
         UnknownVarFromIncomeRewardClaimMessageComposer_Array_1.push(new Byte(param1));
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromIncomeRewardClaimMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromIncomeRewardClaimMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

