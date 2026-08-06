package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetRelationshipStatusMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromSetRelationshipStatusMessageComposer_Int_1:int;
      
      private var UnknownVarFromSetRelationshipStatusMessageComposer_Int_2:int;
      
      public function SetRelationshipStatusMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromSetRelationshipStatusMessageComposer_Int_1 = param1;
         UnknownVarFromSetRelationshipStatusMessageComposer_Int_2 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetRelationshipStatusMessageComposer_Int_1,UnknownVarFromSetRelationshipStatusMessageComposer_Int_2];
      }
      
      public function dispose() : void
      {
      }
   }
}

