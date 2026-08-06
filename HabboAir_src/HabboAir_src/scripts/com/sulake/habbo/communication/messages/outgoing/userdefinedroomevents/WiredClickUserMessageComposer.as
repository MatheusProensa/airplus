package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class WiredClickUserMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromWiredClickUserMessageComposer_Array_1:Array = [];
      
      public function WiredClickUserMessageComposer(param1:int)
      {
         super();
         UnknownVarFromWiredClickUserMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromWiredClickUserMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromWiredClickUserMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

