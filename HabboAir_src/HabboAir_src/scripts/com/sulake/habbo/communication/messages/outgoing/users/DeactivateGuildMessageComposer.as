package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class DeactivateGuildMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromDeactivateGuildMessageComposer_Int_1:int;
      
      public function DeactivateGuildMessageComposer(param1:int)
      {
         super();
         UnknownVarFromDeactivateGuildMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromDeactivateGuildMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

