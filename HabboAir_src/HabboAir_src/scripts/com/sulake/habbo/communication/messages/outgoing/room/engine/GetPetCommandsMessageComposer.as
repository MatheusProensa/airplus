package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetPetCommandsMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetPetCommandsMessageComposer_Int_1:int;
      
      public function GetPetCommandsMessageComposer(param1:int)
      {
         super();
         UnknownVarFromGetPetCommandsMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetPetCommandsMessageComposer_Int_1];
      }
   }
}

