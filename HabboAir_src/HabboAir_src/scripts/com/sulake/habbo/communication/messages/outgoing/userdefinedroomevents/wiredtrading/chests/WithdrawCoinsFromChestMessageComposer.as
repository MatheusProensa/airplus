package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WithdrawCoinsFromChestMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWithdrawCoinsFromChestMessageComposer_Array_1:Array = [];
      
      public function WithdrawCoinsFromChestMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromWithdrawCoinsFromChestMessageComposer_Array_1.push(param1);
         UnknownVarFromWithdrawCoinsFromChestMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWithdrawCoinsFromChestMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWithdrawCoinsFromChestMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

