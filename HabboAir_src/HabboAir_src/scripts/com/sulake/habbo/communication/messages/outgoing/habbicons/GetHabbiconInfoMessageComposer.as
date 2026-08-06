package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetHabbiconInfoMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetHabbiconInfoMessageComposer_Int_1:int;
      
      public function GetHabbiconInfoMessageComposer(param1:int)
      {
         super();
         UnknownVarFromGetHabbiconInfoMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetHabbiconInfoMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

