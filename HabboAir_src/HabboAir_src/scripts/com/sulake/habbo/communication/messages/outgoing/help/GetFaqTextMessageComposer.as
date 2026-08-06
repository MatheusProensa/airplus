package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetFaqTextMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetFaqTextMessageComposer_Int_1:int;
      
      public function GetFaqTextMessageComposer(param1:int)
      {
         super();
         UnknownVarFromGetFaqTextMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetFaqTextMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

