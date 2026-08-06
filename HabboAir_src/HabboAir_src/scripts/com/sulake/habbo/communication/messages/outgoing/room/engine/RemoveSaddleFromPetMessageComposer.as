package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveSaddleFromPetMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRemoveSaddleFromPetMessageComposer_Int_1:int;
      
      public function RemoveSaddleFromPetMessageComposer(param1:int)
      {
         super();
         UnknownVarFromRemoveSaddleFromPetMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRemoveSaddleFromPetMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

