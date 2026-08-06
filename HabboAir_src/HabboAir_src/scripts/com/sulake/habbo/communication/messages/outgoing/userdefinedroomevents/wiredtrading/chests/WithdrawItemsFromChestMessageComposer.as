package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   
   [SecureSWF(rename="true")]
   public class WithdrawItemsFromChestMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWithdrawItemsFromChestMessageComposer_Array_1:Array = [];
      
      public function WithdrawItemsFromChestMessageComposer(param1:int, param2:ChestItemType, param3:int)
      {
         super();
         UnknownVarFromWithdrawItemsFromChestMessageComposer_Array_1.push(param1);
         param2.addToComposer(UnknownVarFromWithdrawItemsFromChestMessageComposer_Array_1);
         UnknownVarFromWithdrawItemsFromChestMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWithdrawItemsFromChestMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWithdrawItemsFromChestMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

