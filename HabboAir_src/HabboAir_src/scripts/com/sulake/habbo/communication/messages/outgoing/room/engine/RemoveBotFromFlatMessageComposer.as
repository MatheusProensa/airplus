package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveBotFromFlatMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRemoveBotFromFlatMessageComposer_Int_1:int;
      
      public function RemoveBotFromFlatMessageComposer(param1:int)
      {
         super();
         UnknownVarFromRemoveBotFromFlatMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRemoveBotFromFlatMessageComposer_Int_1];
      }
   }
}

