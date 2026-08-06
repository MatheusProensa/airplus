package com.sulake.habbo.communication.messages.outgoing.nft
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetSelectedNftWardrobeOutfitMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetSelectedNftWardrobeOutfitMessageComposer_Array_1:Array = [];
      
      public function GetSelectedNftWardrobeOutfitMessageComposer()
      {
         super();
      }
      
      public function GetUserNftWardrobeMessageComposer() : *
      {
      }
      
      public function getMessageArray() : Array
      {
         return UnknownVarFromGetSelectedNftWardrobeOutfitMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetSelectedNftWardrobeOutfitMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

