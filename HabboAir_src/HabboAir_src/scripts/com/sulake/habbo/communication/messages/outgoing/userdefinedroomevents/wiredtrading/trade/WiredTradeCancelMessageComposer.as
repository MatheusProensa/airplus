package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredTradeCancelMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredTradeCancelMessageComposer_Array_1:Array = [];
      
      public function WiredTradeCancelMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredTradeCancelMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredTradeCancelMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

