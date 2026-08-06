package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MoveAvatarMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromMoveAvatarMessageComposer_Int_1:int;
      
      private var UnknownVarFromMoveAvatarMessageComposer_Int_2:int;
      
      public function MoveAvatarMessageComposer(param1:int, param2:int)
      {
         super();
         UnknownVarFromMoveAvatarMessageComposer_Int_1 = param1;
         UnknownVarFromMoveAvatarMessageComposer_Int_2 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromMoveAvatarMessageComposer_Int_1,UnknownVarFromMoveAvatarMessageComposer_Int_2];
      }
   }
}

