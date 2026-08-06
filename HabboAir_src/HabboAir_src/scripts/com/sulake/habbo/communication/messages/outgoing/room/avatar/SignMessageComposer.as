package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SignMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromSignMessageComposer_Int_1:int;
      
      public function SignMessageComposer(param1:int)
      {
         super();
         UnknownVarFromSignMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSignMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

