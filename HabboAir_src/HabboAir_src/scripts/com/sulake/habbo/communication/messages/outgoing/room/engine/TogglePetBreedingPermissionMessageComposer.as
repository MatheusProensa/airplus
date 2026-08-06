package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class TogglePetBreedingPermissionMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromTogglePetBreedingPermissionMessageComposer_Int_1:int;
      
      public function TogglePetBreedingPermissionMessageComposer(param1:int)
      {
         super();
         UnknownVarFromTogglePetBreedingPermissionMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromTogglePetBreedingPermissionMessageComposer_Int_1];
      }
   }
}

