package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class TogglePetRidingPermissionMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromTogglePetRidingPermissionMessageComposer_Int_1:int;
      
      public function TogglePetRidingPermissionMessageComposer(param1:int)
      {
         super();
         UnknownVarFromTogglePetRidingPermissionMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromTogglePetRidingPermissionMessageComposer_Int_1];
      }
   }
}

