package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LookToMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromLookToMessageComposer_Int_1:int;
      
      private var UnknownVarFromLookToMessageComposer_Int_2:int;
      
      public function LookToMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromLookToMessageComposer_Int_1 = param1;
         UnknownVarFromLookToMessageComposer_Int_2 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromLookToMessageComposer_Int_1,UnknownVarFromLookToMessageComposer_Int_2];
      }
      
      public function dispose() : void
      {
      }
   }
}

