package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangePostureMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromChangePostureMessageComposer_Int_1:int;
      
      public function ChangePostureMessageComposer(param1:int)
      {
         super();
         UnknownVarFromChangePostureMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromChangePostureMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

