package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PresentOpenMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPresentOpenMessageComposer_Int_1:int;
      
      public function PresentOpenMessageComposer(param1:int)
      {
         super();
         UnknownVarFromPresentOpenMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPresentOpenMessageComposer_Int_1];
      }
   }
}

