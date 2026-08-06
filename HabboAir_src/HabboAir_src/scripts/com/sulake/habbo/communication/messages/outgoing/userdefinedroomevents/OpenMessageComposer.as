package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class OpenMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromOpenMessageComposer_Array_1:Array = [];
      
      public function OpenMessageComposer(param1:int)
      {
         super();
         UnknownVarFromOpenMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromOpenMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromOpenMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

