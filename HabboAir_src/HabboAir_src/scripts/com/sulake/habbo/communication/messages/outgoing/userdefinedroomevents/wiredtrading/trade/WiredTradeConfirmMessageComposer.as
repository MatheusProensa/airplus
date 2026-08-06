package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredTradeConfirmMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredTradeConfirmMessageComposer_Array_1:Array = [];
      
      public function WiredTradeConfirmMessageComposer(param1:Boolean)
      {
         super();
         UnknownVarFromWiredTradeConfirmMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredTradeConfirmMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredTradeConfirmMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

