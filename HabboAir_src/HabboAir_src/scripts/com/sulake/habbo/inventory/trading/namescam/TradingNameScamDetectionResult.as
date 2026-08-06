package com.sulake.habbo.inventory.trading.namescam
{
   public class TradingNameScamDetectionResult
   {
      public static const NO_MATCHES:TradingNameScamDetectionResult = new TradingNameScamDetectionResult(null,null);
      
      private var _similarInRoom:Array;
      
      private var UnknownVarFromTradingNameScamDetectionResult_Array_1:Array;
      
      public function TradingNameScamDetectionResult(param1:Array, param2:Array)
      {
         super();
         _similarInRoom = param1 != null ? param1.slice() : [];
         UnknownVarFromTradingNameScamDetectionResult_Array_1 = param2 != null ? param2.slice() : [];
      }
      
      public function get nameScamDetected() : Boolean
      {
         return _similarInRoom.length > 0 || UnknownVarFromTradingNameScamDetectionResult_Array_1.length > 0;
      }
      
      public function get similarInRoom() : Array
      {
         return _similarInRoom.slice();
      }
      
      public function get similarInFriends() : Array
      {
         return UnknownVarFromTradingNameScamDetectionResult_Array_1.slice();
      }
   }
}

