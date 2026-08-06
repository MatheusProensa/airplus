package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpgradeChestMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpgradeChestMessageComposer_Array_1:Array = [];
      
      public function UpgradeChestMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromUpgradeChestMessageComposer_Array_1.push(param1);
         UnknownVarFromUpgradeChestMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpgradeChestMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpgradeChestMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

