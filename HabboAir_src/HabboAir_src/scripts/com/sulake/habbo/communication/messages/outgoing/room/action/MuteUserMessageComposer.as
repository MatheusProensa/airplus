package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MuteUserMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromMuteUserMessageComposer_Int_1:int;
      
      private var UnknownVarFromMuteUserMessageComposer_Int_2:int = 0;
      
      private var UnknownVarFromMuteUserMessageComposer_Int_3:int;
      
      public function MuteUserMessageComposer(param1:int, param2:int, param3:int = 0)
      {
         super();
         UnknownVarFromMuteUserMessageComposer_Int_1 = param1;
         UnknownVarFromMuteUserMessageComposer_Int_2 = param3;
         UnknownVarFromMuteUserMessageComposer_Int_3 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromMuteUserMessageComposer_Int_1,UnknownVarFromMuteUserMessageComposer_Int_2,UnknownVarFromMuteUserMessageComposer_Int_3];
      }
   }
}

