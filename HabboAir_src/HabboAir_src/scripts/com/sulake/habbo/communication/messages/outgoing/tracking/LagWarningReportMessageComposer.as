package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LagWarningReportMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromLagWarningReportMessageComposer_Int_1:int;
      
      public function LagWarningReportMessageComposer(param1:int)
      {
         super();
         UnknownVarFromLagWarningReportMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromLagWarningReportMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

