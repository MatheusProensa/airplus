package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UnmuteUserMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromUnmuteUserMessageComposer_Int_1:int;
      
      private var UnknownVarFromUnmuteUserMessageComposer_Int_2:int = 0;
      
      public function UnmuteUserMessageComposer(param1:int, param2:int = 0)
      {
         super();
         UnknownVarFromUnmuteUserMessageComposer_Int_1 = param1;
         UnknownVarFromUnmuteUserMessageComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromUnmuteUserMessageComposer_Int_1,UnknownVarFromUnmuteUserMessageComposer_Int_2];
      }
   }
}

