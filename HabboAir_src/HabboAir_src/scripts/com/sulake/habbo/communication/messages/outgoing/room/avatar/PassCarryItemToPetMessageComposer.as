package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PassCarryItemToPetMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPassCarryItemToPetMessageComposer_Int_1:int;
      
      public function PassCarryItemToPetMessageComposer(param1:int)
      {
         super();
         UnknownVarFromPassCarryItemToPetMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPassCarryItemToPetMessageComposer_Int_1];
      }
   }
}

