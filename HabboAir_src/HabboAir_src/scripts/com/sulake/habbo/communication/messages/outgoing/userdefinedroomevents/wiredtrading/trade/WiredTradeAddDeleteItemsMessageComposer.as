package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredTradeAddDeleteItemsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredTradeAddDeleteItemsMessageComposer_Array_1:Array = [];
      
      public function WiredTradeAddDeleteItemsMessageComposer(param1:Boolean, param2:Vector.<int>)
      {
         super();
         UnknownVarFromWiredTradeAddDeleteItemsMessageComposer_Array_1.push(param1);
         UnknownVarFromWiredTradeAddDeleteItemsMessageComposer_Array_1.push(param2.length);
         for each(var _loc3_ in param2)
         {
            UnknownVarFromWiredTradeAddDeleteItemsMessageComposer_Array_1.push(_loc3_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredTradeAddDeleteItemsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredTradeAddDeleteItemsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

