package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class DiceOffMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromDiceOffMessageComposer_Int_1:int;
      
      public function DiceOffMessageComposer(param1:int)
      {
         super();
         UnknownVarFromDiceOffMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromDiceOffMessageComposer_Int_1];
      }
   }
}

