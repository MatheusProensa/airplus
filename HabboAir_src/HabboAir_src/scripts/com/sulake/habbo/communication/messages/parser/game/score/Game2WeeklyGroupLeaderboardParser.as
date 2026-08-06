package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2WeeklyGroupLeaderboardParser extends Game2LeaderboardParser
   {
      private var _year:int;
      
      private var _week:int;
      
      private var _maxOffset:int;
      
      private var _currentOffset:int;
      
      private var _minutesUntilReset:int;
      
      private var _favouriteGroupId:int;
      
      public function Game2WeeklyGroupLeaderboardParser()
      {
         super();
      }
      
      public function get year() : int
      {
         return _year;
      }
      
      public function get week() : int
      {
         return _week;
      }
      
      public function get maxOffset() : int
      {
         return _maxOffset;
      }
      
      public function get currentOffset() : int
      {
         return _currentOffset;
      }
      
      public function get minutesUntilReset() : int
      {
         return _minutesUntilReset;
      }
      
      public function get favouriteGroupId() : int
      {
         return _favouriteGroupId;
      }
      
      override public function flush() : Boolean
      {
         _year = -1;
         _week = -1;
         _maxOffset = -1;
         _currentOffset = -1;
         _minutesUntilReset = -1;
         _favouriteGroupId = -1;
         return super.flush();
      }
      
      override public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _year = param1.readInteger();
         _week = param1.readInteger();
         _maxOffset = param1.readInteger();
         _currentOffset = param1.readInteger();
         _minutesUntilReset = param1.readInteger();
         super.parse(param1);
         _favouriteGroupId = param1.readInteger();
         return true;
      }
   }
}

