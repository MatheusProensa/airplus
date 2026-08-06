package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WeeklyGameRewardWinnersParser implements IMessageParser
   {
      private var _gameTypeId:int;
      
      private var _winners:Array = [];
      
      public function WeeklyGameRewardWinnersParser()
      {
         super();
      }
      
      public function get gameTypeId() : int
      {
         return _gameTypeId;
      }
      
      public function get winners() : Array
      {
         return _winners;
      }
      
      public function flush() : Boolean
      {
         _gameTypeId = -1;
         _winners = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _gameTypeId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _winners.push(new GameRewardWinnerEntry(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

