package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CancelEventMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromCancelEventMessageComposer_Array_1:Array = [];
      
      public function CancelEventMessageComposer(param1:int)
      {
         super();
         UnknownVarFromCancelEventMessageComposer_Array_1.push(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return UnknownVarFromCancelEventMessageComposer_Array_1;
      }
   }
}

