package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PlacePetMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPlacePetMessageComposer_Int_1:int;
      
      private var UnknownVarFromPlacePetMessageComposer_Int_2:int;
      
      private var UnknownVarFromPlacePetMessageComposer_Int_3:int;
      
      public function PlacePetMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         UnknownVarFromPlacePetMessageComposer_Int_1 = param1;
         UnknownVarFromPlacePetMessageComposer_Int_2 = param2;
         UnknownVarFromPlacePetMessageComposer_Int_3 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPlacePetMessageComposer_Int_1,UnknownVarFromPlacePetMessageComposer_Int_2,UnknownVarFromPlacePetMessageComposer_Int_3];
      }
   }
}

