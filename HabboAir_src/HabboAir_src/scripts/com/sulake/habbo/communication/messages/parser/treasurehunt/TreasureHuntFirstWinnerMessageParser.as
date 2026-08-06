package com.sulake.habbo.communication.messages.parser.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFirstWinnerMessageParser implements IMessageParser
   {
      private var _winnerInfo:TreasureHuntWinnerInfo;
      
      public function TreasureHuntFirstWinnerMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _winnerInfo = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _winnerInfo = new TreasureHuntWinnerInfo(param1);
         return true;
      }
      
      public function get winnerInfo() : TreasureHuntWinnerInfo
      {
         return _winnerInfo;
      }
   }
}

