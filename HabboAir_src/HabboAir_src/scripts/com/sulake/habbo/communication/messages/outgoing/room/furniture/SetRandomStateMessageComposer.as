package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetRandomStateMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromSetRandomStateMessageComposer_Int_1:int;
      
      private var UnknownVarFromSetRandomStateMessageComposer_Int_2:int = 0;
      
      public function SetRandomStateMessageComposer(param1:int, param2:int = 0)
      {
         super();
         UnknownVarFromSetRandomStateMessageComposer_Int_1 = param1;
         UnknownVarFromSetRandomStateMessageComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetRandomStateMessageComposer_Int_1,UnknownVarFromSetRandomStateMessageComposer_Int_2];
      }
   }
}

