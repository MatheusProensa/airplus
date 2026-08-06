package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class TriggerHabbiconMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromTriggerHabbiconMessageComposer_Int_1:int;
      
      public function TriggerHabbiconMessageComposer(param1:int)
      {
         super();
         UnknownVarFromTriggerHabbiconMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromTriggerHabbiconMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

