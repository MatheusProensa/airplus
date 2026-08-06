package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetItemDataMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetItemDataMessageComposer_Int_1:int = 0;
      
      public function GetItemDataMessageComposer(param1:int)
      {
         super();
         UnknownVarFromGetItemDataMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetItemDataMessageComposer_Int_1];
      }
   }
}

