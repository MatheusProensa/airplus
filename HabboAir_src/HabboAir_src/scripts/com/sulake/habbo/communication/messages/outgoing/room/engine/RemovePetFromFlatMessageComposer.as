package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemovePetFromFlatMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRemovePetFromFlatMessageComposer_Int_1:int;
      
      public function RemovePetFromFlatMessageComposer(param1:int)
      {
         super();
         UnknownVarFromRemovePetFromFlatMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRemovePetFromFlatMessageComposer_Int_1];
      }
   }
}

