package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UseFurnitureMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromUseFurnitureMessageComposer_Int_1:int;
      
      private var UnknownVarFromUseFurnitureMessageComposer_Int_2:int = 0;
      
      public function UseFurnitureMessageComposer(param1:int, param2:int = 0)
      {
         super();
         UnknownVarFromUseFurnitureMessageComposer_Int_1 = param1;
         UnknownVarFromUseFurnitureMessageComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromUseFurnitureMessageComposer_Int_1,UnknownVarFromUseFurnitureMessageComposer_Int_2];
      }
   }
}

