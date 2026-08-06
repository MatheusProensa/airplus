package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class OpenPetPackageMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromOpenPetPackageMessageComposer_Int_1:int;
      
      private var UnknownVarFromOpenPetPackageMessageComposer_String_1:String;
      
      public function OpenPetPackageMessageComposer(param1:int, param2:String)
      {
         super();
         UnknownVarFromOpenPetPackageMessageComposer_Int_1 = param1;
         UnknownVarFromOpenPetPackageMessageComposer_String_1 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromOpenPetPackageMessageComposer_Int_1,UnknownVarFromOpenPetPackageMessageComposer_String_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

