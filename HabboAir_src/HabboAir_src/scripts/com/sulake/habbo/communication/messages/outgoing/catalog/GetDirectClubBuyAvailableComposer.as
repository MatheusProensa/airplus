package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetDirectClubBuyAvailableComposer implements IMessageComposer
   {
      private var UnknownVarFromGetDirectClubBuyAvailableComposer_Int_1:int;
      
      public function GetDirectClubBuyAvailableComposer(param1:int)
      {
         super();
         UnknownVarFromGetDirectClubBuyAvailableComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetDirectClubBuyAvailableComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

