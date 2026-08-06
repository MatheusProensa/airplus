package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ClaimHabbiconMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromClaimHabbiconMessageComposer_Int_1:int;
      
      public function ClaimHabbiconMessageComposer(param1:int)
      {
         super();
         UnknownVarFromClaimHabbiconMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromClaimHabbiconMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

