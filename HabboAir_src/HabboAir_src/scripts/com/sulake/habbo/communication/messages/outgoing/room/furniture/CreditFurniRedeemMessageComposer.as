package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CreditFurniRedeemMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromCreditFurniRedeemMessageComposer_Int_1:int;
      
      public function CreditFurniRedeemMessageComposer(param1:int)
      {
         super();
         UnknownVarFromCreditFurniRedeemMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromCreditFurniRedeemMessageComposer_Int_1];
      }
   }
}

