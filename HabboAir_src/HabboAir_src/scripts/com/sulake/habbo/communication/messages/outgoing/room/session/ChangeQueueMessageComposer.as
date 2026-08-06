package com.sulake.habbo.communication.messages.outgoing.room.session
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeQueueMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromChangeQueueMessageComposer_Int_1:int;
      
      public function ChangeQueueMessageComposer(param1:int)
      {
         super();
         UnknownVarFromChangeQueueMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromChangeQueueMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return true;
      }
   }
}

