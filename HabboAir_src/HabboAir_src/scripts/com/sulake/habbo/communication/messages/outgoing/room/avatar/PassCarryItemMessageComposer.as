package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PassCarryItemMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPassCarryItemMessageComposer_Int_1:int;
      
      public function PassCarryItemMessageComposer(param1:int)
      {
         super();
         UnknownVarFromPassCarryItemMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPassCarryItemMessageComposer_Int_1];
      }
   }
}

