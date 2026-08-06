package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class FavoriteHabbiconMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromFavoriteHabbiconMessageComposer_Int_1:int;
      
      public function FavoriteHabbiconMessageComposer(param1:int)
      {
         super();
         UnknownVarFromFavoriteHabbiconMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromFavoriteHabbiconMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

