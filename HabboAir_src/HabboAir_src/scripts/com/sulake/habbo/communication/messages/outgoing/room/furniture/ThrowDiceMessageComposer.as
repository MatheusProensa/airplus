package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ThrowDiceMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromThrowDiceMessageComposer_Int_1:int;
      
      public function ThrowDiceMessageComposer(param1:int)
      {
         super();
         UnknownVarFromThrowDiceMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromThrowDiceMessageComposer_Int_1];
      }
   }
}

