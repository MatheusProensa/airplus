package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UnfavoriteHabbiconMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromUnfavoriteHabbiconMessageComposer_Int_1:int;
      
      public function UnfavoriteHabbiconMessageComposer(param1:int)
      {
         super();
         UnknownVarFromUnfavoriteHabbiconMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromUnfavoriteHabbiconMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

