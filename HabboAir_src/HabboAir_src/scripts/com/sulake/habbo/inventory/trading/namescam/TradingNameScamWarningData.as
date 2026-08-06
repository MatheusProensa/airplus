package com.sulake.habbo.inventory.trading.namescam
{
   public class TradingNameScamWarningData
   {
      private var _tradedUserId:int;
      
      private var _tradedUserName:String;
      
      private var _tradedUserFigure:String;
      
      private var _similarInRoom:Array;
      
      private var UnknownVarFromTradingNameScamWarningData_Array_1:Array;
      
      public function TradingNameScamWarningData(param1:int, param2:String, param3:String, param4:Array, param5:Array)
      {
         super();
         _tradedUserId = param1;
         _tradedUserName = param2 ?? "";
         _tradedUserFigure = param3 ?? "";
         _similarInRoom = param4 != null ? param4.slice() : [];
         UnknownVarFromTradingNameScamWarningData_Array_1 = param5 != null ? param5.slice() : [];
      }
      
      public function get tradedUserId() : int
      {
         return _tradedUserId;
      }
      
      public function get tradedUserName() : String
      {
         return _tradedUserName;
      }
      
      public function get tradedUserFigure() : String
      {
         return _tradedUserFigure;
      }
      
      public function get similarInRoom() : Array
      {
         return _similarInRoom.slice();
      }
      
      public function get similarInFriends() : Array
      {
         return UnknownVarFromTradingNameScamWarningData_Array_1.slice();
      }
   }
}

