package com.sulake.habbo.tracking
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingRequestMessageComposer;
   import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageParser;
   import flash.utils.getTimer;
   
   public class LatencyTracker implements IComponentInterfaceQueue
   {
      private var UnknownVarFromLatencyTracker_Boolean_1:Boolean = false;
      
      private var UnknownVarFromLatencyTracker_Int_1:int = 0;
      
      private var UnknownVarFromLatencyTracker_Int_2:int = 0;
      
      private var UnknownVarFromLatencyTracker_Int_3:int = 0;
      
      private var UnknownVarFromLatencyTracker_Int_4:int = 0;
      
      private var _lastTestTime:int = 0;
      
      private var UnknownVarFromLatencyTracker_Int_5:int = 0;
      
      private var _latestLatency:int = -1;
      
      private var _latencyValues:Array;
      
      private var UnknownVarFromLatencyTracker_Map_1:Map;
      
      private var _habboTracking:HabboTracking;
      
      public function LatencyTracker(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromLatencyTracker_Boolean_1 = false;
         if(UnknownVarFromLatencyTracker_Map_1 != null)
         {
            UnknownVarFromLatencyTracker_Map_1.dispose();
            UnknownVarFromLatencyTracker_Map_1 = null;
         }
         _latencyValues = null;
         _habboTracking = null;
      }
      
      public function init() : void
      {
         UnknownVarFromLatencyTracker_Int_2 = _habboTracking.getInteger("latencytest.interval",20000);
         UnknownVarFromLatencyTracker_Int_3 = _habboTracking.getInteger("latencytest.report.index",100);
         UnknownVarFromLatencyTracker_Int_4 = _habboTracking.getInteger("latencytest.report.delta",3);
         if(UnknownVarFromLatencyTracker_Int_2 < 1)
         {
            return;
         }
         UnknownVarFromLatencyTracker_Map_1 = new Map();
         _latencyValues = [];
         UnknownVarFromLatencyTracker_Boolean_1 = true;
      }
      
      public function update(param1:uint, param2:int) : void
      {
         if(!UnknownVarFromLatencyTracker_Boolean_1)
         {
            return;
         }
         if(param2 - _lastTestTime > UnknownVarFromLatencyTracker_Int_2)
         {
            testLatency();
         }
      }
      
      private function testLatency() : void
      {
         _lastTestTime = getTimer();
         UnknownVarFromLatencyTracker_Map_1.add(UnknownVarFromLatencyTracker_Int_1,_lastTestTime);
         _habboTracking.send(new LatencyPingRequestMessageComposer(UnknownVarFromLatencyTracker_Int_1));
         UnknownVarFromLatencyTracker_Int_1++;
      }
      
      public function onPingResponse(param1:LatencyPingResponseMessageEvent) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:LatencyPingReportMessageComposer = null;
         if(UnknownVarFromLatencyTracker_Map_1 == null || _latencyValues == null)
         {
            return;
         }
         var _loc4_:LatencyPingResponseMessageParser = param1.getParser();
         var _loc9_:int = UnknownVarFromLatencyTracker_Map_1.getValue(_loc4_.requestId);
         UnknownVarFromLatencyTracker_Map_1.remove(_loc4_.requestId);
         _latencyValues.push(_latestLatency = getTimer() - _loc9_);
         if(_latencyValues.length == UnknownVarFromLatencyTracker_Int_3 && UnknownVarFromLatencyTracker_Int_3 > 0)
         {
            _loc7_ = 0;
            _loc2_ = 0;
            _loc10_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _latencyValues.length)
            {
               _loc7_ += _latencyValues[_loc8_];
               _loc8_++;
            }
            _loc5_ = _loc7_ / _latencyValues.length;
            _loc8_ = 0;
            while(_loc8_ < _latencyValues.length)
            {
               if(_latencyValues[_loc8_] < _loc5_ * 2)
               {
                  _loc2_ += _latencyValues[_loc8_];
                  _loc10_++;
               }
               _loc8_++;
            }
            if(_loc10_ == 0)
            {
               _latencyValues = [];
               return;
            }
            _loc3_ = _loc2_ / _loc10_;
            if(Math.abs(_loc5_ - UnknownVarFromLatencyTracker_Int_5) > UnknownVarFromLatencyTracker_Int_4 || UnknownVarFromLatencyTracker_Int_5 == 0)
            {
               UnknownVarFromLatencyTracker_Int_5 = _loc5_;
               _loc11_ = new LatencyPingReportMessageComposer(_loc5_,_loc3_,_latencyValues.length);
               _habboTracking.send(_loc11_);
            }
            _latencyValues = [];
         }
      }
      
      public function get disposed() : Boolean
      {
         return _habboTracking == null;
      }
      
      public function get latestLatency() : int
      {
         return _latestLatency;
      }
   }
}

