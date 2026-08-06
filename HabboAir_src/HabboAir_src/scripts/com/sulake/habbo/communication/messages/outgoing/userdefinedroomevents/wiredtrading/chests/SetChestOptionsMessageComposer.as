package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SetChestOptionsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromSetChestOptionsMessageComposer_Array_1:Array = [];
      
      public function SetChestOptionsMessageComposer(param1:int, param2:Boolean, param3:Boolean, param4:int)
      {
         super();
         UnknownVarFromSetChestOptionsMessageComposer_Array_1.push(param1);
         UnknownVarFromSetChestOptionsMessageComposer_Array_1.push(param2);
         UnknownVarFromSetChestOptionsMessageComposer_Array_1.push(param3);
         UnknownVarFromSetChestOptionsMessageComposer_Array_1.push(param4);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromSetChestOptionsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromSetChestOptionsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

