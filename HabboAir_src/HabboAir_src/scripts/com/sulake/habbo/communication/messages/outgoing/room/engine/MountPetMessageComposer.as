package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MountPetMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromMountPetMessageComposer_Int_1:int;
      
      private var UnknownVarFromMountPetMessageComposer_Boolean_1:Boolean;
      
      public function MountPetMessageComposer(param1:int, param2:Boolean)
      {
         super();
         UnknownVarFromMountPetMessageComposer_Int_1 = param1;
         UnknownVarFromMountPetMessageComposer_Boolean_1 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromMountPetMessageComposer_Int_1,UnknownVarFromMountPetMessageComposer_Boolean_1];
      }
   }
}

