package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LatencyPingRequestMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromLatencyPingRequestMessageComposer_Int_1:int = 0;
      
      public function LatencyPingRequestMessageComposer(param1:int)
      {
         super();
         UnknownVarFromLatencyPingRequestMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromLatencyPingRequestMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

