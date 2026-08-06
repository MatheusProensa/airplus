package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class KickUserMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromKickUserMessageComposer_Int_1:int;
      
      public function KickUserMessageComposer(param1:int)
      {
         super();
         UnknownVarFromKickUserMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromKickUserMessageComposer_Int_1];
      }
   }
}

