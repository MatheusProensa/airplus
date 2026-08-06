package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PetSelectedMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPetSelectedMessageComposer_Int_1:int;
      
      public function PetSelectedMessageComposer(param1:int)
      {
         super();
         UnknownVarFromPetSelectedMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPetSelectedMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

