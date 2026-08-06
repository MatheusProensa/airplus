package com.sulake.habbo.communication.messages.outgoing.room
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ClickCharacterComposer implements IMessageComposer
   {
      private var UnknownVarFromClickCharacterComposer_Int_1:int;
      
      public function ClickCharacterComposer(param1:int)
      {
         super();
         UnknownVarFromClickCharacterComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromClickCharacterComposer_Int_1];
      }
   }
}

