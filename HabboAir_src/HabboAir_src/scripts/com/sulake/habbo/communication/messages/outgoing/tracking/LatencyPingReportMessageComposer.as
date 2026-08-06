package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LatencyPingReportMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromLatencyPingReportMessageComposer_Int_1:int;
      
      private var UnknownVarFromLatencyPingReportMessageComposer_Int_2:int;
      
      private var UnknownVarFromLatencyPingReportMessageComposer_Int_3:int;
      
      public function LatencyPingReportMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         UnknownVarFromLatencyPingReportMessageComposer_Int_1 = param1;
         UnknownVarFromLatencyPingReportMessageComposer_Int_2 = param2;
         UnknownVarFromLatencyPingReportMessageComposer_Int_3 = param3;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromLatencyPingReportMessageComposer_Int_1,UnknownVarFromLatencyPingReportMessageComposer_Int_2,UnknownVarFromLatencyPingReportMessageComposer_Int_3];
      }
      
      public function dispose() : void
      {
      }
   }
}

