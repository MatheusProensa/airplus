package com.sulake.habbo.communication.messages.outgoing.room.pets
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetPetInfoMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetPetInfoMessageComposer_Int_1:int;
      
      public function GetPetInfoMessageComposer(param1:int)
      {
         super();
         UnknownVarFromGetPetInfoMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetPetInfoMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

