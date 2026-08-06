package com.sulake.habbo.tracking
{
   import com.sulake.habbo.communication.messages.outgoing.tracking.LagWarningReportMessageComposer;
   
   public class LagWarningLogger
   {
      private var UnknownVarFromLagWarningLogger_Int_1:int;
      
      private var UnknownVarFromLagWarningLogger_Int_2:int;
      
      private var _habboTracking:HabboTracking;
      
      public function LagWarningLogger(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function chatLagDetected(param1:int) : void
      {
         if(!enabled || warningInterval <= 0)
         {
            return;
         }
         UnknownVarFromLagWarningLogger_Int_2++;
         reportWarningsAsNeeded(param1);
      }
      
      public function update(param1:int) : void
      {
         reportWarningsAsNeeded(param1);
      }
      
      private function reportWarningsAsNeeded(param1:int) : void
      {
         var _loc2_:LagWarningReportMessageComposer = null;
         if(UnknownVarFromLagWarningLogger_Int_2 == 0)
         {
            return;
         }
         if(UnknownVarFromLagWarningLogger_Int_1 == 0 || param1 - UnknownVarFromLagWarningLogger_Int_1 > warningInterval)
         {
            _loc2_ = new LagWarningReportMessageComposer(UnknownVarFromLagWarningLogger_Int_2);
            _habboTracking.send(_loc2_);
            UnknownVarFromLagWarningLogger_Int_1 = param1;
            UnknownVarFromLagWarningLogger_Int_2 = 0;
         }
      }
      
      private function get enabled() : Boolean
      {
         return _habboTracking.getBoolean("lagWarningLog.enabled");
      }
      
      private function get warningInterval() : int
      {
         return _habboTracking.getInteger("lagWarningLog.interval.seconds",10) * 1000;
      }
   }
}

