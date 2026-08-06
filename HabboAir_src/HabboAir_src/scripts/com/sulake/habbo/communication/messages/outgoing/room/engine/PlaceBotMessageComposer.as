package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PlaceBotMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPlaceBotMessageComposer_Int_1:int;
      
      private var UnknownVarFromPlaceBotMessageComposer_Int_2:int;
      
      private var UnknownVarFromPlaceBotMessageComposer_Int_3:int;
      
      public function PlaceBotMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         UnknownVarFromPlaceBotMessageComposer_Int_1 = param1;
         UnknownVarFromPlaceBotMessageComposer_Int_2 = param2;
         UnknownVarFromPlaceBotMessageComposer_Int_3 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPlaceBotMessageComposer_Int_1,UnknownVarFromPlaceBotMessageComposer_Int_2,UnknownVarFromPlaceBotMessageComposer_Int_3];
      }
   }
}

